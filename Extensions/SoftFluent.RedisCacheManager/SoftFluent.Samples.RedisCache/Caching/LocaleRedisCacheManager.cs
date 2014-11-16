using StackExchange.Redis;
using System.Threading;

namespace SoftFluent.Samples.RedisCache.Caching
{
    public class LocaleRedisCacheManager : RedisCacheManager
    {
        protected override RedisKey BuildKey(string domain, string key)
        {
            return string.Format("{0}:{1}", base.BuildKey(domain, key), Thread.CurrentThread.CurrentUICulture.LCID);
        }
    }
}
