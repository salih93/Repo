using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class KampanyaBedelsizSatir
    {
        public int r_sayac { get; set; }
        public int kampanya_rsayac { get; set; }
        public string malzeme_sinifi { get; set; }
        public string malzeme_kodu { get; set; }

        public decimal Kota { get; set; }
        public string birim { get; set; }
        public decimal miktar_sarti { get; set; }
        public int nokta_uygulama { get; set; }
        public string cid { get; set; }
        public decimal satis_fiyati { get; set; }

        public string grup_kodu { get; set; }
        public string paket { get; set; }
        public string dist { get; set; }
        public string anlasma_durumu { get; set; }
        public string ust_grup { get; set; }
        public string kademe { get; set; }
        public string musteri_tipi { get; set; }

        public int grup_rsayac { get; set; }
        public decimal kalan_miktar { get; set; }

        public string ust_paket { get; set; }
        public string cari_kod { get; set; }
    }

}
