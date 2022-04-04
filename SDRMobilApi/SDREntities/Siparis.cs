using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class Siparis
    {
        public int r_sayac { get; set; }
        public string cid { get; set; }
        public string musteri_no { get; set; }
        public string teslim_musteri_no { get; set; }
        public string siparis_tarihi { get; set; }
        public string siparis_asama { get; set; }
        public string satis_tipi { get; set; }
        public int siparis_no { get; set; }
        public string para_birimi { get; set; }
        public string satis_temsilcisi { get; set; }
        public decimal siparis_tutari { get; set; }
        public decimal toplam_tutar { get; set; }
        public decimal indirim_tutari { get; set; }
        public int onay { get; set; }
        public decimal toplam_kdv { get; set; }
        public int son_versiyon { get; set; }

        public decimal toplam_otv { get; set; }
        public string sub_fatura_tipi_id { get; set; }
        public string tesis_no { get; set; }
        public string depo_no { get; set; }

        public string siparis_firma { get; set; }
        public string aktarim_tipi { get; set; }
        public string kullanici { get; set; }
        public string stok_tipi_no { get; set; }
        public string sevk_tarihi { get; set; }
        public int return_sayac { get; set; }
        public string sube_kodu { get; set; }
        public string adres_tanimi_kod2 { get; set; }
        public string adres_tanimi { get; set; }
        public int android_gps_sayac { get; set; }
        public string aciklama { get; set; }
        public string siparis_form_aciklama { get; set; }
        public string aciklama_android { get; set; }
        public string guid { get; set; }
        public string satis_tipi_adi { get; set; }
        public decimal toplam_miktar { get; set; }
        public int urun_cesidi { get; set; }
        

    }
}
