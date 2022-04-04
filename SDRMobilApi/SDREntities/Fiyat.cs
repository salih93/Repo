using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class Fiyat
    {
        public string kod { get; set; }
        public string fiyat_tipi { get; set; }
        public string para_birimi { get; set; }
        public int fiyat1 { get; set; }
        public int fiyat2 { get; set; }
        public int fiyat3 { get; set; }
        public int fiyat4 { get; set; }
        public int fiyat5 { get; set; }
        public int kdvli_fiyat1 { get; set; }
        public int kdvli_fiyat2 { get; set; }
        public int kdvli_fiyat3 { get; set; }
        public int kdvli_fiyat4 { get; set; }
        public int kdvli_fiyat5 { get; set; }
        public int vade1 { get; set; }
        public int vade2 { get; set; }
        public int vade3 { get; set; }
        public int vade4 { get; set; }
        public int vade5 { get; set; }
        public int iskonto1 { get; set; }
        public int iskonto2 { get; set; }
        public int iskonto3 { get; set; }
        public int iskonto4 { get; set; }
        public int iskonto5 { get; set; }
        public int iskonto6 { get; set; }
        public int genel_iskonto_yuzde { get; set; }
        public decimal genel_iskonto_tutar { get; set; }
        public decimal fiyat_tutar1 { get; set; }
        public decimal fiyat_tutar2 { get; set; }
        public decimal fiyat_tutar3 { get; set; }
        public decimal fiyat_tutar4 { get; set; }
        public decimal fiyat_tutar5 { get; set; }
        public string vade_kodu1 { get; set; }
        public string vade_kodu2 { get; set; }
        public string vade_kodu3 { get; set; }
        public string vade_kodu4 { get; set; }
        public string vade_kodu5 { get; set; }
        public decimal iskonto_tutari1 { get; set; }
        public decimal iskonto_tutari2 { get; set; }
        public decimal iskonto_tutari3 { get; set; }
        public decimal iskonto_tutari4 { get; set; }
        public decimal iskonto_tutari5 { get; set; }
        public decimal iskonto_tutari6 { get; set; }
        public int indirim01_flag { get; set; }
        public int indirim02_flag { get; set; }
        public int indirim03_flag { get; set; }
        public int indirim04_flag { get; set; }
        public int indirim05_flag { get; set; }
        public int indirim06_flag { get; set; }
        public string cid { get; set; }
        public int birim_fiyat_degistir { get; set; }
        public int gen_iskonto_degistir { get; set; }
        public int satir_iskonto_degistir { get; set; }
        public int vade_degistir { get; set; }
        public int ortalama_tarih_hesapla { get; set; }
        public string liste_adi { get; set; }
        public string liste_birim { get; set; }
        public string baz_birim { get; set; }
        public string malzeme_kodu { get; set; }
        public string satis_tipi { get; set; }
        public decimal stok_miktari { get; set; }
        public string barkod { get; set; }

        public string malzeme_adi { get; set; }
        public string grup_adi1 { get; set; }
        public string grup_adi2 { get; set; }
        public string grup_adi3 { get; set; }
        public decimal kdv_orani { get; set; }


    }
}
