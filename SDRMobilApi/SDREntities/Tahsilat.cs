using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class Tahsilat
    {
        public int r_sayac { get; set; }
        public string cid { get; set; }
        public string temsilci_kodu { get; set; }
        public string cari_kodu { get; set; }
        public string tarih { get; set; }
        public string kasa { get; set; }
        public decimal fiyat { get; set; }
        public string fis_tur { get; set; }
        public string mut_no { get; set; }
        public string mut_no2 { get; set; }
        public string mut_no3 { get; set; }
        public string slipno { get; set; }
        public string kartno { get; set; }
        public int android_gps_sayac { get; set; }
        public string aciklama { get; set; }

    }
}
