using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class CariKart
    {
        public int r_sayac { get; set; }
        public string cari_tipi { get; set; }
        public string cid{ get; set; }
        public string kod { get; set; }
        public string kodu2 { get; set; }
        public string unvan { get; set; }
        public string semt { get; set; }
        public string cari_adsoyad { get; set; }
        public string temsilci_kodu { get; set; }
        public string temsilci_adsoyad { get; set; }

        public decimal tl_borc { get; set; }
        public decimal tl_alacak { get; set; }
        public decimal tl_abakiye { get; set; }
        public decimal tl_bbakiye { get; set; }

        public decimal calisilan_borc { get; set; }
        public decimal calisilan_alacak { get; set; }
        public decimal calisilan_abakiye { get; set; }
        public decimal calisilan_bbakiye { get; set; }

        public string calisilan_tur { get; set; }
        public string risk_tipi { get; set; }
        public int risk_tipi_islem_durduruldu { get; set; }
        public string vergi_no { get; set; }
        public decimal risk_limiti { get; set; }
        public string ust_kanal_kodu { get; set; }


        public string kanal_kodu { get; set; }
        public string alt_kanal_kodu { get; set; }
        public string ust_kanal_adi { get; set; }
        public string kanal_adi { get; set; }
        public string alt_kanal_adi { get; set; }


        public string musteri_tipi { get; set; }
        public int efatura_kullanicisi { get; set; }

        public string sehir { get; set; }
        public string ilce { get; set; }
        public string satis_bolge_kodu { get; set; }
        public string satis_bolge_adi { get; set; }

        public string yetkili { get; set; }
        public string tabela { get; set; }
        public string e_mail { get; set; }

        public decimal gunlukSiparisTutar { get; set; }
        public decimal gunlukFaturaTutar { get; set; }
        public decimal gunlukTahsilatTutar { get; set; }
        public string enlem { get; set; }
        public string boylam { get; set; }

    }
}
