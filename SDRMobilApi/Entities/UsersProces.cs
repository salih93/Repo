using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Entities
{
    public class UsersProces
    {
        public int id { get; set; }
        public int userid { get; set; }
        public string email { get; set; }
        public string token { get; set; }
        public string versiyon_no { get; set; }

        public string IMEI { get; set; }
        public string deviceName { get; set; }
        public string productName { get; set; }
        public string deviceModel { get; set; }

    }
}
