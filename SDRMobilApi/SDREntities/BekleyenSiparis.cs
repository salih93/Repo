using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class BekleyenSiparis
    {
        public int r_sayac { get; set; }
        public int mus_rsayac { get; set; }
        public int siparis_no { get; set; }
        public string cid { get; set; }
        public string musteri_no { get; set; }
        public string unvan { get; set; }
        public string teslim_musteri_no { get; set; }
        public DateTime siparis_tarihi { get; set; }
        public string siparis_asama { get; set; }
        public string satis_tipi { get; set; }
        public string satis_tipi_adi { get; set; }
        public string para_birimi { get; set; }
        public string temsilci { get; set; }
        public string temsilci_adi { get; set; }
        public decimal siparis_tutari { get; set; }
        public decimal toplam_tutar { get; set; }
        public decimal indirim_tutari { get; set; }
        public int onay { get; set; }
        public decimal toplam_kdv { get; set; }
        public decimal toplam_otv { get; set; }
        public string sub_fatura_tipi_id { get; set; }
        public string siparis_firma { get; set; }
        public string aktarim_tipi { get; set; }
        public string kullanici { get; set; }
        public string sube_kodu { get; set; }
        public string aciklama_android { get; set; }
        public int sira_no { get; set; }
        public string malzeme_kodu { get; set; }
        public string birimi { get; set; }

        public decimal birim_fiyat { get; set; }
        public decimal miktar { get; set; }
        public string indirim { get; set; }
        public string asama { get; set; }
        public DateTime sevk_tarihi { get; set; }
        public DateTime teslim_tarihi { get; set; }
        public decimal fatura_edilen_miktar { get; set; }
        public int bedelsiz { get; set; }

        public int indirim01_flag { get; set; }
        public int indirim02_flag { get; set; }
        public int indirim03_flag { get; set; }
        public int indirim04_flag { get; set; }
        public int indirim05_flag { get; set; }
        public int indirim06_flag { get; set; }

        public decimal indirim01 { get; set; }
        public decimal indirim02 { get; set; }
        public decimal indirim03 { get; set; }
        public decimal indirim04 { get; set; }
        public decimal indirim05 { get; set; }
        public decimal indirim06 { get; set; }

        public decimal toplam_indirim { get; set; }
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

        public string malzeme_adi { get; set; }
        public string grup_adi1 { get; set; }
        public string grup_adi2 { get; set; }
        public string grup_adi3 { get; set; }
        public string baz_birim { get; set; }


    }
}
