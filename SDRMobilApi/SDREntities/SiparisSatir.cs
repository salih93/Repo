using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class SiparisSatir
    {
        public int r_sayac { get; set; }
        public int mus_rsayac { get; set; }
        public string cid { get; set; }
        public int sira_no { get; set; }
        public int satir_id { get; set; }
        public int r_trg { get; set; }
        public int return_sayac { get; set; }
        public int sevk_plani_no { get; set; }
        public decimal irsaliye_miktari { get; set; }
        public decimal masraf01 { get; set; }
        public decimal masraf02 { get; set; }
        public decimal masraf03 { get; set; }
        public decimal toplam_masraf { get; set; }
        public string masraflar { get; set; }
        public int miscellenous_update { get; set; }
        public int malzeme_rsayac { get; set; }
        public decimal artan_miktar { get; set; }
        public decimal iade_miktari { get; set; }
        public decimal sevk_plani_miktari { get; set; }
        public int toplama_listesi_olustu { get; set; }
        public decimal alt_birim_adedi { get; set; }
        public int artan_top_sayisi { get; set; }
        public int toplama_listesi_top_sayisi { get; set; }
        public int kalan_top_sayisi { get; set; }
        public int proforma_no { get; set; }
        public int irsaliye_rsayac { get; set; }
        public string malzeme_kodu { get; set; }
        public string birimi { get; set; }
        public decimal birim_fiyat { get; set; }
        public int fiyat_tanimi_rsayac { get; set; }
        public decimal sevk_kalan_miktar { get; set; }
        public decimal miktar { get; set; }
        public string indirim { get; set; }
        public string asama { get; set; }
        public string sevk_tarihi { get; set; }
        public string teslim_tarihi { get; set; }
        public decimal fatura_edilen_miktar { get; set; }
        public int bedelsiz { get; set; }
        public int indirim01_flag { get; set; }
        public decimal indirim01 { get; set; }
        public int indirim02_flag { get; set; }
        public decimal indirim02 { get; set; }
        public int indirim03_flag { get; set; }
        public decimal indirim03 { get; set; }
        public int indirim04_flag { get; set; }
        public decimal indirim04 { get; set; }
        public int indirim05_flag { get; set; }
        public decimal indirim05 { get; set; }
        public int indirim06_flag { get; set; }
        public decimal indirim06 { get; set; }
        public decimal toplam_indirim { get; set; }
        public decimal std_doviz_kuru { get; set; }
        public decimal doviz_birim_fiyati { get; set; }
        public decimal doviz_tutar { get; set; }
        public decimal doviz_satir_tutari { get; set; }
        public decimal doviz_kdv_miktari { get; set; }
        public decimal satir_tutari { get; set; }
        public string sablon_kodu { get; set; }
        public decimal kdv_orani { get; set; }
        public decimal kdv_tutari { get; set; }
        public decimal tutar { get; set; }
        public string depo_no { get; set; }
        public string tesis_no { get; set; }
        public string stok_tipi_no { get; set; }
        public string grup_kodu { get; set; }
        public string indirim_kodu { get; set; }
        public int kolibasi_kampanya_flag { get; set; }
        public int bedelsiz_kampanya_flag { get; set; }
        public int yuzdesel_kampanya_flag { get; set; }
        public int depozito { get; set; }
        public string depozito_parent_id { get; set; }
        public int depozito_sira_no { get; set; }
        public int kolibasi_kosul { get; set; }
        public string kolibasi_cari_kod { get; set; }
        public string bedelsiz_tpr { get; set; }
        public string bedelsiz_paket { get; set; }
        public string aciklama { get; set; }


    }
}
