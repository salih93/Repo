using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class Ziyaret
    {
        public int id { get; set; }
        public string start_date { get; set; }
        public string end_date { get; set; }
        public double start_longitude { get; set; }
        public double start_latitude { get; set; }
        public double end_longitude { get; set; }
        public double end_latitude { get; set; }
        public string cari_kodu { get; set; }
        public int is_ziyaret_active { get; set; }

        public int rut_detay_sayac { get; set; }
        public int rut_detay_gun { get; set; }
        public decimal fatura_toplam { get; set; }
        public decimal siparis_toplam { get; set; }
        public decimal tahsilat_toplam { get; set; }
        public int ziyaret_tipi_sayac { get; set; }
        public int ziyaret_sonlandirma_tipi_sayac { get; set; }
        public string aciklama { get; set; }

    }
}
