using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SoftFluent.Samples.AzureCache.Caching
{
    public class LocaleAzureCacheManager : AzureCacheManager
    {
        protected override string BuildKey(string domain, string key)
        {
            return string.Format("{0}:{1}", base.BuildKey(domain, key), Thread.CurrentThread.CurrentUICulture.LCID);
        }
    }
}
