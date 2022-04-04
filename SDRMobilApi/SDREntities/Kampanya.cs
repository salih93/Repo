using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class Kampanya
    {
        public int r_sayac { get; set; }
        public string kampanya_kodu { get; set; }
        public string cid { get; set; }
        public string kampanya_adi { get; set; }
        public string kampanya_tipi { get; set; }
        public DateTime baslangic_tarihi { get; set; }
        public DateTime bitis_tarihi { get; set; }
        public DateTime uygulama_bas_tarihi { get; set; }
        public DateTime uygulama_bit_tarihi { get; set; }

        public decimal tah_maliyet { get; set; }
        public decimal tah_satis { get; set; }

        public int return_sayac { get; set; }
        public int modul_id { get; set; }
        public decimal indirim_yuzdesi { get; set; }

        public string ana_firma_kodu { get; set; }
        public string kampanya_grubu { get; set; }
        public string malzeme_sinifi { get; set; }
        public int bayi_kampanya { get; set; }
        public string birim { get; set; }
        public decimal kota { get; set; }
        public int bayi_sayisi { get; set; }
        public int musteri_sayisi { get; set; }
        public decimal bayi_bas_kota { get; set; }
        public decimal musteri_bas_kota { get; set; }
        public string asama { get; set; }
        public decimal satilan { get; set; }
        public int mix_sarti_arama { get; set; }
        public int zorunlu { get; set; }
        public int grup_miktar_sarti { get; set; }
        public decimal grup_toplam_miktar { get; set; }
        public string aciklama { get; set; }
        public int hayat_kampanya { get; set; }
        public int kontrat { get; set; }
        public int uretici_rsayac { get; set; }
        public int istisna_listesi_kullanildimi { get; set; }
        public int haric_tutulan_istisna_listesi { get; set; }
    }

}
