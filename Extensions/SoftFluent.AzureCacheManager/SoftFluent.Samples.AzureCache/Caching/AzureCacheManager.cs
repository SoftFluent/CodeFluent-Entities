using CodeFluent.Runtime.Caching;
using CodeFluent.Runtime.Utilities;
using Microsoft.ApplicationServer.Caching;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace SoftFluent.Samples.AzureCache.Caching
{
    public class AzureCacheManager : ICacheManager, IDisposable
    {
        private Lazy<DataCacheFactory> _cacheFactory;
        private string _clientName;
        private string _cacheName;
        private bool? _enabled = null;
        private readonly object _lock = new object();

        // Microsoft.ApplicationServer.Caching.Utility
        private static Regex _validRegionName = new Regex("[^\\w\\p{IsHighSurrogates}\\p{IsLowSurrogates}\\d-_]", RegexOptions.Compiled);

        public AzureCacheManager()
        {
            _cacheFactory = new Lazy<DataCacheFactory>(() =>
            {
                DataCacheFactoryConfiguration config = new DataCacheFactoryConfiguration(ClientName);
                return new DataCacheFactory(config);
            }, LazyThreadSafetyMode.ExecutionAndPublication);
        }

        /// <summary>
        /// Gets a value indicating whether this <see cref="SimpleCacheManager"/> is enabled at runtime.
        /// </summary>
        /// <value><c>true</c> if enabled; otherwise, <c>false</c>.</value>
        public virtual bool Enabled
        {
            get
            {
                if (!_enabled.HasValue)
                {
                    _enabled = ConvertUtilities.ToBoolean(System.Configuration.ConfigurationManager.AppSettings[GetType().FullName + ".Enabled"], true);
                }

                return _enabled.Value;
            }
            set
            {
                _enabled = value;
            }
        }

        public string ClientName
        {
            get
            {
                if (_clientName == null)
                {
                    _clientName = System.Configuration.ConfigurationManager.AppSettings[GetType().FullName + ".ClientName"];

                    if (_clientName == null)
                    {
                        _clientName = "default";
                    }
                }
                return _clientName;
            }
            set
            {
                if (_clientName == value)
                    return;

                _clientName = value;
                ResetCacheFactory();
            }
        }

        public string CacheName
        {
            get
            {
                if (_cacheName == null)
                {
                    _cacheName = System.Configuration.ConfigurationManager.AppSettings[GetType().FullName + ".CacheName"];

                    if (_cacheName == null)
                    {
                        _cacheName = "default";
                    }
                }
                return _cacheName;
            }
            set
            {
                _cacheName = value;
            }
        }

        public DataCache Cache
        {
            get
            {
                return _cacheFactory.Value.GetCache(CacheName);
            }
        }

        private void ResetCacheFactory()
        {
            if (_cacheFactory.IsValueCreated)
            {
                _cacheFactory.Value.Dispose();
            }
        }

        private static bool IsRegionNotFoundException(DataCacheException ex)
        {
            // ErrorCode<ERRCA0005>:SubStatus<ES0001>:Region referred to does not exist.
            return ex.ErrorCode == 5;
        }

        protected virtual string BuildKey(string domain, string key)
        {
            return key;
        }

        protected virtual string BuildRegionName(string name)
        {
            // Microsoft.ApplicationServer.Caching.RegionNameProvider.IsSystemRegion
            if (name.StartsWith("Default_Region_"))
            {
                name = "CF_" + name;
            }

            return _validRegionName.Replace(name, "-");
        }

        /// <summary>
        /// Gets the number of items in the cache for a specific domain.
        /// </summary>
        /// <param name="domain">The domain name.</param>
        /// <returns>
        /// The number of items.
        /// </returns>
        public int GetCount(string domain)
        {
            if (!Enabled)
                return 0;

            throw new InvalidOperationException();
        }

        /// <summary>
        /// Adds an entry to the cache, in the specified domain.
        /// </summary>
        /// <param name="domain">The cache entry domain. May not be null.</param><param name="key">The cache entry key.  May not be null.</param><param name="value">The cache entry value.</param><param name="context">The caching context. May be null.</param>
        public void Add(string domain, string key, object value, IDictionary context)
        {
            if (domain == null)
                throw new ArgumentNullException("domain");

            if (key == null)
                throw new ArgumentNullException("key");

            if (!Enabled)
                return;

            int attemptCount = 0;
            key = BuildKey(domain, key);
            domain = BuildRegionName(domain);

            while (attemptCount < 2)
            {
                var dataCache = Cache;
                try
                {
                    dataCache.Put(key, value, domain);
                    return;
                }
                catch (DataCacheException ex)
                {
                    if (IsRegionNotFoundException(ex))
                    {
                        dataCache.CreateRegion(domain);
                    }
                    else
                    {
                        throw;
                    }
                }

                attemptCount++;
            }
        }

        /// <summary>
        /// Gets a cached value from the specified domain.
        /// </summary>
        /// <param name="domain">The domain. May not be null.</param><param name="key">The cache entry key. May not be null.</param>
        /// <returns>
        /// A cache value
        /// </returns>
        public object Get(string domain, string key)
        {
            if (domain == null)
                throw new ArgumentNullException("domain");

            if (key == null)
                throw new ArgumentNullException("key");
            
            if (!Enabled)
                return null;

            try
            {
                key = BuildKey(domain, key);
                return Cache.Get(key, BuildRegionName(domain));
            }
            catch (DataCacheException ex)
            {
                if (IsRegionNotFoundException(ex))
                {
                    return null;
                }

                throw;
            }
        }

        /// <summary>
        /// Removes a cached value from the cache, from the specified domain.
        /// </summary>
        /// <param name="domain">The domain. May not be null.</param><param name="key">The cache entry key. May not be null.</param>
        public void Remove(string domain, string key)
        {
            if (domain == null)
                throw new ArgumentNullException("domain");

            if (key == null)
                throw new ArgumentNullException("key");
            
            if (!Enabled)
                return;

            try
            {
                key = BuildKey(domain, key);
                Cache.Remove(key, BuildRegionName(domain));
            }
            catch (DataCacheException ex)
            {
                if (IsRegionNotFoundException(ex))
                {
                    return;
                }

                throw;
            }
        }

        /// <summary>
        /// Clears the specified domain cache entries.
        /// </summary>
        /// <param name="domain">The domain. May not be null.</param>
        public void Clear(string domain)
        {
            if (domain == null)
                throw new ArgumentNullException("domain");

            if (!Enabled)
                return;

            try
            {
                Cache.ClearRegion(BuildRegionName(domain));
            }
            catch (DataCacheException ex)
            {
                if (IsRegionNotFoundException(ex))
                {
                    return;
                }

                throw;
            }
        }

        /// <summary>
        /// Clears all cache entries from all domains.
        /// </summary>
        public void Clear()
        {
            if (!Enabled)
                return;

            try
            {
                Cache.Clear();
            }
            catch (DataCacheException ex)
            {
                if (IsRegionNotFoundException(ex))
                {
                    return;
                }

                throw;
            }
        }

        /// <summary>
        /// Gets the number of items in the cache
        /// </summary>
        public int Count
        {
            get
            {
                if (!Enabled)
                    return 0;

                throw new InvalidOperationException();
            }
        }

        /// <summary>
        /// Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
        /// </summary>
        public void Dispose()
        {
            if (_cacheFactory.IsValueCreated)
            {
                _cacheFactory.Value.Dispose();
            }
        }
    }

}
