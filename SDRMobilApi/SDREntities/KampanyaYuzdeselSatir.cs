using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class KampanyaYuzdeselSatir
    {
        public int r_sayac { get; set; }
        public int kampanya_rsayac { get; set; }
        public string malzeme_sinifi { get; set; }
        public string malzeme_kodu { get; set; }
        public decimal yuzde { get; set; }
        public decimal Kota { get; set; }
        public string birim { get; set; }
        public decimal miktar_sarti { get; set; }
        public int nokta_uygulama { get; set; }
        public string cid { get; set; }

        public decimal satis_fiyati { get; set; }
        public decimal max_yuzde { get; set; }
        public string grup_kodu { get; set; }

        public decimal indirim01 { get; set; }
        public decimal indirim02 { get; set; }
        public decimal indirim03 { get; set; }
        public decimal indirim04 { get; set; }
        public decimal indirim05 { get; set; }
        public decimal indirim06 { get; set; }

    }
}
