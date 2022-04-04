using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class KampanyaBedelsizVerilen
    {
        public int r_sayac { get; set; }
        public int kampanya_rsayac { get; set; }
        public string malzeme_kodu { get; set; }
        public decimal miktar { get; set; }

        public string cid { get; set; }
        public string birim { get; set; }
        public string grup_kodu { get; set; }
        public int zorunlu { get; set; }
        public int hayat_kampanya { get; set; }
        public int grup_rsayac { get; set; }

        public string paket { get; set; }
        public int kota { get; set; }
        public string ust_paket { get; set; }        
        
    }
}
