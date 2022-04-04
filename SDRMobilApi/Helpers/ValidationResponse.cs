using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Helpers
{
    public class ValidationResponse
    {
        public bool successful { get; set; }
        public string code { get; set; }
        public string information { get; set; }
        public string result { get; set; }
    }

    public class ValidationResponseList
    {
        public bool successful { get; set; }
        public string code { get; set; }
        public string information { get; set; }
        public List<string> result { get; set; }
    }

}
