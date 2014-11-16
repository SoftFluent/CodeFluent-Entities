using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Formatters.Binary;
using System.Runtime.Serialization.Formatters.Soap;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using CodeFluent.Runtime;
using CodeFluent.Runtime.Caching;
using CodeFluent.Runtime.Utilities;
using Microsoft.SqlServer.Server;
using StackExchange.Redis;

namespace SoftFluent.Samples.RedisCache.Caching
{
    public class RedisCacheManager : ICacheManager, IDisposable
    {
        // http://azure.microsoft.com/en-us/documentation/articles/cache-dotnet-how-to-use-azure-redis-cache/
        // Dependencies: 
        //   - Install-Package StackExchange.Redis
        //
        // Configuration (app.config or web.config):
        //    <appSettings>
        //      <add key="SoftFluent.Samples.RedisCache.Caching.RedisCacheManager.Configuration" value="<cache url>,allowAdmin=true,ssl=true,password=<password>" />
        //      <add key="SoftFluent.Samples.RedisCache.Caching.LocaleRedisCacheManager.Configuration" value="<cache url>,allowAdmin=true,ssl=true,password=<password>" />
        //    </appSettings>

        private const string Separator = "::";
        private string _configuration;
        private Lazy<ConnectionMultiplexer> _connection;
        private bool? _enabled;
        private byte[] _scriptClearDomainHash;
        private byte[] _scriptCountHash;
        private PersistenceSerializationMode? _serializationMode;

        public RedisCacheManager()
        {
            _connection = new Lazy<ConnectionMultiplexer>(() => ConnectionMultiplexer.Connect(Configuration));
        }

        public string Configuration
        {
            get
            {
                if (_configuration == null)
                {
                    _configuration = ConfigurationManager.AppSettings[GetType().FullName + ".Configuration"];
                    if (_configuration == null)
                        throw new InvalidOperationException("RedisCacheManager is not configured.");
                }

                return _configuration;
            }
            set { _configuration = value; }
        }

        public virtual bool Enabled
        {
            get
            {
                if (!_enabled.HasValue)
                {
                    _enabled = ConvertUtilities.ToBoolean(ConfigurationManager.AppSettings[GetType().FullName + ".Enabled"], true);
                }

                return _enabled.Value;
            }
            set { _enabled = value; }
        }

        public virtual PersistenceSerializationMode SerializationMode
        {
            get
            {
                if (!_serializationMode.HasValue)
                {
                    _serializationMode = ConvertUtilities.ChangeType(ConfigurationManager.AppSettings[GetType().FullName + ".SerializationMode"], PersistenceSerializationMode.Default);
                }

                return _serializationMode.Value;
            }
            set { _serializationMode = value; }
        }

        public ConnectionMultiplexer ConnectionMultiplexer
        {
            get { return _connection.Value; }
        }

        public IDatabase Database
        {
            get { return ConnectionMultiplexer.GetDatabase(); }
        }

        public IServer Server
        {
            get { return Servers.FirstOrDefault(); }
        }

        public IEnumerable<IServer> Servers
        {
            get
            {
                foreach (EndPoint endPoint in ConnectionMultiplexer.GetEndPoints())
                {
                    yield return ConnectionMultiplexer.GetServer(endPoint);
                }
            }
        }

        public virtual void Add(string domain, string key, object value, IDictionary context)
        {
            if (domain == null) throw new ArgumentNullException("domain");
            if (key == null) throw new ArgumentNullException("key");

            if (!Enabled)
                return;

            RedisKey redisKey = BuildKey(domain, key);
            RedisValue redisValue = Serialize(value);
            if (redisValue.IsNull)
            {
                Database.ListLeftPush(redisKey, redisValue);
            }
            else
            {
                Database.ListLeftPush(redisKey, redisValue);
                Database.ListLeftPush(redisKey, value.GetType().AssemblyQualifiedName);
            }
        }

        public virtual void Clear()
        {
            if (!Enabled)
                return;

            Server.FlushAllDatabases();
        }

