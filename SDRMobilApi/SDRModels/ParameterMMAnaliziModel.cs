using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDRModels
{
    public class ParameterMMAnaliziModel
    {
        public string temsilci_kodu { get; set; }
        public string veritabani_adi { get; set; }
        public string cari_kod { get; set; }
        public DateTime tarih1 { get; set; }
        public DateTime tarih2 { get; set; }
        public string token { get; set; }
        public string email { get; set; }

    }
}
