using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class KampanyaSecimliGruplar
    {
        public int r_sayac { get; set; }
        public string cid { get; set; }
        public int kampanya_rsayac { get; set; }

        public string grup_kodu { get; set; }
        public string grup_adi { get; set; }
        public string ana_grup_kodu { get; set; }
        public decimal grup_toplam_miktar { get; set; }
        public decimal max_miktar { get; set; }
        public decimal bedelsiz_grup_toplam_miktar { get; set; }
        public int iskonto_hanesi { get; set; }
        public decimal min_miktar { get; set; }
        public int bayi_kota { get; set; }
        public int cari_kota { get; set; }
        
    }
}
