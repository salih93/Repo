using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class CariVadeFarki
    {
        [Key]
        public int Id { get; set; }
        public string cari_kodu { get; set; }
        public string cari_unvan { get; set; }
        public int fatura_no { get; set; }
        public string islem_tipi { get; set; }
        public string vade_tarihi { get; set; }
        public string fis_tarihi { get; set; }
        public string tahsilat_gecikti { get; set; }
        public decimal tefat_tutari { get; set; }
        public decimal tefat_bakiye_tutari { get; set; }
        public decimal bakiye_toplami { get; set; }
        public int gecikme_gunu { get; set; }
        public int vade_gun_sayisi { get; set; }

        public string borc_alacak { get; set; }
        public string son_bakiye_bakod { get; set; }        
        

    }
}
