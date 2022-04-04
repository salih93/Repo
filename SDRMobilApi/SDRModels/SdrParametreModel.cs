using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDRModels
{
    public class SdrParametreModel
    {
        public string temsilci_kodu { get; set; }
        public string veritabani_adi { get; set; }
        public string cari_kod { get; set; }
        public DateTime tarih { get; set; }
        public string token { get; set; }
        public string email { get; set; }
    }
}