        public virtual void Clear(string domain)
        {
            if (!Enabled)
                return;

            const string script =
                @"local keys = redis.call('keys', ARGV[1])
              for i = 1,#keys,5000 do 
                redis.call('del', unpack(keys, i, math.min(i + 4999, #keys))) 
              end";

            try
            {
                if (_scriptClearDomainHash == null)
                {
                    _scriptClearDomainHash = Server.ScriptLoad(script);
                }

                Database.ScriptEvaluate(_scriptClearDomainHash, values: new RedisValue[] { (string)BuildKey(domain, "*") });
            }
            catch (RedisException ex)
            {
                if (IsNoScriptException(ex))
                {
                    _scriptClearDomainHash = null;
                    Clear(domain);
                    return;
                }

                throw;
            }
        }

        public virtual object Get(string domain, string key)
        {
            if (domain == null) throw new ArgumentNullException("domain");
            if (key == null) throw new ArgumentNullException("key");

            if (!Enabled)
                return null;

            RedisKey redisKey = BuildKey(domain, key);
            RedisValue[] values = Database.ListRange(redisKey, 0, 1);
            if (values == null || values.Length < 2)
                return null;

            RedisValue typeNameValue = values[0];
            if (typeNameValue.IsNullOrEmpty)
                return null;

            Type type = Type.GetType(typeNameValue, false);
            if (type == null)
                return null;

            RedisValue serializedValue = values[1];
            return Deserialize(serializedValue, type);
        }

        public virtual int Count
        {
            get
            {
                return ExecuteGetCount("*");
            }
        }

        public virtual int GetCount(string domain)
        {
            return ExecuteGetCount(BuildKey(domain, "*"));
        }

        public virtual void Remove(string domain, string key)
        {
            if (domain == null) throw new ArgumentNullException("domain");
            if (key == null) throw new ArgumentNullException("key");

            if (!Enabled)
                return;

            Database.KeyDelete(BuildKey(domain, key));
        }

        public virtual void Dispose()
        {
            if (_connection != null && _connection.IsValueCreated)
            {
                _connection.Value.Dispose();
                _connection = null;
            }
        }

        protected virtual RedisValue Serialize(object value)
        {
            if (value == null)
            {
                return RedisValue.Null;
            }

            return SerializeObject(value, value.GetType(), SerializationMode);
        }

        protected virtual object Deserialize(RedisValue value, Type type)
        {
            if (!value.HasValue || value.IsNull)
            {
                return null;
            }

            return DeserializeObject((byte[])value, type, null, SerializationMode);
        }

        protected virtual RedisKey BuildKey(string domain, string key)
        {
            return domain + Separator + key;
        }

        private int ExecuteGetCount(string key)
        {
            if (!Enabled)
                return 0;

            const string script = @"return table.getn(redis.call('keys', ARGV[1]))";

            try
            {
                if (_scriptCountHash == null)
                {
                    _scriptCountHash = Server.ScriptLoad(script);
                }

                return (int)Database.ScriptEvaluate(_scriptCountHash, values: new RedisValue[] { key });
            }
            catch (RedisException ex)
            {
                if (IsNoScriptException(ex))
                {
                    _scriptCountHash = null;
                    return ExecuteGetCount(key);
                }

                throw;
            }
        }

        private static bool IsNoScriptException(Exception ex)
        {
            return ex is RedisServerException && ex.Message.Contains("NOSCRIPT");
        }

        protected virtual byte[] SerializeObject(object value, Type type, PersistenceSerializationMode serializationMode)
        {
            if (value == null)
                return null;

            IBinarySerialize bs = value as IBinarySerialize;
            if (bs != null)
            {
                using (MemoryStream stream = new MemoryStream())
                {
                    using (BinaryWriter writer = new BinaryWriter(stream))
                    {
                        bs.Write(writer);
                    }
                    return stream.ToArray();
                }
            }


            if ((serializationMode & PersistenceSerializationMode.ModeMask) == PersistenceSerializationMode.Custom)
            {
                // note: value not null here
                object o = type.Assembly.CreateInstance(type.FullName, false);
                ICodeFluentSerializable serializable = o as ICodeFluentSerializable;
                if (serializable == null)
                    throw new Exception(string.Format("Type '{0}' does not implement the ICodeFluentSerializable interface.", type.FullName));

                return ConvertUtilities.ChangeType(serializable.Serialize(serializationMode), (byte[])null);
            }

            using (MemoryStream stream = new MemoryStream())
            {
                switch ((serializationMode & PersistenceSerializationMode.ModeMask))
                {
                    case PersistenceSerializationMode.Xml:
                        if (type == null)
                            throw new ArgumentNullException("type");

                        XmlSerializer serializer = new XmlSerializer(type);
                        serializer.Serialize(stream, value);
                        break;

                    case PersistenceSerializationMode.Soap:
                        SoapFormatter soapFormatter = new SoapFormatter();
                        soapFormatter.Serialize(stream, value);
                        break;

                    case PersistenceSerializationMode.Binary:
                        BinaryFormatter binaryFormatter = new BinaryFormatter();
                        binaryFormatter.Serialize(stream, value);
                        break;

                    default:
                        throw new ArgumentOutOfRangeException("serializationMode", string.Format("Serialization mode '{0}' is not supported.", serializationMode));
                }
                return stream.ToArray();
            }
        }

        protected virtual object DeserializeObject(object value, Type type, object defaultValue, PersistenceSerializationMode serializationMode)
        {
            if (type == null)
                throw new ArgumentNullException("type");

            if ((serializationMode & PersistenceSerializationMode.ModeMask) == PersistenceSerializationMode.None)
                return ConvertUtilities.ChangeType(value, type);

            if (value == null)
                return ConvertUtilities.ChangeType(defaultValue, type);

            if (type.IsInstanceOfType(value))
                return value;

            byte[] bytes;
            if (typeof(XmlDocument).IsAssignableFrom(type))
            {
                string str = value as string;
                if (str != null)
                {
                    XmlDocument doc = new XmlDocument();
                    string svalue = str;
                    if (svalue.Trim().Length > 0)
                    {
                        doc.LoadXml(svalue);
                    }
                    return doc;
                }

                bytes = value as byte[];
                if (bytes != null)
                {
                    XmlDocument doc = new XmlDocument();
                    if (bytes.Length > 0)
                    {
                        using (MemoryStream stream = new MemoryStream(bytes))
                        {
                            doc.Load(stream);
                        }
                    }
                    return doc;
                }
            }

            if (typeof(IBinarySerialize).IsAssignableFrom(type))
            {
                string str = value as string;
                if (str != null)
                {
                    object o = type.Assembly.CreateInstance(type.FullName, false);
                    IBinarySerialize serializable = o as IBinarySerialize;
                    if (serializable != null)
                    {
                        using (MemoryStream ms = new MemoryStream(Convert.FromBase64String(str)))
                        {
                            using (BinaryReader binaryReader = new BinaryReader(ms))
                            {
                                serializable.Read(binaryReader);
                                return ConvertUtilities.ChangeType(o, type);
                            }
                        }
                    }
                }
                else
                {
                    bytes = value as byte[];
                    if (bytes != null)
                    {
                        object o = type.Assembly.CreateInstance(type.FullName, false);
                        IBinarySerialize serializable = o as IBinarySerialize;
                        if (serializable != null)
                        {
                            using (MemoryStream stream = new MemoryStream(bytes))
                            {
                                using (BinaryReader binaryReader = new BinaryReader(stream))
                                {
                                    serializable.Read(binaryReader);
                                    return ConvertUtilities.ChangeType(o, type);
                                }
                            }
                        }
                    }
                }
            }

            if ((serializationMode & PersistenceSerializationMode.ModeMask) == PersistenceSerializationMode.Custom)
            {
                // note: value not null here
                object o = type.Assembly.CreateInstance(type.FullName, false);
                ICodeFluentSerializable serializable = o as ICodeFluentSerializable;
                if (serializable == null)
                    throw new Exception(string.Format("Type '{0}' does not implement the ICodeFluentSerializable interface.", type.FullName));

                return serializable.Deserialize(type, serializationMode, value);
            }

            bytes = value as byte[];
            if (bytes != null)
            {
                if (bytes.Length == 0)
                    return ConvertUtilities.ChangeType(defaultValue, type);

                using (MemoryStream stream = new MemoryStream(bytes))
                {
                    switch ((serializationMode & PersistenceSerializationMode.ModeMask))
                    {
                        case PersistenceSerializationMode.Xml:
                            XmlSerializer serializer = new XmlSerializer(type);
                            return serializer.Deserialize(stream);

                        case PersistenceSerializationMode.Soap:
                            SoapFormatter soapFormatter = new SoapFormatter();
                            return ConvertUtilities.ChangeType(soapFormatter.Deserialize(stream), type);

                        case PersistenceSerializationMode.Binary:
                            BinaryFormatter binaryFormatter = new BinaryFormatter();
                            return ConvertUtilities.ChangeType(binaryFormatter.Deserialize(stream), type);

                        default:
                            throw new ArgumentOutOfRangeException("serializationMode", string.Format("Serialization mode '{0}' is not supported.", serializationMode));
                    }
                }
            }

            string s = value as string;
            if (s != null)
            {
                if (s.Length == 0)
                    return ConvertUtilities.ChangeType(defaultValue, type);

                switch ((serializationMode & PersistenceSerializationMode.ModeMask))
                {
                    case PersistenceSerializationMode.Xml:
                        using (StringReader sr = new StringReader(s))
                        {
                            XmlSerializer serializer = new XmlSerializer(type);
                            return serializer.Deserialize(sr);
                        }

                    case PersistenceSerializationMode.Soap:
                        SoapFormatter soapFormatter = new SoapFormatter();
                        using (MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(s)))
                        {
                            return ConvertUtilities.ChangeType(soapFormatter.Deserialize(ms), type);
                        }

                    case PersistenceSerializationMode.Binary:
                        BinaryFormatter binaryFormatter = new BinaryFormatter();
                        using (MemoryStream ms = new MemoryStream(Convert.FromBase64String(s)))
                        {
                            return ConvertUtilities.ChangeType(binaryFormatter.Deserialize(ms), type);
                        }

                    default:
                        throw new ArgumentOutOfRangeException("serializationMode", string.Format("Serialization mode '{0}' is not supported.", serializationMode));
                }
            }

            return ConvertUtilities.ChangeType(value, type, defaultValue);
        }
    }
}