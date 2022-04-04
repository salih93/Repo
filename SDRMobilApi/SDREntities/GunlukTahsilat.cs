using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class GunlukTahsilat
    {
        public string fis_no { get; set; }
        public int cari_sayac { get; set; }
        public string fis_turu { get; set; }
        public DateTime tarih { get; set; }
        public string aktarim_temsilci { get; set; }
        public decimal tl_alacak { get; set; }
        public decimal tl_borc { get; set; }
        public string kasa_kodu { get; set; }
        public string sorumlu { get; set; }
        public string cari_kodu { get; set; }
        public string cari_unvan { get; set; }
    }
}
