using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class SatisTipi
    {
        public int r_sayac { get; set; }
        public string satis_tip_id { get; set; }
        public string satis_tipi { get; set; }
        public string aciklama { get; set; }
        public string hareket_tipi_id { get; set; }
        public string sak_kontrol_no { get; set; }
        public string fiyat_tipi { get; set; }
        public string depo_no { get; set; }
        public string tesis_no { get; set; }
        public string stok_tipi_no { get; set; }
        public string iade_hareket_tipi_id { get; set; }
        public string fatura_tipi_id { get; set; }
        public int kampanyalari_otomatik_uygula { get; set; }
        public int iade { get; set; }
        public int goster { get; set; }

        public string tablo_no { get; set; }        
        public string alis_fiyat_tipi { get; set; }
        public string satis_fiyat_tipi { get; set; }
        public int satis_fiyati1 { get; set; }
        public int satis_fiyati2 { get; set; }
        public int satis_fiyati3 { get; set; }
        public int satis_fiyati4 { get; set; }
        public int satis_fiyati5 { get; set; }

        public int alis_fiyati1 { get; set; }
        public int alis_fiyati2 { get; set; }
        public int alis_fiyati3 { get; set; }
        public int alis_fiyati4 { get; set; }
        public int alis_fiyati5 { get; set; }

        public int vade_alis1 { get; set; }
        public int vade_alis2 { get; set; }
        public int vade_alis3 { get; set; }
        public int vade_alis4 { get; set; }
        public int vade_alis5 { get; set; }

        public int vade_satis1 { get; set; }
        public int vade_satis2 { get; set; }
        public int vade_satis3 { get; set; }
        public int vade_satis4 { get; set; }
        public int vade_satis5 { get; set; }

        public int iskonto1 { get; set; }
        public int iskonto2 { get; set; }
        public int iskonto3 { get; set; }
        public int iskonto4 { get; set; }
        public int iskonto5 { get; set; }
        public int iskonto6 { get; set; }

        public int cari_vadesi_gelsin { get; set; }
        public int genel_iskonto_yuzde { get; set; }
        public decimal genel_iskonto { get; set; }

        public int alis_iskonto1 { get; set; }
        public int alis_iskonto2 { get; set; }
        public int alis_iskonto3 { get; set; }
        public int alis_iskonto4 { get; set; }
        public int alis_iskonto5 { get; set; }
        public int alis_iskonto6 { get; set; }

        public string vade_alis_kodu1 { get; set; }
        public string vade_alis_kodu2 { get; set; }
        public string vade_alis_kodu3 { get; set; }
        public string vade_alis_kodu4 { get; set; }
        public string vade_alis_kodu5 { get; set; }

        public string vade_satis_kodu1 { get; set; }
        public string vade_satis_kodu2 { get; set; }
        public string vade_satis_kodu3 { get; set; }
        public string vade_satis_kodu4 { get; set; }
        public string vade_satis_kodu5 { get; set; }
        public int fiyat_listesi { get; set; }

        public int birim_fiyat_degistir { get; set; }
        public int gen_iskonto_degistir { get; set; }
        public int satir_iskonto_degistir { get; set; }
        public int borc_kapatma { get; set; }
        public int fat_basimi_yapilsin { get; set; }
        public string fat_seri_no { get; set; }
        public int odeme_tarih_hesapla { get; set; }
        public int sak_kullanim_sekli { get; set; }
        public string sak_tablosu { get; set; }
        public int toplu_mal_ayirma { get; set; }
        public int irsaliye_basimi { get; set; }
        public string irsaliye_seri_no { get; set; }

        public int siparis_yapilsin { get; set; }
        public int kamyonlastirma_yapilsin { get; set; }
        public int irsaliye_yapilsin { get; set; }
        public int fatura_yapilsin { get; set; }
        public string kontrol_no { get; set; }        
        public int vade_degistir { get; set; }
        public int sts_irs_seri_no_rsayac { get; set; }
        public int sts_irs_basili_form_rsayac { get; set; }
        public int sts_fat_seri_no_rsayac { get; set; }
        public int sts_fat_basili_form_rsayac { get; set; }
        public int sts_fat_irs_basili_form_rsayac { get; set; }
        public int sts_iade_irsaliye_basimi { get; set; }
        public int sts_iade_irs_seri_no_rsayac { get; set; }

        public int sts_iade_irs_basili_form_rsayac { get; set; }
        public int sts_iade_fatura_basimi { get; set; }
        public int sts_iade_fat_seri_no_rsayac { get; set; }
        public int sts_iade_fat_basili_form_rsayac { get; set; }

    }
}
