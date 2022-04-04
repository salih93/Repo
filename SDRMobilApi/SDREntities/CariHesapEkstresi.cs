using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class CariHesapEkstresi
    {
        [Key]
        public int Id { get; set; }
        public string cari_kodu { get; set; }
        public string cari_unvan { get; set; }
        public string evrak_tarihi { get; set; }
        public string fis_no { get; set; }
        public string resmi_belge_no { get; set; }
        public string aciklama { get; set; }
        public decimal borc { get; set; }
        public decimal alacak { get; set; }
        public decimal bakiye { get; set; }
        public string bakiye_borc_alacak { get; set; }
        public string vade_tarihi { get; set; }
        public string fis_turu { get; set; }
    }

}
