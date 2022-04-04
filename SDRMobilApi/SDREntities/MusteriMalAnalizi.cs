using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class MusteriMalAnalizi
    {
        public string musteri_kodu { get; set; }
        public string malzeme_kodu { get; set; }
        public string malzeme_adi { get; set; }
        public string birimi { get; set; }
        public string baz_birim { get; set; }
        public string malzeme_sinifi_no { get; set; }
        public string malzeme_sinifi_adi { get; set; }
        public string grup_kodu1 { get; set; }
        public string grup_kodu2 { get; set; }
        public string grup_kodu3 { get; set; }
        public string grup_kodu4 { get; set; }
        public string grup_kodu5 { get; set; }

        public string grup_adi1 { get; set; }
        public string grup_adi2 { get; set; }
        public string grup_adi3 { get; set; }
        public string grup_adi4 { get; set; }
        public string grup_adi5 { get; set; }

        public string satis_tip_id { get; set; }
        public string satis_tipi_adi { get; set; }
        public string depo_no { get; set; }
        public string depo_adi { get; set; }
        public string rapor_birimi { get; set; }

        public decimal satis_miktari { get; set; }
        public decimal satis_brut_tutar { get; set; }
        public decimal satis_indirim_tutari { get; set; }
        public decimal satis_kdv_tutari { get; set; }
        public decimal satis_masraf_tutari { get; set; }

        public decimal satis_kdv_oncesi_tutar { get; set; }
        public decimal satis_satir_tutari { get; set; }
        public decimal iade_miktari { get; set; }
        public decimal iade_brut_tutar { get; set; }
        public decimal iade_indirim_tutari { get; set; }
        public decimal iade_kdv_tutari { get; set; }

        public decimal iade_kdv_oncesi_tutar { get; set; }
        public decimal iade_satir_tutari { get; set; }
        public decimal net_miktar { get; set; }
        public decimal net_brut_tutar { get; set; }
        public decimal net_indirim_tutari { get; set; }
        public decimal net_kdv_tutari { get; set; }
        public decimal net_kdv_oncesi_tutar { get; set; }
        public decimal net_satir_tutari { get; set; }
        public DateTime tarih { get; set; }

    }
}
