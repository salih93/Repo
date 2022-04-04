using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class Malzeme
    {
        public int r_sayac { get; set; }
		public string malzeme_kodu { get; set; }
		public string malzeme_adi { get; set; }
		public string malzeme_sinifi_adi { get; set; }
		public string malzeme_birimi { get; set; }
		public string satinalma_birimi { get; set; }
		public string satis_birimi { get; set; }
		public string depo_birimi { get; set; }
		public string cikis_birimi { get; set; }
		public string birimi { get; set; }
		public string malzeme_sinifi_no { get; set; }
		public decimal kdv_orani { get; set; }
		public string dist_stok_kodu { get; set; }
		public string baz_birim { get; set; }
		public string path { get; set; }
		public int yururlukten_kaldirildi { get; set; }
		public string grup_kodu1 { get; set; }
		public string grup_adi1 { get; set; }
		public string grup_kodu2 { get; set; }
		public string grup_adi2 { get; set; }
		public string grup_kodu3 { get; set; }
		public string grup_adi3 { get; set; }
		public string grup_kodu4 { get; set; }
		public string grup_adi4 { get; set; }
		public string grup_kodu5 { get; set; }
		public string grup_adi5 { get; set; }
		public int fatura_alti_indirimlere_dahil { get; set; }
	}
}
