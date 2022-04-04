using Microsoft.Extensions.Configuration;
using SDRMobilApi.Data;
using SDRMobilApi.Helpers;
using SDRMobilApi.SDREntities;
using SDRMobilApi.SDRModels;
using Nancy.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;

namespace SDRMobilApi.SDRServices
{
    
    public interface ISDRService
    {
        string GetConnectionString(string veritabani_adi);

        //List<Tanimlar> GetTanimlar(SdrParametreModel model);        
        //List<Kasa> GetKasalar(SdrParametreModel model);
        //List<ZiyaretTipleri> GetZiyaretTipleri(ZiyaretParametreModel model);
        //List<ZiyaretSonlandirmaTipleri> GetZiyaretSonlandirmaTipleri(ZiyaretParametreModel model);
        //List<Malzeme> GetMalzeme(SdrParametreModel model);
        //List<BirimCevrimi> GetMalzemeBirimCevrimi(SdrParametreModel model);
        ValidationResponseList GetAllTanimlar(SdrParametreModel model);


        ValidationResponseList GetCariKartlar(SdrParametreModel model);
        ValidationResponseList GetCariKartSubeler(SdrParametreModel model);
        ValidationResponseList GetRutTanimi(SdrParametreModel model);
        ValidationResponseList GetSatisTipleri(SdrParametreModel model);
        ValidationResponseList GetAllCariVeRut(SdrParametreModel model);


        ValidationResponseList GetAylikSatis(SdrParametreModel model);
        ValidationResponseList GetCariHesapEkstresi(SdrParametreModel model);
        ValidationResponseList GetCariVadefarki(SdrParametreModel model);
        ValidationResponseList GetAllSatislar(SdrParametreModel model);

        //List<Fiyat> GetSatisFiyatlari(SdrParametreModel model);        
        ValidationResponseList GetAllFiyatBSiparis(SdrParametreModel model);

        ValidationResponseList GetKampanya(SdrParametreModel model);
        ValidationResponse SetSiparis(List<Siparis> siparis, List<SiparisSatir> siparisSatirs, List<Ziyaret> ziyaretler, AktarimParameterModel model);
        ValidationResponse SetTahsilat(List<Tahsilat> tahsilatlar, List<Ziyaret> ziyaretler, AktarimParameterModel model);
        ValidationResponse SetZiyaret(List<Ziyaret> ziyaretler, AktarimParameterModel model);

        ValidationResponseList GetMusteriMalAnalizi(ParameterMMAnaliziModel model);

        ValidationResponseList GetAcikHesapListesi(SdrParametreModel model);
        ValidationResponseList GetGunlukTahsilat(SdrParametreModel model);
        ValidationResponseList GetAllBekleyenSiparis(SdrParametreModel model);
        ValidationResponseList GetGunlukSiparis(SdrParametreModel model);
        ValidationResponseList GetStokFiyatListesi(SdrParametreModel model);
    }

    public class SdrServices : ISDRService
    {
        private string connectionString;
        private DataContext _context;
        public IConfiguration Configuration { get; }

        public SdrServices(DataContext context, IConfiguration configuration)
        {
            _context = context;
            Configuration = configuration;

        }
        public ValidationResponseList GetAllTanimlar(SdrParametreModel model)
        {
            string _connectionString = "";
            
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "",result= new List<string>() };

            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            List<string> result = new List<string>();
            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_all_tanimlar '{0}' ", model.temsilci_kodu), sqlConnection);

                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);

                List<Tanimlar> _Tanimlar = new List<Tanimlar>();

                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    var _tanim = new Tanimlar()
                    {
                        key = item["key"].ToString(),
                        value = item["value"].ToString(),
                        groupname = item["groupname"].ToString()
                    };
                    _Tanimlar.Add(_tanim);
                }
                var json_serializer = new JavaScriptSerializer();
                result.Add(json_serializer.Serialize(_Tanimlar));

                List<Kasa> kasalar = new List<Kasa>();                
                foreach (DataRow item in dataSet.Tables[1].Rows)
                {
                    var kasa = new Kasa()
                    {
                        kod = ReplaceStringNull(item["kod"].ToString()),
                        sorumlu = ReplaceStringNull(item["sorumlu"].ToString()),
                        kredi_karti_kasasi = ReplaceIntNull(item["kredi_karti_kasasi"].ToString())
                    };
                    kasalar.Add(kasa);
                }
                result.Add(json_serializer.Serialize(kasalar));

                List<ZiyaretTipleri> ziyaret_tipleri = new List<ZiyaretTipleri>();                
                foreach (DataRow item in dataSet.Tables[2].Rows)
                {
                    var ziyaret_tip = new ZiyaretTipleri()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        tipi = ReplaceStringNull(item["tipi"].ToString()),
                        aciklama = ReplaceStringNull(item["aciklama"].ToString())
                    };
                    ziyaret_tipleri.Add(ziyaret_tip);
                }
                result.Add(json_serializer.Serialize(ziyaret_tipleri));

                List<ZiyaretSonlandirmaTipleri> ziyaret_sonlandirma_tipleri = new List<ZiyaretSonlandirmaTipleri>();
                
                foreach (DataRow item in dataSet.Tables[3].Rows)
                {
                    var ziyaret_sonlandirma_tip = new ZiyaretSonlandirmaTipleri()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        tipi = ReplaceStringNull(item["tipi"].ToString()),
                        aciklama = ReplaceStringNull(item["aciklama"].ToString()),
                        sira = ReplaceIntNull(item["sira"].ToString()),
                        auto = ReplaceIntNull(item["auto"].ToString()),
                        sabit = ReplaceIntNull(item["sabit"].ToString()),
                        satisvar = ReplaceIntNull(item["satisvar"].ToString()),
                        zorunlu_aciklama = ReplaceIntNull(item["zorunlu_aciklama"].ToString())

                    };
                    ziyaret_sonlandirma_tipleri.Add(ziyaret_sonlandirma_tip);
                }
                result.Add(json_serializer.Serialize(ziyaret_sonlandirma_tipleri));


                List<Malzeme> malzemeList = new List<Malzeme>();                
                foreach (DataRow item in dataSet.Tables[4].Rows)
                {
                    var malzeme = new Malzeme()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        malzeme_adi = ReplaceStringNull(item["malzeme_adi"].ToString()),
                        malzeme_sinifi_adi = ReplaceStringNull(item["malzeme_sinifi_adi"].ToString()),
                        malzeme_birimi = ReplaceStringNull(item["malzeme_birimi"].ToString()),
                        satinalma_birimi = ReplaceStringNull(item["satinalma_birimi"].ToString()),
                        satis_birimi = ReplaceStringNull(item["satis_birimi"].ToString()),
                        depo_birimi = ReplaceStringNull(item["depo_birimi"].ToString()),
                        cikis_birimi = ReplaceStringNull(item["cikis_birimi"].ToString()),
                        birimi = ReplaceStringNull(item["birimi"].ToString()),
                        malzeme_sinifi_no = ReplaceStringNull(item["malzeme_sinifi_no"].ToString()),
                        kdv_orani = ReplaceDecimalNull(item["kdv_orani"].ToString()),
                        dist_stok_kodu = ReplaceStringNull(item["dist_stok_kodu"].ToString()),
                        baz_birim = ReplaceStringNull(item["baz_birim"].ToString()),
                        path = ReplaceStringNull(item["path"].ToString()),
                        yururlukten_kaldirildi = ReplaceIntNull(item["yururlukten_kaldirildi"].ToString()),
                        grup_kodu1 = ReplaceStringNull(item["grup_kodu1"].ToString()),
                        grup_adi1 = ReplaceStringNull(item["grup_adi1"].ToString()),
                        grup_kodu2 = ReplaceStringNull(item["grup_kodu2"].ToString()),
                        grup_adi2 = ReplaceStringNull(item["grup_adi2"].ToString()),
                        grup_kodu3 = ReplaceStringNull(item["grup_kodu3"].ToString()),
                        grup_adi3 = ReplaceStringNull(item["grup_adi3"].ToString()),
                        grup_kodu4 = ReplaceStringNull(item["grup_kodu4"].ToString()),
                        grup_adi4 = ReplaceStringNull(item["grup_adi4"].ToString()),
                        grup_kodu5 = ReplaceStringNull(item["grup_kodu5"].ToString()),
                        grup_adi5 = ReplaceStringNull(item["grup_adi5"].ToString()),
                        fatura_alti_indirimlere_dahil = ReplaceIntNull(item["fatura_alti_indirimlere_dahil"].ToString())

                    };

                    malzemeList.Add(malzeme);
                }
                result.Add(json_serializer.Serialize(malzemeList));

                List<BirimCevrimi> birimList = new List<BirimCevrimi>();
                foreach (DataRow item in dataSet.Tables[5].Rows)
                {
                    var birimCevrimi = new BirimCevrimi()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        birim_rsayac = ReplaceIntNull(item["birim_rsayac"].ToString()),
                        birimden = ReplaceStringNull(item["birimden"].ToString()),
                        birime = ReplaceStringNull(item["birime"].ToString()),
                        bolen = ReplaceDecimalNull(item["bolen"].ToString()),
                        bolunen = ReplaceDecimalNull(item["bolunen"].ToString()),
                        malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString())
                    };

                    birimList.Add(birimCevrimi);
                }
                result.Add(json_serializer.Serialize(birimList));

            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            vr.successful = true;
            vr.result = result;

            return vr;
        }

        public ValidationResponseList GetAllCariVeRut(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            List<string> result = new List<string>();
            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_all_cari_ve_rut '{0}' ", model.temsilci_kodu), sqlConnection);

                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);

                List<CariKart> cariKarts = new List<CariKart>();

                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    var _cari = new CariKart()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        cari_tipi = ReplaceStringNull(item["cari_tipi"].ToString()),
                        cid = ReplaceStringNull(item["cid"].ToString()),
                        kod = ReplaceStringNull(item["kod"].ToString()),
                        kodu2 = ReplaceStringNull(item["kodu2"].ToString()),
                        unvan = ReplaceStringNull(item["unvan"].ToString()),
                        semt = ReplaceStringNull(item["semt"].ToString()),
                        cari_adsoyad = ReplaceStringNull(item["cari_adsoyad"].ToString()),
                        temsilci_kodu = ReplaceStringNull(item["temsilci_kodu"].ToString()),
                        temsilci_adsoyad = ReplaceStringNull(item["temsilci_adsoyad"].ToString().Trim()),
                        tl_borc = ReplaceDecimalNull(item["tl_borc"].ToString()),
                        tl_alacak = ReplaceDecimalNull(item["tl_alacak"].ToString()),
                        tl_abakiye = ReplaceDecimalNull(item["tl_abakiye"].ToString()),
                        tl_bbakiye = ReplaceDecimalNull(item["tl_bbakiye"].ToString()),
                        calisilan_borc = ReplaceDecimalNull(item["calisilan_borc"].ToString()),
                        calisilan_alacak = ReplaceDecimalNull(item["calisilan_alacak"].ToString()),
                        calisilan_abakiye = ReplaceDecimalNull(item["calisilan_abakiye"].ToString()),
                        calisilan_bbakiye = ReplaceDecimalNull(item["calisilan_bbakiye"].ToString()),
                        calisilan_tur = ReplaceStringNull(item["calisilan_tur"].ToString()),
                        risk_tipi = ReplaceStringNull(item["risk_tipi"].ToString()),
                        risk_tipi_islem_durduruldu = ReplaceIntNull(item["risk_tipi_islem_durduruldu"].ToString()),
                        vergi_no = ReplaceStringNull(item["vergi_no"].ToString()),
                        risk_limiti = ReplaceDecimalNull(item["risk_limiti"].ToString()),

                        ust_kanal_kodu = ReplaceStringNull(item["ust_kanal_kodu"].ToString()),
                        kanal_kodu = ReplaceStringNull(item["kanal_kodu"].ToString()),
                        alt_kanal_kodu = ReplaceStringNull(item["alt_kanal_kodu"].ToString()),
                        ust_kanal_adi = ReplaceStringNull(item["ust_kanal_adi"].ToString()),
                        kanal_adi = ReplaceStringNull(item["kanal_adi"].ToString()),
                        alt_kanal_adi = ReplaceStringNull(item["alt_kanal_adi"].ToString()),
                        musteri_tipi = ReplaceStringNull(item["vergi_no"].ToString()),
                        efatura_kullanicisi = ReplaceIntNull(item["efatura_kullanicisi"].ToString()),

                        sehir = ReplaceStringNull(item["vergi_no"].ToString()),
                        ilce = ReplaceStringNull(item["ilce"].ToString()),
                        satis_bolge_kodu = ReplaceStringNull(item["satis_bolge_kodu"].ToString()),
                        satis_bolge_adi = ReplaceStringNull(item["satis_bolge_adi"].ToString()),
                        yetkili = ReplaceStringNull(item["yetkili"].ToString()),
                        tabela = ReplaceStringNull(item["tabela"].ToString()),
                        e_mail = ReplaceStringNull(item["e_mail"].ToString()),

                        gunlukSiparisTutar = ReplaceDecimalNull(item["gunlukSiparisTutar"].ToString()),
                        gunlukFaturaTutar = ReplaceDecimalNull(item["gunlukFaturaTutar"].ToString()),
                        gunlukTahsilatTutar = ReplaceDecimalNull(item["gunlukTahsilatTutar"].ToString()),
                        enlem = ReplaceStringNull(item["enlem"].ToString()),
                        boylam = ReplaceStringNull(item["boylam"].ToString())
                    };

                    cariKarts.Add(_cari);
                }

                var json_serializer = new JavaScriptSerializer();
                result.Add(json_serializer.Serialize(cariKarts));

                List<CarKartSubeler> cariKartSubeler = new List<CarKartSubeler>();
                
                foreach (DataRow item in dataSet.Tables[1].Rows)
                {
                    var cariKartSube = new CarKartSubeler()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        cari_sayac = ReplaceIntNull(item["cari_sayac"].ToString()),
                        sube_kodu = ReplaceStringNull(item["sube_kodu"].ToString()),
                        sube_adi = ReplaceStringNull(item["sube_adi"].ToString())
                    };
                    cariKartSubeler.Add(cariKartSube);
                }
                result.Add(json_serializer.Serialize(cariKartSubeler));

                List<RutTanimi> rutTanimis = new List<RutTanimi>();

                foreach (DataRow item in dataSet.Tables[2].Rows)
                {
                    var rutTanimi = new RutTanimi()
                    {
                        kod = ReplaceStringNull(item["kod"].ToString()),
                        gun = ReplaceStringNull(item["gun"].ToString()),
                        aktif = ReplaceIntNull(item["aktif"].ToString()),
                        gun_sira = ReplaceIntNull(item["gun_sira"].ToString()),
                        rut_sira_no = ReplaceIntNull(item["rut_sira_no"].ToString()),
                        aktifnoktasayisi = ReplaceIntNull(item["aktifnoktasayisi"].ToString()),
                        pasifnoktasayisi = ReplaceIntNull(item["pasifnoktasayisi"].ToString()),
                        rutSayac = ReplaceIntNull(item["rutSayac"].ToString()),
                        rutDetaySayac = ReplaceIntNull(item["rutDetaySayac"].ToString()),
                        bugun = ReplaceIntNull(item["bugun"].ToString()),

                    };
                    rutTanimis.Add(rutTanimi);
                }
                result.Add(json_serializer.Serialize(rutTanimis));

                List<SatisTipi> satisTipis = new List<SatisTipi>();

                foreach (DataRow item in dataSet.Tables[3].Rows)
                {
                    var satisTipi = new SatisTipi()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        aciklama = ReplaceStringNull(item["aciklama"].ToString()),
                        depo_no = ReplaceStringNull(item["depo_no"].ToString()),
                        fatura_tipi_id = ReplaceStringNull(item["fatura_tipi_id"].ToString()),
                        fiyat_tipi = ReplaceStringNull(item["fiyat_tipi"].ToString()),
                        goster = ReplaceIntNull(item["goster"].ToString()),
                        hareket_tipi_id = ReplaceStringNull(item["hareket_tipi_id"].ToString()),
                        iade = ReplaceIntNull(item["iade"].ToString()),
                        iade_hareket_tipi_id = ReplaceStringNull(item["iade_hareket_tipi_id"].ToString()),
                        kampanyalari_otomatik_uygula = ReplaceIntNull(item["kampanyalari_otomatik_uygula"].ToString()),
                        sak_kontrol_no = ReplaceStringNull(item["sak_kontrol_no"].ToString()),
                        satis_tipi = ReplaceStringNull(item["satis_tipi"].ToString()),
                        satis_tip_id = ReplaceStringNull(item["satis_tip_id"].ToString()),
                        stok_tipi_no = ReplaceStringNull(item["stok_tipi_no"].ToString()),
                        tesis_no = ReplaceStringNull(item["tesis_no"].ToString()),

                        tablo_no = ReplaceStringNull(item["tablo_no"].ToString()),
                        alis_fiyat_tipi = ReplaceStringNull(item["alis_fiyat_tipi"].ToString()),
                        satis_fiyat_tipi = ReplaceStringNull(item["satis_fiyat_tipi"].ToString()),

                        satis_fiyati1 = ReplaceIntNull(item["satis_fiyati1"].ToString()),
                        satis_fiyati2 = ReplaceIntNull(item["satis_fiyati2"].ToString()),
                        satis_fiyati3 = ReplaceIntNull(item["satis_fiyati3"].ToString()),
                        satis_fiyati4 = ReplaceIntNull(item["satis_fiyati4"].ToString()),
                        satis_fiyati5 = ReplaceIntNull(item["satis_fiyati5"].ToString()),

                        alis_fiyati1 = ReplaceIntNull(item["alis_fiyati1"].ToString()),
                        alis_fiyati2 = ReplaceIntNull(item["alis_fiyati2"].ToString()),
                        alis_fiyati3 = ReplaceIntNull(item["alis_fiyati3"].ToString()),
                        alis_fiyati4 = ReplaceIntNull(item["alis_fiyati4"].ToString()),
                        alis_fiyati5 = ReplaceIntNull(item["alis_fiyati5"].ToString()),

                        vade_alis1 = ReplaceIntNull(item["vade_alis1"].ToString()),
                        vade_alis2 = ReplaceIntNull(item["vade_alis2"].ToString()),
                        vade_alis3 = ReplaceIntNull(item["vade_alis3"].ToString()),
                        vade_alis4 = ReplaceIntNull(item["vade_alis4"].ToString()),
                        vade_alis5 = ReplaceIntNull(item["vade_alis5"].ToString()),

                        vade_satis1 = ReplaceIntNull(item["vade_satis1"].ToString()),
                        vade_satis2 = ReplaceIntNull(item["vade_satis2"].ToString()),
                        vade_satis3 = ReplaceIntNull(item["vade_satis3"].ToString()),
                        vade_satis4 = ReplaceIntNull(item["vade_satis4"].ToString()),
                        vade_satis5 = ReplaceIntNull(item["vade_satis5"].ToString()),

                        iskonto1 = ReplaceIntNull(item["iskonto1"].ToString()),
                        iskonto2 = ReplaceIntNull(item["iskonto2"].ToString()),
                        iskonto3 = ReplaceIntNull(item["iskonto3"].ToString()),
                        iskonto4 = ReplaceIntNull(item["iskonto4"].ToString()),
                        iskonto5 = ReplaceIntNull(item["iskonto5"].ToString()),
                        iskonto6 = ReplaceIntNull(item["iskonto6"].ToString()),

                        cari_vadesi_gelsin = ReplaceIntNull(item["cari_vadesi_gelsin"].ToString()),
                        genel_iskonto_yuzde = ReplaceIntNull(item["genel_iskonto_yuzde"].ToString()),
                        genel_iskonto = ReplaceDecimalNull(item["genel_iskonto"].ToString()),

                        alis_iskonto1 = ReplaceIntNull(item["alis_iskonto1"].ToString()),
                        alis_iskonto2 = ReplaceIntNull(item["alis_iskonto2"].ToString()),
                        alis_iskonto3 = ReplaceIntNull(item["alis_iskonto3"].ToString()),
                        alis_iskonto4 = ReplaceIntNull(item["alis_iskonto4"].ToString()),
                        alis_iskonto5 = ReplaceIntNull(item["alis_iskonto5"].ToString()),
                        alis_iskonto6 = ReplaceIntNull(item["alis_iskonto6"].ToString()),

                        vade_alis_kodu1 = ReplaceStringNull(item["vade_alis_kodu1"].ToString()),
                        vade_alis_kodu2 = ReplaceStringNull(item["vade_alis_kodu2"].ToString()),
                        vade_alis_kodu3 = ReplaceStringNull(item["vade_alis_kodu3"].ToString()),
                        vade_alis_kodu4 = ReplaceStringNull(item["vade_alis_kodu4"].ToString()),
                        vade_alis_kodu5 = ReplaceStringNull(item["vade_alis_kodu5"].ToString()),

                        vade_satis_kodu1 = ReplaceStringNull(item["vade_satis_kodu1"].ToString()),
                        vade_satis_kodu2 = ReplaceStringNull(item["vade_satis_kodu2"].ToString()),
                        vade_satis_kodu3 = ReplaceStringNull(item["vade_satis_kodu3"].ToString()),
                        vade_satis_kodu4 = ReplaceStringNull(item["vade_satis_kodu4"].ToString()),
                        vade_satis_kodu5 = ReplaceStringNull(item["vade_satis_kodu5"].ToString()),
                        fiyat_listesi = ReplaceIntNull(item["fiyat_listesi"].ToString()),
                        birim_fiyat_degistir = ReplaceIntNull(item["birim_fiyat_degistir"].ToString()),
                        gen_iskonto_degistir = ReplaceIntNull(item["gen_iskonto_degistir"].ToString()),
                        satir_iskonto_degistir = ReplaceIntNull(item["satir_iskonto_degistir"].ToString()),
                        borc_kapatma = ReplaceIntNull(item["borc_kapatma"].ToString()),
                        fat_basimi_yapilsin = ReplaceIntNull(item["fat_basimi_yapilsin"].ToString()),

                        fat_seri_no = ReplaceStringNull(item["fat_seri_no"].ToString()),
                        odeme_tarih_hesapla = ReplaceIntNull(item["odeme_tarih_hesapla"].ToString()),
                        sak_kullanim_sekli = ReplaceIntNull(item["sak_kullanim_sekli"].ToString()),
                        sak_tablosu = ReplaceStringNull(item["sak_tablosu"].ToString()),
                        toplu_mal_ayirma = ReplaceIntNull(item["toplu_mal_ayirma"].ToString()),
                        irsaliye_basimi = ReplaceIntNull(item["irsaliye_basimi"].ToString()),
                        irsaliye_seri_no = ReplaceStringNull(item["irsaliye_seri_no"].ToString()),
                        siparis_yapilsin = ReplaceIntNull(item["siparis_yapilsin"].ToString()),

                        kamyonlastirma_yapilsin = ReplaceIntNull(item["kamyonlastirma_yapilsin"].ToString()),
                        irsaliye_yapilsin = ReplaceIntNull(item["irsaliye_yapilsin"].ToString()),
                        fatura_yapilsin = ReplaceIntNull(item["fatura_yapilsin"].ToString()),
                        kontrol_no = ReplaceStringNull(item["kontrol_no"].ToString()),

                        vade_degistir = ReplaceIntNull(item["vade_degistir"].ToString()),
                        sts_irs_seri_no_rsayac = ReplaceIntNull(item["sts_irs_seri_no_rsayac"].ToString()),
                        sts_irs_basili_form_rsayac = ReplaceIntNull(item["sts_irs_basili_form_rsayac"].ToString()),
                        sts_fat_seri_no_rsayac = ReplaceIntNull(item["sts_fat_seri_no_rsayac"].ToString()),

                        sts_fat_basili_form_rsayac = ReplaceIntNull(item["sts_fat_basili_form_rsayac"].ToString()),
                        sts_fat_irs_basili_form_rsayac = ReplaceIntNull(item["sts_fat_irs_basili_form_rsayac"].ToString()),
                        sts_iade_irsaliye_basimi = ReplaceIntNull(item["sts_iade_irsaliye_basimi"].ToString()),
                        sts_iade_irs_seri_no_rsayac = ReplaceIntNull(item["sts_iade_irs_seri_no_rsayac"].ToString()),
                        sts_iade_irs_basili_form_rsayac = ReplaceIntNull(item["sts_iade_irs_basili_form_rsayac"].ToString()),
                        sts_iade_fatura_basimi = ReplaceIntNull(item["sts_iade_fatura_basimi"].ToString()),
                        sts_iade_fat_seri_no_rsayac = ReplaceIntNull(item["sts_iade_fat_seri_no_rsayac"].ToString()),
                        sts_iade_fat_basili_form_rsayac = ReplaceIntNull(item["sts_iade_fat_basili_form_rsayac"].ToString())


                    };

                    satisTipis.Add(satisTipi);
                }

                result.Add(json_serializer.Serialize(satisTipis));

            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            vr.successful = true;
            vr.result = result;

            return vr;

        }

        public ValidationResponseList GetAllSatislar(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            List<string> result = new List<string>();
            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_all_satis '{0}', '{1}' ", model.temsilci_kodu, model.cari_kod), sqlConnection);

                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);

                List<AylikSatis> satislar = new List<AylikSatis>();

                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    var satis = new AylikSatis()
                    {
                        Id = ReplaceIntNull(item["Id"].ToString()),
                        ay = ReplaceIntNull(item["ay"].ToString()),
                        ay_str = ReplaceStringNull(item["ay_str"].ToString()),
                        dist_stok_kodu = ReplaceStringNull(item["dist_stok_kodu"].ToString()),
                        malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        malzeme_adi = ReplaceStringNull(item["malzeme_adi"].ToString()),
                        birim = ReplaceStringNull(item["birim"].ToString()),
                        miktar = ReplaceDecimalNull(item["miktar"].ToString()),
                        ciro = ReplaceDecimalNull(item["ciro"].ToString()),
                        malzeme_sinifi_adi = ReplaceStringNull(item["malzeme_sinifi_adi"].ToString()),
                        malzeme_sinifi_id = ReplaceStringNull(item["malzeme_sinifi_id"].ToString()),
                        path = ReplaceStringNull(item["path"].ToString())

                    };
                    satislar.Add(satis);
                }

                var json_serializer = new JavaScriptSerializer();
                result.Add(json_serializer.Serialize(satislar));

                List<CariHesapEkstresi> ekstreler = new List<CariHesapEkstresi>();
                
                foreach (DataRow item in dataSet.Tables[1].Rows)
                {
                    var ekstre = new CariHesapEkstresi()
                    {
                        Id = ReplaceIntNull(item["Id"].ToString()),
                        cari_kodu = ReplaceStringNull(item["cari_kodu"].ToString()),
                        cari_unvan = ReplaceStringNull(item["cari_unvan"].ToString()),
                        fis_no = ReplaceStringNull(item["fis_no"].ToString()),
                        resmi_belge_no = ReplaceStringNull(item["resmi_belge_no"].ToString()),
                        aciklama = ReplaceStringNull(item["aciklama"].ToString()),
                        evrak_tarihi = ReplaceStringNull(item["evrak_tarihi"].ToString()),
                        vade_tarihi = ReplaceStringNull(item["vade_tarihi"].ToString()),
                        borc = ReplaceDecimalNull(item["borc"].ToString()),
                        alacak = ReplaceDecimalNull(item["alacak"].ToString()),
                        bakiye = ReplaceDecimalNull(item["bakiye"].ToString()),
                        bakiye_borc_alacak = ReplaceStringNull(item["bakiye_borc_alacak"].ToString()),
                        fis_turu = ReplaceStringNull(item["fis_turu"].ToString())
                    };

                    ekstreler.Add(ekstre);
                }                
                result.Add(json_serializer.Serialize(ekstreler));

                List<CariVadeFarki> vadeFarklar = new List<CariVadeFarki>();

                foreach (DataRow item in dataSet.Tables[2].Rows)
                {
                    var vadeFarki = new CariVadeFarki()
                    {
                        Id = ReplaceIntNull(item["Id"].ToString()),
                        cari_kodu = ReplaceStringNull(item["cari_kodu"].ToString()),
                        cari_unvan = ReplaceStringNull(item["cari_unvan"].ToString()),
                        fatura_no = ReplaceIntNull(item["fatura_no"].ToString()),
                        islem_tipi = ReplaceStringNull(item["islem_tipi"].ToString()),

                        fis_tarihi = ReplaceStringNull(item["fis_tarihi"].ToString()),
                        vade_gun_sayisi = ReplaceIntNull(item["vade_gun_sayisi"].ToString()),
                        vade_tarihi = ReplaceStringNull(item["vade_tarihi"].ToString()),
                        borc_alacak = ReplaceStringNull(item["borc_alacak"].ToString()),
                        tefat_tutari = ReplaceDecimalNull(item["tefat_tutari"].ToString()),
                        tefat_bakiye_tutari = ReplaceDecimalNull(item["tefat_bakiye_tutari"].ToString()),
                        bakiye_toplami = ReplaceDecimalNull(item["bakiye_toplami"].ToString()),
                        tahsilat_gecikti = ReplaceStringNull(item["tahsilat_gecikti"].ToString()),
                        gecikme_gunu = ReplaceIntNull(item["gecikme_gunu"].ToString()),
                        son_bakiye_bakod = ReplaceStringNull(item["son_bakiye_bakod"].ToString())
                    };

                    vadeFarklar.Add(vadeFarki);
                }
                result.Add(json_serializer.Serialize(vadeFarklar));

            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            vr.successful = true;
            vr.result = result;

            return vr;
        }

        public ValidationResponseList GetAllFiyatBSiparis(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            List<string> result = new List<string>();
            try
            {
                sqlConnection.Open();
                String tarih = String.Format("{0:yyyy/MM/dd}", model.tarih);

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_all_fiyat_bsiparis '{0}','{1}','{2}' ", model.temsilci_kodu, model.cari_kod, tarih.ToString()), sqlConnection);

                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);

                List<Fiyat> fiyatList = new List<Fiyat>();
                foreach (DataRow item in dataSet.Tables[0].Rows)                    
                {
                    var fiyat = new Fiyat()
                    {
                        kod = ReplaceStringNull(item["kod"].ToString()),
                        fiyat_tipi = ReplaceStringNull(item["fiyat_tipi"].ToString()),
                        para_birimi = ReplaceStringNull(item["para_birimi"].ToString()),
                        fiyat1 = ReplaceIntNull(item["fiyat1"].ToString()),
                        fiyat2 = ReplaceIntNull(item["fiyat2"].ToString()),
                        fiyat3 = ReplaceIntNull(item["fiyat3"].ToString()),
                        fiyat4 = ReplaceIntNull(item["fiyat4"].ToString()),
                        fiyat5 = ReplaceIntNull(item["fiyat5"].ToString()),

                        kdvli_fiyat1 = ReplaceIntNull(item["kdvli_fiyat1"].ToString()),
                        kdvli_fiyat2 = ReplaceIntNull(item["kdvli_fiyat2"].ToString()),
                        kdvli_fiyat3 = ReplaceIntNull(item["kdvli_fiyat3"].ToString()),
                        kdvli_fiyat4 = ReplaceIntNull(item["kdvli_fiyat4"].ToString()),
                        kdvli_fiyat5 = ReplaceIntNull(item["kdvli_fiyat5"].ToString()),

                        vade1 = ReplaceIntNull(item["vade1"].ToString()),
                        vade2 = ReplaceIntNull(item["vade2"].ToString()),
                        vade3 = ReplaceIntNull(item["vade3"].ToString()),
                        vade4 = ReplaceIntNull(item["vade4"].ToString()),
                        vade5 = ReplaceIntNull(item["vade5"].ToString()),

                        iskonto1 = ReplaceIntNull(item["iskonto1"].ToString()),
                        iskonto2 = ReplaceIntNull(item["iskonto2"].ToString()),
                        iskonto3 = ReplaceIntNull(item["iskonto3"].ToString()),
                        iskonto4 = ReplaceIntNull(item["iskonto4"].ToString()),
                        iskonto5 = ReplaceIntNull(item["iskonto5"].ToString()),
                        iskonto6 = ReplaceIntNull(item["iskonto6"].ToString()),
                        genel_iskonto_yuzde = ReplaceIntNull(item["genel_iskonto_yuzde"].ToString()),
                        genel_iskonto_tutar = ReplaceDecimalNull(item["genel_iskonto_tutar"].ToString()),

                        fiyat_tutar1 = ReplaceDecimalNull(item["fiyat_tutar1"].ToString()),
                        fiyat_tutar2 = ReplaceDecimalNull(item["fiyat_tutar2"].ToString()),
                        fiyat_tutar3 = ReplaceDecimalNull(item["fiyat_tutar3"].ToString()),
                        fiyat_tutar4 = ReplaceDecimalNull(item["fiyat_tutar4"].ToString()),
                        fiyat_tutar5 = ReplaceDecimalNull(item["fiyat_tutar5"].ToString()),

                        vade_kodu1 = ReplaceStringNull(item["vade_kodu1"].ToString()),
                        vade_kodu2 = ReplaceStringNull(item["vade_kodu2"].ToString()),
                        vade_kodu3 = ReplaceStringNull(item["vade_kodu3"].ToString()),
                        vade_kodu4 = ReplaceStringNull(item["vade_kodu4"].ToString()),
                        vade_kodu5 = ReplaceStringNull(item["vade_kodu5"].ToString()),

                        iskonto_tutari1 = ReplaceDecimalNull(item["iskonto_tutari1"].ToString()),
                        iskonto_tutari2 = ReplaceDecimalNull(item["iskonto_tutari2"].ToString()),
                        iskonto_tutari3 = ReplaceDecimalNull(item["iskonto_tutari3"].ToString()),
                        iskonto_tutari4 = ReplaceDecimalNull(item["iskonto_tutari4"].ToString()),
                        iskonto_tutari5 = ReplaceDecimalNull(item["iskonto_tutari5"].ToString()),
                        iskonto_tutari6 = ReplaceDecimalNull(item["iskonto_tutari6"].ToString()),

                        indirim01_flag = ReplaceIntNull(item["indirim01_flag"].ToString()),
                        indirim02_flag = ReplaceIntNull(item["indirim02_flag"].ToString()),
                        indirim03_flag = ReplaceIntNull(item["indirim03_flag"].ToString()),
                        indirim04_flag = ReplaceIntNull(item["indirim04_flag"].ToString()),
                        indirim05_flag = ReplaceIntNull(item["indirim05_flag"].ToString()),
                        indirim06_flag = ReplaceIntNull(item["indirim06_flag"].ToString()),
                        cid = ReplaceStringNull(item["cid"].ToString()),

                        birim_fiyat_degistir = ReplaceIntNull(item["birim_fiyat_degistir"].ToString()),
                        gen_iskonto_degistir = ReplaceIntNull(item["gen_iskonto_degistir"].ToString()),
                        satir_iskonto_degistir = ReplaceIntNull(item["satir_iskonto_degistir"].ToString()),
                        vade_degistir = ReplaceIntNull(item["vade_degistir"].ToString()),
                        ortalama_tarih_hesapla = ReplaceIntNull(item["ortalama_tarih_hesapla"].ToString()),

                        liste_adi = ReplaceStringNull(item["liste_adi"].ToString()),
                        liste_birim = ReplaceStringNull(item["liste_birim"].ToString()),
                        baz_birim = ReplaceStringNull(item["baz_birim"].ToString()),
                        malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        satis_tipi = ReplaceStringNull(item["satis_tipi"].ToString()),
                        barkod = ReplaceStringNull(item["barkod"].ToString()),
                        stok_miktari = ReplaceDecimalNull(item["stok_miktari"].ToString()),

                        malzeme_adi = ReplaceStringNull(item["malzeme_adi"].ToString()),
                        kdv_orani = ReplaceDecimalNull(item["kdv_orani"].ToString()),
                        grup_adi1 = ReplaceStringNull(item["grup_adi1"].ToString()),
                        grup_adi2= ReplaceStringNull(item["grup_adi2"].ToString()),
                        grup_adi3= ReplaceStringNull(item["grup_adi3"].ToString())

                    };

                    fiyatList.Add(fiyat);
                }

                var json_serializer = new JavaScriptSerializer();
                result.Add(json_serializer.Serialize(fiyatList));

                List<BekleyenSiparis> siparisList = new List<BekleyenSiparis>();                
                foreach (DataRow item in dataSet.Tables[1].Rows)
                {
                    var siparis = new BekleyenSiparis()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        mus_rsayac = ReplaceIntNull(item["mus_rsayac"].ToString()),
                        siparis_no = ReplaceIntNull(item["siparis_no"].ToString()),
                        cid = ReplaceStringNull(item["cid"].ToString()),
                        musteri_no = ReplaceStringNull(item["musteri_no"].ToString()),
                        unvan = ReplaceStringNull(item["unvan"].ToString()),
                        teslim_musteri_no = ReplaceStringNull(item["teslim_musteri_no"].ToString()),
                        siparis_tarihi = ReplaceDateNull(item["siparis_tarihi"].ToString()),
                        siparis_asama = ReplaceStringNull(item["siparis_asama"].ToString()),
                        satis_tipi = ReplaceStringNull(item["satis_tipi"].ToString()),
                        satis_tipi_adi = ReplaceStringNull(item["satis_tipi_adi"].ToString()),
                        para_birimi = ReplaceStringNull(item["para_birimi"].ToString()),
                        temsilci = ReplaceStringNull(item["temsilci"].ToString()),
                        temsilci_adi = ReplaceStringNull(item["temsilci_adi"].ToString()),
                        siparis_tutari = ReplaceDecimalNull(item["siparis_tutari"].ToString()),
                        toplam_tutar = ReplaceDecimalNull(item["toplam_tutar"].ToString()),
                        indirim_tutari = ReplaceDecimalNull(item["indirim_tutari"].ToString()),
                        onay = ReplaceIntNull(item["onay"].ToString()),
                        toplam_kdv = ReplaceDecimalNull(item["toplam_kdv"].ToString()),
                        toplam_otv = ReplaceDecimalNull(item["toplam_otv"].ToString()),

                        sub_fatura_tipi_id = ReplaceStringNull(item["sub_fatura_tipi_id"].ToString()),
                        siparis_firma = ReplaceStringNull(item["siparis_firma"].ToString()),
                        aktarim_tipi = ReplaceStringNull(item["aktarim_tipi"].ToString()),
                        kullanici = ReplaceStringNull(item["kullanici"].ToString()),
                        sube_kodu = ReplaceStringNull(item["sube_kodu"].ToString()),
                        aciklama_android = ReplaceStringNull(item["aciklama_android"].ToString()),
                        sira_no = ReplaceIntNull(item["sira_no"].ToString()),
                        malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        birimi = ReplaceStringNull(item["birimi"].ToString()),
                        birim_fiyat = ReplaceDecimalNull(item["birim_fiyat"].ToString()),
                        miktar = ReplaceDecimalNull(item["miktar"].ToString()),
                        indirim = ReplaceStringNull(item["indirim"].ToString()),
                        asama = ReplaceStringNull(item["asama"].ToString()),
                        sevk_tarihi = ReplaceDateNull(item["sevk_tarihi"].ToString()),
                        teslim_tarihi = ReplaceDateNull(item["teslim_tarihi"].ToString()),

                        fatura_edilen_miktar = ReplaceDecimalNull(item["fatura_edilen_miktar"].ToString()),
                        bedelsiz = ReplaceIntNull(item["bedelsiz"].ToString()),
                        indirim01_flag = ReplaceIntNull(item["indirim01_flag"].ToString()),
                        indirim02_flag = ReplaceIntNull(item["indirim02_flag"].ToString()),
                        indirim03_flag = ReplaceIntNull(item["indirim03_flag"].ToString()),
                        indirim04_flag = ReplaceIntNull(item["indirim04_flag"].ToString()),
                        indirim05_flag = ReplaceIntNull(item["indirim05_flag"].ToString()),
                        indirim06_flag = ReplaceIntNull(item["indirim06_flag"].ToString()),
                        indirim01 = ReplaceDecimalNull(item["indirim01"].ToString()),
                        indirim02 = ReplaceDecimalNull(item["indirim02"].ToString()),
                        indirim03 = ReplaceDecimalNull(item["indirim03"].ToString()),
                        indirim04 = ReplaceDecimalNull(item["indirim04"].ToString()),
                        indirim05 = ReplaceDecimalNull(item["indirim05"].ToString()),
                        indirim06 = ReplaceDecimalNull(item["indirim06"].ToString()),
                        toplam_indirim = ReplaceDecimalNull(item["toplam_indirim"].ToString()),
                        satir_tutari = ReplaceDecimalNull(item["satir_tutari"].ToString()),
                        sablon_kodu = ReplaceStringNull(item["sablon_kodu"].ToString()),
                        kdv_orani = ReplaceDecimalNull(item["kdv_orani"].ToString()),
                        kdv_tutari = ReplaceDecimalNull(item["kdv_tutari"].ToString()),
                        tutar = ReplaceDecimalNull(item["tutar"].ToString()),
                        depo_no = ReplaceStringNull(item["depo_no"].ToString()),
                        tesis_no = ReplaceStringNull(item["tesis_no"].ToString()),
                        stok_tipi_no = ReplaceStringNull(item["stok_tipi_no"].ToString()),
                        grup_kodu = ReplaceStringNull(item["grup_kodu"].ToString()),
                        indirim_kodu = ReplaceStringNull(item["indirim_kodu"].ToString()),
                        kolibasi_kampanya_flag = ReplaceIntNull(item["kolibasi_kampanya_flag"].ToString()),
                        malzeme_adi= ReplaceStringNull(item["malzeme_adi"].ToString()),
                        grup_adi1= ReplaceStringNull(item["grup_adi1"].ToString()),
                        grup_adi2= ReplaceStringNull(item["grup_adi2"].ToString()),
                        grup_adi3= ReplaceStringNull(item["grup_adi3"].ToString()),
                        baz_birim= ReplaceStringNull(item["baz_birim"].ToString())
                    };
                    siparisList.Add(siparis);
                }

                result.Add(json_serializer.Serialize(siparisList));

            

            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            vr.successful = true;
            vr.result = result;

            return vr;

        }


        public ValidationResponseList GetCariVadefarki(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<CariVadeFarki> vadeFarklar = new List<CariVadeFarki>();

            SqlConnection sqlConnection = new SqlConnection(_connectionString);
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };


            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_car_vade_farki_analiz '{0}', '{1}' ", model.temsilci_kodu, model.cari_kod), sqlConnection);
                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);

                foreach (DataRow item in dataTable.Rows)
                {
                    var vadeFarki = new CariVadeFarki()
                    {
                        Id = ReplaceIntNull(item["Id"].ToString()),
                        cari_kodu = ReplaceStringNull(item["cari_kodu"].ToString()),
                        cari_unvan = ReplaceStringNull(item["cari_unvan"].ToString()),
                        fatura_no = ReplaceIntNull(item["fatura_no"].ToString()),
                        islem_tipi = ReplaceStringNull(item["islem_tipi"].ToString()),
                        
                        fis_tarihi = ReplaceStringNull(item["fis_tarihi"].ToString()),
                        vade_gun_sayisi = ReplaceIntNull(item["vade_gun_sayisi"].ToString()),
                        vade_tarihi= ReplaceStringNull(item["vade_tarihi"].ToString()),
                        borc_alacak = ReplaceStringNull(item["borc_alacak"].ToString()),
                        tefat_tutari=ReplaceDecimalNull(item["tefat_tutari"].ToString()),
                        tefat_bakiye_tutari= ReplaceDecimalNull(item["tefat_bakiye_tutari"].ToString()),
                        bakiye_toplami= ReplaceDecimalNull(item["bakiye_toplami"].ToString()),
                        tahsilat_gecikti= ReplaceStringNull(item["tahsilat_gecikti"].ToString()),
                        gecikme_gunu = ReplaceIntNull(item["gecikme_gunu"].ToString()),
                        son_bakiye_bakod= ReplaceStringNull(item["son_bakiye_bakod"].ToString())
                    };

                    vadeFarklar.Add(vadeFarki);
                }
            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> result = new List<string>();

            var json_serializer = new JavaScriptSerializer();            
            result.Add(json_serializer.Serialize(vadeFarklar));

            vr.result = result;
            vr.successful = true;

            return vr;

        }
        public ValidationResponseList GetCariHesapEkstresi(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<CariHesapEkstresi> ekstreler = new List<CariHesapEkstresi>();
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_cari_hesap_ekstresi '{0}', '{1}' ", model.temsilci_kodu, model.cari_kod), sqlConnection);
                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);

                foreach (DataRow item in dataTable.Rows)
                {
                    var ekstre = new CariHesapEkstresi()
                    {
                        Id = ReplaceIntNull(item["Id"].ToString()),
                        cari_kodu = ReplaceStringNull(item["cari_kodu"].ToString()),
                        cari_unvan = ReplaceStringNull(item["cari_unvan"].ToString()),
                        fis_no = ReplaceStringNull(item["fis_no"].ToString()),
                        resmi_belge_no = ReplaceStringNull(item["resmi_belge_no"].ToString()),
                        aciklama = ReplaceStringNull(item["aciklama"].ToString()),
                        evrak_tarihi = ReplaceStringNull(item["evrak_tarihi"].ToString()),
                        vade_tarihi = ReplaceStringNull(item["vade_tarihi"].ToString()),
                        borc=ReplaceDecimalNull(item["borc"].ToString()),
                        alacak= ReplaceDecimalNull(item["alacak"].ToString()),
                        bakiye= ReplaceDecimalNull(item["bakiye"].ToString()),
                        bakiye_borc_alacak= ReplaceStringNull(item["bakiye_borc_alacak"].ToString()),
                        fis_turu = ReplaceStringNull(item["fis_turu"].ToString())
                    };

                    ekstreler.Add(ekstre);
                }
            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> result = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            result.Add(json_serializer.Serialize(ekstreler));

            vr.result = result;
            vr.successful = true;

            return vr;
        }

        public ValidationResponseList GetCariKartlar(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<CariKart> cariKarts = new List<CariKart>();
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("exec mobil_cari '{0}'", model.temsilci_kodu), sqlConnection);

                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);

                foreach (DataRow item in dataTable.Rows)
                {
                    var _cari = new CariKart()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        cari_tipi = ReplaceStringNull(item["cari_tipi"].ToString()),
                        cid = ReplaceStringNull(item["cid"].ToString()),
                        kod = ReplaceStringNull(item["kod"].ToString()),
                        kodu2 = ReplaceStringNull(item["kodu2"].ToString()),
                        unvan = ReplaceStringNull(item["unvan"].ToString()),
                        semt = ReplaceStringNull(item["semt"].ToString()),
                        cari_adsoyad = ReplaceStringNull(item["cari_adsoyad"].ToString()),
                        temsilci_kodu = ReplaceStringNull(item["temsilci_kodu"].ToString()),
                        temsilci_adsoyad = ReplaceStringNull(item["temsilci_adsoyad"].ToString().Trim()),
                        tl_borc=ReplaceDecimalNull(item["tl_borc"].ToString()),
                        tl_alacak = ReplaceDecimalNull(item["tl_alacak"].ToString()),
                        tl_abakiye = ReplaceDecimalNull(item["tl_abakiye"].ToString()),
                        tl_bbakiye = ReplaceDecimalNull(item["tl_bbakiye"].ToString()),
                        calisilan_borc = ReplaceDecimalNull(item["calisilan_borc"].ToString()),
                        calisilan_alacak = ReplaceDecimalNull(item["calisilan_alacak"].ToString()),
                        calisilan_abakiye = ReplaceDecimalNull(item["calisilan_abakiye"].ToString()),
                        calisilan_bbakiye = ReplaceDecimalNull(item["calisilan_bbakiye"].ToString()),
                        calisilan_tur = ReplaceStringNull(item["calisilan_tur"].ToString()),
                        risk_tipi = ReplaceStringNull(item["risk_tipi"].ToString()),
                        risk_tipi_islem_durduruldu=ReplaceIntNull(item["risk_tipi_islem_durduruldu"].ToString()),
                        vergi_no= ReplaceStringNull(item["vergi_no"].ToString()),
                        risk_limiti = ReplaceDecimalNull(item["risk_limiti"].ToString()),

                        ust_kanal_kodu = ReplaceStringNull(item["ust_kanal_kodu"].ToString()),
                        kanal_kodu = ReplaceStringNull(item["kanal_kodu"].ToString()),
                        alt_kanal_kodu = ReplaceStringNull(item["alt_kanal_kodu"].ToString()),
                        ust_kanal_adi = ReplaceStringNull(item["ust_kanal_adi"].ToString()),
                        kanal_adi = ReplaceStringNull(item["kanal_adi"].ToString()),
                        alt_kanal_adi = ReplaceStringNull(item["alt_kanal_adi"].ToString()),
                        musteri_tipi = ReplaceStringNull(item["vergi_no"].ToString()),
                        efatura_kullanicisi = ReplaceIntNull(item["efatura_kullanicisi"].ToString()),

                        sehir = ReplaceStringNull(item["vergi_no"].ToString()),
                        ilce = ReplaceStringNull(item["ilce"].ToString()),
                        satis_bolge_kodu = ReplaceStringNull(item["satis_bolge_kodu"].ToString()),
                        satis_bolge_adi = ReplaceStringNull(item["satis_bolge_adi"].ToString()),
                        yetkili = ReplaceStringNull(item["yetkili"].ToString()),
                        tabela = ReplaceStringNull(item["tabela"].ToString()),
                        e_mail = ReplaceStringNull(item["e_mail"].ToString()),

                        gunlukSiparisTutar = ReplaceDecimalNull(item["gunlukSiparisTutar"].ToString()),
                        gunlukFaturaTutar = ReplaceDecimalNull(item["gunlukFaturaTutar"].ToString()),
                        gunlukTahsilatTutar = ReplaceDecimalNull(item["gunlukTahsilatTutar"].ToString()),
                        enlem= ReplaceStringNull(item["enlem"].ToString()),
                        boylam= ReplaceStringNull(item["boylam"].ToString())
                    };

                    cariKarts.Add(_cari);
                }
            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> result = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            result.Add(json_serializer.Serialize(cariKarts));

            vr.result = result;
            vr.successful = true;

            return vr;
        }

        public ValidationResponseList GetCariKartSubeler(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<CarKartSubeler> cariKartSubeler = new List<CarKartSubeler>();
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("exec mobil_cari_sube '{0}' ", model.temsilci_kodu), sqlConnection);
                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);

                foreach (DataRow item in dataTable.Rows)
                {
                    var cariKartSube = new CarKartSubeler()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        cari_sayac= ReplaceIntNull(item["cari_sayac"].ToString()),
                        sube_kodu=ReplaceStringNull(item["sube_kodu"].ToString()),
                        sube_adi = ReplaceStringNull(item["sube_adi"].ToString())
                    };
                    cariKartSubeler.Add(cariKartSube);
                }
            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> result = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            result.Add(json_serializer.Serialize(cariKartSubeler));

            vr.result = result;
            vr.successful = true;

            return vr;

        }

        public ValidationResponseList GetRutTanimi(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<RutTanimi> rutTanimis = new List<RutTanimi>();
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_rut '{0}' ", model.temsilci_kodu), sqlConnection);
                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);
                
                foreach (DataRow item in dataTable.Rows)
                {
                    var rutTanimi = new RutTanimi()
                    {                        
                        kod = ReplaceStringNull(item["kod"].ToString()),
                        gun = ReplaceStringNull(item["gun"].ToString()),
                        aktif=ReplaceIntNull(item["aktif"].ToString()),
                        gun_sira= ReplaceIntNull(item["gun_sira"].ToString()),
                        rut_sira_no= ReplaceIntNull(item["rut_sira_no"].ToString()),
                        aktifnoktasayisi= ReplaceIntNull(item["aktifnoktasayisi"].ToString()),
                        pasifnoktasayisi = ReplaceIntNull(item["pasifnoktasayisi"].ToString()),
                        rutSayac= ReplaceIntNull(item["rutSayac"].ToString()),
                        rutDetaySayac = ReplaceIntNull(item["rutDetaySayac"].ToString()),
                        bugun = ReplaceIntNull(item["bugun"].ToString()),

                    };
                    rutTanimis.Add(rutTanimi);
                }
            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> result = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            result.Add(json_serializer.Serialize(rutTanimis));

            vr.result = result;
            vr.successful = true;

            return vr;

        }

        public ValidationResponseList GetAylikSatis(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<AylikSatis> satislar = new List<AylikSatis>();
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_aylik_satis '{0}', '{1}' ", model.temsilci_kodu, model.cari_kod), sqlConnection);
                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);

                foreach (DataRow item in dataTable.Rows)
                {
                    var satis = new AylikSatis()
                    {
                        Id=ReplaceIntNull(item["Id"].ToString()),
                        ay = ReplaceIntNull(item["ay"].ToString()),
                        ay_str = ReplaceStringNull(item["ay_str"].ToString()),
                        dist_stok_kodu= ReplaceStringNull(item["dist_stok_kodu"].ToString()),
                        malzeme_kodu=ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        malzeme_adi = ReplaceStringNull(item["malzeme_adi"].ToString()),
                        birim = ReplaceStringNull(item["birim"].ToString()),
                        miktar =ReplaceDecimalNull(item["miktar"].ToString()),
                        ciro= ReplaceDecimalNull(item["ciro"].ToString()),
                        malzeme_sinifi_adi= ReplaceStringNull(item["malzeme_sinifi_adi"].ToString()),
                        malzeme_sinifi_id= ReplaceStringNull(item["malzeme_sinifi_id"].ToString()),
                        path= ReplaceStringNull(item["path"].ToString())

                    };
                    satislar.Add(satis);
                }
            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> result = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            result.Add(json_serializer.Serialize(satislar));

            vr.result = result;
            vr.successful = true;

            return vr;

        }

        //public List<Kasa> GetKasalar(SdrParametreModel model)
        //{
        //    string _connectionString = "";

        //    _connectionString = GetConnectionString(model.veritabani_adi);
        //    List<Kasa> kasalar = new List<Kasa>();

        //    SqlConnection sqlConnection = new SqlConnection(_connectionString);

        //    try
        //    {
        //        sqlConnection.Open();

        //        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_kasa '{0}' ", model.temsilci_kodu), sqlConnection);
        //        DataTable dataTable = new DataTable();
        //        sqlDataAdapter.Fill(dataTable);

        //        foreach (DataRow item in dataTable.Rows)
        //        {
        //            var kasa = new Kasa()
        //            {
        //                kod = ReplaceStringNull(item["kod"].ToString()),
        //                sorumlu = ReplaceStringNull(item["sorumlu"].ToString()),
        //                kredi_karti_kasasi=ReplaceIntNull(item["kredi_karti_kasasi"].ToString())
        //            };
        //            kasalar.Add(kasa);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new AppException(ex.Message);
        //    }
        //    finally
        //    {
        //        if (sqlConnection.State == ConnectionState.Open)
        //        {
        //            sqlConnection.Close();
        //        }
        //    }

        //    return kasalar;

        //}

        //public List<ZiyaretTipleri> GetZiyaretTipleri(ZiyaretParametreModel model)
        //{
        //    string _connectionString = "";

        //    _connectionString = GetConnectionString(model.veritabani_adi);
        //    List<ZiyaretTipleri> ziyaret_tipleri = new List<ZiyaretTipleri>();

        //    SqlConnection sqlConnection = new SqlConnection(_connectionString);

        //    try
        //    {
        //        sqlConnection.Open();

        //        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Select a.r_sayac, a.tipi, IsNull(a.aciklama,'') as aciklama from ziyaret_tipleri a "), sqlConnection);
        //        DataTable dataTable = new DataTable();
        //        sqlDataAdapter.Fill(dataTable);

        //        foreach (DataRow item in dataTable.Rows)
        //        {
        //            var ziyaret_tip = new ZiyaretTipleri()
        //            {
        //                r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
        //                tipi = ReplaceStringNull(item["tipi"].ToString()),
        //                aciklama = ReplaceStringNull(item["aciklama"].ToString())
        //            };
        //            ziyaret_tipleri.Add(ziyaret_tip);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new AppException(ex.Message);
        //    }
        //    finally
        //    {
        //        if (sqlConnection.State == ConnectionState.Open)
        //        {
        //            sqlConnection.Close();
        //        }
        //    }

        //    return ziyaret_tipleri;

        //}

        //public List<ZiyaretSonlandirmaTipleri> GetZiyaretSonlandirmaTipleri(ZiyaretParametreModel model)
        //{
        //    string _connectionString = "";

        //    _connectionString = GetConnectionString(model.veritabani_adi);
        //    List<ZiyaretSonlandirmaTipleri> ziyaret_sonlandirma_tipleri = new List<ZiyaretSonlandirmaTipleri>();

        //    SqlConnection sqlConnection = new SqlConnection(_connectionString);

        //    try
        //    {
        //        sqlConnection.Open();

        //        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Select a.r_sayac, a.tipi, IsNull(a.aciklama,'') as aciklama, a.sira,a.auto, " +
        //            "a.sabit, a.satisvar, a.zorunlu_aciklama from ziyaret_sonlandirma_tipleri a Order By a.sira "), sqlConnection);

        //        DataTable dataTable = new DataTable();
        //        sqlDataAdapter.Fill(dataTable);

        //        foreach (DataRow item in dataTable.Rows)
        //        {
        //            var ziyaret_sonlandirma_tip = new ZiyaretSonlandirmaTipleri()
        //            {
        //                r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
        //                tipi = ReplaceStringNull(item["tipi"].ToString()),
        //                aciklama = ReplaceStringNull(item["aciklama"].ToString()),
        //                sira=ReplaceIntNull(item["sira"].ToString()),
        //                auto=ReplaceIntNull(item["auto"].ToString()),
        //                sabit=ReplaceIntNull(item["sabit"].ToString()),
        //                satisvar= ReplaceIntNull(item["satisvar"].ToString()),
        //                zorunlu_aciklama = ReplaceIntNull(item["zorunlu_aciklama"].ToString())

        //            };
        //            ziyaret_sonlandirma_tipleri.Add(ziyaret_sonlandirma_tip);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new AppException(ex.Message);
        //    }
        //    finally
        //    {
        //        if (sqlConnection.State == ConnectionState.Open)
        //        {
        //            sqlConnection.Close();
        //        }
        //    }

        //    return ziyaret_sonlandirma_tipleri;

        //}

        private ValidationResponse GetZiyaret(Ziyaret item, AktarimParameterModel model, ref int sayac)
        {
            string _connectionString = "";
            ValidationResponse vr = new ValidationResponse() { successful = true, information = "", code = "", result = "" };

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<ZiyaretSonlandirmaTipleri> ziyaret_sonlandirma_tipleri = new List<ZiyaretSonlandirmaTipleri>();            
            try
            {
                SqlCommand cmd;
                SqlConnection sqlConnection = new SqlConnection(_connectionString);
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                if (sqlConnection.State == ConnectionState.Closed)
                    sqlConnection.Open();

                cmd.CommandText = "Select a.r_sayac from android_gps_kayitlari a Where a.temsilci_kodu=@temsilci_kodu And a.musteri_kodu=@cari_kodu " +
                    "And a.giris_tarihi=@start_date And a.cikis_tarihi=@end_date ";
                cmd.Connection = sqlConnection;
                cmd.Parameters.Add("@temsilci_kodu", SqlDbType.VarChar).Value = ReplaceStringNull(model.temsilci_kodu.ToString());
                cmd.Parameters.Add("@cari_kodu", SqlDbType.VarChar).Value = item.cari_kodu.ToString();
                cmd.Parameters.Add("@start_date", SqlDbType.DateTime).Value = ReplaceDateNullAktarim(item.start_date.ToString());
                cmd.Parameters.Add("@end_date", SqlDbType.DateTime).Value = ReplaceDateNullAktarim(item.end_date.ToString());
                
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);
                foreach (DataRow dr in dataTable.Rows)
                {
                    sayac = ReplaceIntNull(dr["r_sayac"].ToString());
                }

                if (sayac==0)
                {
                    cmd = new SqlCommand();
                    cmd.Connection = sqlConnection;
                    cmd.CommandText = "insert into android_gps_kayitlari " +
                        "([cid], [temsilci_kodu], [musteri_kodu], [giris_tarihi], [cikis_tarihi], [giris_enlem], [giris_boylam], [cikis_enlem], [cikis_boylam], [rut_detay_sayac], " +
                        "[rut_detay_gun], [fatura_toplam], [siparis_toplam], [tahsilat_toplam], [ziyaret_tipi_sayac], [ziyaret_sonlandirma_tipi_sayac], [aciklama], [aktarildi]) " +
                        "values (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11, @p12, @p13, @p14, @p15, @p16, @p17) ;  SET @r_sayac = SCOPE_IDENTITY() ";

                    cmd.Parameters.Add("@p0", SqlDbType.VarChar).Value = "JOT";
                    cmd.Parameters.Add("@p1", SqlDbType.VarChar).Value = ReplaceStringNull(model.temsilci_kodu.ToString());
                    cmd.Parameters.Add("@p2", SqlDbType.VarChar).Value = item.cari_kodu.ToString();
                    cmd.Parameters.Add("@p3", SqlDbType.DateTime).Value = ReplaceDateNullAktarim(item.start_date.ToString());
                    cmd.Parameters.Add("@p4", SqlDbType.DateTime).Value = ReplaceDateNullAktarim(item.end_date.ToString());
                    cmd.Parameters.Add("@p5", SqlDbType.Decimal).Value = ReplaceDecimalNull(item.start_latitude.ToString());
                    cmd.Parameters.Add("@p6", SqlDbType.Decimal).Value = ReplaceDecimalNull(item.start_longitude.ToString());
                    cmd.Parameters.Add("@p7", SqlDbType.Decimal).Value = ReplaceDecimalNull(item.end_latitude.ToString());
                    cmd.Parameters.Add("@p8", SqlDbType.Decimal).Value = ReplaceDecimalNull(item.end_longitude.ToString());
                    cmd.Parameters.Add("@p9", SqlDbType.Int).Value = ReplaceIntNull(item.rut_detay_sayac.ToString());

                    cmd.Parameters.Add("@p10", SqlDbType.Int).Value = ReplaceIntNull(item.rut_detay_gun.ToString());
                    cmd.Parameters.Add("@p11", SqlDbType.Decimal).Value = ReplaceDecimalNull(item.fatura_toplam.ToString());
                    cmd.Parameters.Add("@p12", SqlDbType.Decimal).Value = ReplaceDecimalNull(item.siparis_toplam.ToString());
                    cmd.Parameters.Add("@p13", SqlDbType.Decimal).Value = ReplaceDecimalNull(item.tahsilat_toplam.ToString());
                    cmd.Parameters.Add("@p14", SqlDbType.Int).Value = ReplaceIntNull(item.ziyaret_tipi_sayac.ToString());
                    cmd.Parameters.Add("@p15", SqlDbType.Int).Value = ReplaceIntNull(item.ziyaret_sonlandirma_tipi_sayac.ToString());
                    cmd.Parameters.Add("@p16", SqlDbType.VarChar).Value = ReplaceStringNull(item.aciklama.ToString()); //aciklama
                    cmd.Parameters.Add("@p17", SqlDbType.Int).Value = 1; //aktarildi.
                    cmd.Parameters.Add("@r_sayac", SqlDbType.Int).Direction = ParameterDirection.Output;

                    cmd.ExecuteNonQuery();
                    sayac = Convert.ToInt32(cmd.Parameters["@r_sayac"].Value);
                    if (ReplaceIntNull(sayac.ToString()) == 0)
                    {
                        vr.successful = false;
                        vr.information = "Ziyaretleri atarken hata: Android gps kayıtları atılamadı.";
                        return vr;
                    }
                }
                
            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = "Ziyaretleri atarken hata:" + ex.Message.ToString();
                return vr;                
            }

            vr.successful = true;
            vr.information = "";
            return vr;


        }

        public ValidationResponse SetZiyaret(List<Ziyaret> ziyaretler, AktarimParameterModel model)
        {
            string _connectionString = "";
            ValidationResponse vr = new ValidationResponse() { successful = true, information = "", code = "", result = "" };
            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);
            try
            {                
                foreach (Ziyaret item in ziyaretler)
                {
                    int sayac = 0;
                    vr = GetZiyaret(item, model, ref sayac);
                    if (vr.successful == false)
                    {
                        return vr;
                    }
                }
            }
            catch (Exception ex)
            {
                vr.information = ex.Message;
                vr.successful = false;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }
            vr.information = "";
            vr.successful = true;
            return vr;


        }


        public ValidationResponse SetTahsilat(List<Tahsilat> tahsilatlar,List<Ziyaret> ziyaretler ,AktarimParameterModel model)
        {
            string _connectionString = "";
            ValidationResponse vr = new ValidationResponse() { successful = true, information = "", code = "", result = "" };

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<ZiyaretSonlandirmaTipleri> ziyaret_sonlandirma_tipleri = new List<ZiyaretSonlandirmaTipleri>();

            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            try
            {
                XmlDocument doc = new XmlDocument();
                XmlElement root = doc.CreateElement("TransactionList");

                XmlElement parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("cid", "JOT");
                root.AppendChild(parameter);

                parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("satis_temsilci_kodu", model.temsilci_kodu.ToString());
                root.AppendChild(parameter);

                parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("user_id", model.user_id.ToString());
                root.AppendChild(parameter);

                parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("android_versiyon", model.android_versiyon.ToString());
                root.AppendChild(parameter);

                SqlCommand cmd;
                foreach (Ziyaret item in ziyaretler)
                {
                    try
                    {
                        int sayac = 0;
                        vr=GetZiyaret(item, model, ref sayac);
                        if (vr.successful==false)
                        {
                            return vr;
                        }

                        XmlElement Kayit1 = doc.CreateElement("Kayit1");
                        Kayit1.SetAttribute("r_sayac", ReplaceStringNull(sayac.ToString()));
                        Kayit1.SetAttribute("temsilci_kodu", ReplaceStringNull(model.temsilci_kodu.ToString()));
                        Kayit1.SetAttribute("musteri_kodu", ReplaceStringNull(item.cari_kodu.ToString()));
                        Kayit1.SetAttribute("giris_tarihi", ReplaceDateNullAktarim(item.start_date.ToString()).ToString());
                        Kayit1.SetAttribute("cikis_tarihi", ReplaceDateNullAktarim(item.end_date.ToString()).ToString());
                        Kayit1.SetAttribute("giris_enlem", ReplaceDecimalNull(item.start_latitude.ToString()).ToString());
                        Kayit1.SetAttribute("giris_boylam", ReplaceDecimalNull(item.start_longitude.ToString()).ToString());
                        Kayit1.SetAttribute("cikis_enlem", ReplaceDecimalNull(item.end_latitude.ToString()).ToString());
                        Kayit1.SetAttribute("cikis_boylam", ReplaceDecimalNull(item.end_longitude.ToString()).ToString());
                        Kayit1.SetAttribute("siparis_toplam", ReplaceDecimalNull(item.siparis_toplam.ToString()).ToString().Replace(',', '.'));
                        Kayit1.SetAttribute("fatura_toplam", ReplaceDecimalNull(item.fatura_toplam.ToString()).ToString().Replace(',','.'));
                        Kayit1.SetAttribute("tahsilat_toplam", ReplaceDecimalNull(item.tahsilat_toplam.ToString()).ToString().Replace(',', '.'));
                        Kayit1.SetAttribute("rut_detay_sayac", ReplaceIntNull(item.rut_detay_sayac.ToString()).ToString());
                        Kayit1.SetAttribute("rut_detay_gun", ReplaceIntNull(item.rut_detay_gun.ToString()).ToString());

                        Kayit1.SetAttribute("ziyaret_tipi_sayac", ReplaceIntNull(item.ziyaret_tipi_sayac.ToString()).ToString());
                        Kayit1.SetAttribute("ziyaret_sonlandirma_tipi_sayac", ReplaceIntNull(item.ziyaret_sonlandirma_tipi_sayac.ToString()).ToString());
                        Kayit1.SetAttribute("aciklama", "");
                        Kayit1.SetAttribute("aktarildi", "1");
                        root.AppendChild(Kayit1);
                        
                        foreach (Tahsilat tahsilat in tahsilatlar)
                        {
                            if (item.id==tahsilat.android_gps_sayac)
                            {
                                ValidationResponse kasa=new ValidationResponse() {successful=true};
                                kasa = GetKasaKodu(tahsilat.kasa, _connectionString);
                                if (!kasa.successful)
                                { vr = kasa; return vr; }

                                string fis_tur = tahsilat.fis_tur.ToString();
                                if (fis_tur == "K.Kartı Tahsilatı")
                                {                                    
                                    fis_tur = "Nakit Tahsilat";
                                }

                                XmlElement kayit3 = doc.CreateElement("Kayit3");
                                kayit3.SetAttribute("r_sayac", ReplaceStringNull(tahsilat.r_sayac.ToString()));
                                kayit3.SetAttribute("cid", ReplaceStringNull(tahsilat.cid.ToString()));
                                kayit3.SetAttribute("temsilci_kodu", ReplaceStringNull(tahsilat.temsilci_kodu.ToString()));
                                kayit3.SetAttribute("cari_kodu", ReplaceStringNull(tahsilat.cari_kodu.ToString()));
                                
                                kayit3.SetAttribute("tarih", ReplaceDateNullAktarim(tahsilat.tarih.ToString()).ToString());
                                kayit3.SetAttribute("kasa", ReplaceStringNull(kasa.code));
                                kayit3.SetAttribute("fiyat", ReplaceDecimalNull(tahsilat.fiyat.ToString()).ToString().Replace(",","."));
                                kayit3.SetAttribute("fis_tur", ReplaceStringNull(fis_tur));
                                kayit3.SetAttribute("mut_no", ReplaceStringNull(tahsilat.mut_no.ToString()));

                                var mut_no2 = ReplaceStringNull(tahsilat.mut_no2.ToString());
                                mut_no2 = mut_no2 + ";" + ReplaceStringNull(tahsilat.slipno);
                                kayit3.SetAttribute("mut_no2", mut_no2.ToString());

                                var mut_no3 = ReplaceStringNull(tahsilat.mut_no3.ToString());
                                mut_no3 = mut_no3 + ";" + ReplaceStringNull(tahsilat.kartno);

                                kayit3.SetAttribute("mut_no3", mut_no3.ToString());
                                kayit3.SetAttribute("android_gps_sayac", sayac.ToString());
                                kayit3.SetAttribute("aciklama", tahsilat.aciklama.ToString());
                                root.AppendChild(kayit3);
                            }                            
                        }

                    }
                    catch (Exception ex)
                    {
                        vr.successful = false;
                        vr.information = "Ziyaretleri atarken hata:" + ex.Message.ToString();
                        return vr;
                    }

                }
                
                doc.AppendChild(root);
                string inXML = "";
                inXML = doc.InnerXml;
                inXML = inXML.Replace("<TransactionList xmlns=\"http://tempuri.org/\">", "<TransactionList>");
                inXML = inXML.Replace("''", "' '");

                StringBuilder sb = new StringBuilder("\" ");
                for (int i = 2; i < 255; i++)
                {
                    sb.Append(" ");
                    inXML = inXML.Replace((sb.ToString() + "\""), "\"\"");
                }
        
                Encoding srcEnc = Encoding.GetEncoding(1252);
                Encoding targetEnc = Encoding.UTF8;
                byte[] srcBytes;
                byte[] encBytes;        

                srcBytes = srcEnc.GetBytes(inXML);
                encBytes = Encoding.Convert(srcEnc, targetEnc, srcBytes);
                inXML = targetEnc.GetString(encBytes);

                if (sqlConnection.State == ConnectionState.Closed)
                    sqlConnection.Open();

                cmd = new SqlCommand("ws_server_nakit_tahsilat_insert_android", sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;                
                cmd.Parameters.Add("@oXML", SqlDbType.NText).Value = inXML;
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {                
                vr.information = ex.Message;
                vr.successful = false;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            vr.information = "";
            vr.successful = true;
            return vr;
        }

        private int ReplaceIntNull(string value)
        {
            if (Convert.IsDBNull(value))
            {
                return 0;
            }
            else
            {
                if (string.IsNullOrEmpty(value))
                    value = "0";

                return Convert.ToInt32(value);
            }
        }
        private string ReplaceStringNull(string value)
        {
            if (Convert.IsDBNull(value))
            {
                return "";
            }
            else
            {
                if (string.IsNullOrEmpty(value))
                    value = "";

                return value;
            }
        }
        private decimal ReplaceDecimalNull(string value)
        {
            if (Convert.IsDBNull(value))
            {
                return Convert.ToDecimal(0);
            }
            else
            {
                if (string.IsNullOrEmpty(value))
                    value = "0";

                return Convert.ToDecimal(value);
            }
        }

        private double ReplaceDoubleNull(string value)
        {
            if (Convert.IsDBNull(value))
            {
                return Convert.ToDouble(0);
            }
            else
            {
                if (string.IsNullOrEmpty(value))
                    value = "0";

                return Convert.ToDouble(value);
            }
        }
        private string ReplaceDateNullAktarim(string value)
        {
            if (Convert.IsDBNull(value))
            {
                return DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.000");
            }
            else
            {
                if (string.IsNullOrEmpty(value))
                    value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.000");

                return value;
            }
        }


        private DateTime ReplaceDateNull(string value)
        {
            if (Convert.IsDBNull(value))
            {
                return DateTime.Now;
            }
            else
            {
                if (string.IsNullOrEmpty(value))
                    value = DateTime.Now.ToString();

                return Convert.ToDateTime(value);
            }
        }

        public DateTime ReplaceDateTimeNull(string value)
        {
            if (Convert.IsDBNull(value))
            {
                return DateTime.Now;
            }
            else
            {
                if (string.IsNullOrEmpty(value))
                    value = DateTime.Now.ToString();

                return Convert.ToDateTime(value);
            }
        }

        public string GetConnectionString(string veritabani_adi)
        {
            string _connectionString = "";
            string found_veritabani = "";

            connectionString = Configuration.GetConnectionString("DefaultConnection");

            int found = connectionString.IndexOf("Initial Catalog=");
            if (found > 0)
            {
                found_veritabani = connectionString.Substring(found + 16, connectionString.Length - (found + 16));
                if (found_veritabani.IndexOf(";") > 0)
                {
                    found_veritabani = found_veritabani.Substring(0, found_veritabani.IndexOf(";"));
                }

                _connectionString = connectionString.Replace(found_veritabani, veritabani_adi);
            }

            return _connectionString;
        }

        public ValidationResponse GetKasaKodu(string kasa, string fconnectionString)
        {
            ValidationResponse vr = new ValidationResponse() { successful = false, information = "" };
            try
            {
                
                SqlConnection sqlConnection = new SqlConnection(fconnectionString);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                if (sqlConnection.State == ConnectionState.Closed)
                    sqlConnection.Open();

                cmd.Connection = sqlConnection;                
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Select a.kod from kas_kart a Where a.sorumlu='{0}'", kasa.ToString()), sqlConnection);
                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);

                foreach (DataRow item in dataTable.Rows)
                {
                    vr.code = ReplaceStringNull(item["kod"].ToString());
                }
                vr.successful = true;                
            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;                
            }
            return vr;

        }
                
        public ValidationResponseList GetSatisTipleri(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<SatisTipi> satisTipis = new List<SatisTipi>();
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_satis_tipleri '{0}' ", model.temsilci_kodu), sqlConnection);
                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);

                foreach (DataRow item in dataTable.Rows)
                {
                    var satisTipi = new SatisTipi()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        aciklama = ReplaceStringNull(item["aciklama"].ToString()),                        
                        depo_no = ReplaceStringNull(item["depo_no"].ToString()),
                        fatura_tipi_id = ReplaceStringNull(item["fatura_tipi_id"].ToString()),
                        fiyat_tipi = ReplaceStringNull(item["fiyat_tipi"].ToString()),
                        goster = ReplaceIntNull(item["goster"].ToString()),                        
                        hareket_tipi_id = ReplaceStringNull(item["hareket_tipi_id"].ToString()),
                        iade= ReplaceIntNull(item["iade"].ToString()),
                        iade_hareket_tipi_id= ReplaceStringNull(item["iade_hareket_tipi_id"].ToString()),
                        kampanyalari_otomatik_uygula= ReplaceIntNull(item["kampanyalari_otomatik_uygula"].ToString()),
                        sak_kontrol_no= ReplaceStringNull(item["sak_kontrol_no"].ToString()),                        
                        satis_tipi = ReplaceStringNull(item["satis_tipi"].ToString()),
                        satis_tip_id = ReplaceStringNull(item["satis_tip_id"].ToString()),
                        stok_tipi_no = ReplaceStringNull(item["stok_tipi_no"].ToString()),
                        tesis_no = ReplaceStringNull(item["tesis_no"].ToString()),

                        tablo_no = ReplaceStringNull(item["tablo_no"].ToString()),                        
                        alis_fiyat_tipi = ReplaceStringNull(item["alis_fiyat_tipi"].ToString()),
                        satis_fiyat_tipi = ReplaceStringNull(item["satis_fiyat_tipi"].ToString()),

                        satis_fiyati1 = ReplaceIntNull(item["satis_fiyati1"].ToString()),
                        satis_fiyati2 = ReplaceIntNull(item["satis_fiyati2"].ToString()),
                        satis_fiyati3 = ReplaceIntNull(item["satis_fiyati3"].ToString()),
                        satis_fiyati4 = ReplaceIntNull(item["satis_fiyati4"].ToString()),
                        satis_fiyati5 = ReplaceIntNull(item["satis_fiyati5"].ToString()),

                        alis_fiyati1 = ReplaceIntNull(item["alis_fiyati1"].ToString()),
                        alis_fiyati2 = ReplaceIntNull(item["alis_fiyati2"].ToString()),
                        alis_fiyati3 = ReplaceIntNull(item["alis_fiyati3"].ToString()),
                        alis_fiyati4 = ReplaceIntNull(item["alis_fiyati4"].ToString()),
                        alis_fiyati5 = ReplaceIntNull(item["alis_fiyati5"].ToString()),

                        vade_alis1 = ReplaceIntNull(item["vade_alis1"].ToString()),
                        vade_alis2 = ReplaceIntNull(item["vade_alis2"].ToString()),
                        vade_alis3 = ReplaceIntNull(item["vade_alis3"].ToString()),
                        vade_alis4 = ReplaceIntNull(item["vade_alis4"].ToString()),
                        vade_alis5 = ReplaceIntNull(item["vade_alis5"].ToString()),

                        vade_satis1 = ReplaceIntNull(item["vade_satis1"].ToString()),
                        vade_satis2 = ReplaceIntNull(item["vade_satis2"].ToString()),
                        vade_satis3 = ReplaceIntNull(item["vade_satis3"].ToString()),
                        vade_satis4 = ReplaceIntNull(item["vade_satis4"].ToString()),
                        vade_satis5 = ReplaceIntNull(item["vade_satis5"].ToString()),

                        iskonto1 = ReplaceIntNull(item["iskonto1"].ToString()),
                        iskonto2 = ReplaceIntNull(item["iskonto2"].ToString()),
                        iskonto3 = ReplaceIntNull(item["iskonto3"].ToString()),
                        iskonto4 = ReplaceIntNull(item["iskonto4"].ToString()),
                        iskonto5 = ReplaceIntNull(item["iskonto5"].ToString()),
                        iskonto6 = ReplaceIntNull(item["iskonto6"].ToString()),

                        cari_vadesi_gelsin = ReplaceIntNull(item["cari_vadesi_gelsin"].ToString()),
                        genel_iskonto_yuzde = ReplaceIntNull(item["genel_iskonto_yuzde"].ToString()),
                        genel_iskonto = ReplaceDecimalNull(item["genel_iskonto"].ToString()),

                        alis_iskonto1 = ReplaceIntNull(item["alis_iskonto1"].ToString()),
                        alis_iskonto2 = ReplaceIntNull(item["alis_iskonto2"].ToString()),
                        alis_iskonto3 = ReplaceIntNull(item["alis_iskonto3"].ToString()),
                        alis_iskonto4 = ReplaceIntNull(item["alis_iskonto4"].ToString()),
                        alis_iskonto5 = ReplaceIntNull(item["alis_iskonto5"].ToString()),
                        alis_iskonto6 = ReplaceIntNull(item["alis_iskonto6"].ToString()),

                        vade_alis_kodu1 = ReplaceStringNull(item["vade_alis_kodu1"].ToString()),
                        vade_alis_kodu2 = ReplaceStringNull(item["vade_alis_kodu2"].ToString()),
                        vade_alis_kodu3 = ReplaceStringNull(item["vade_alis_kodu3"].ToString()),
                        vade_alis_kodu4 = ReplaceStringNull(item["vade_alis_kodu4"].ToString()),
                        vade_alis_kodu5 = ReplaceStringNull(item["vade_alis_kodu5"].ToString()),

                        vade_satis_kodu1 = ReplaceStringNull(item["vade_satis_kodu1"].ToString()),
                        vade_satis_kodu2 = ReplaceStringNull(item["vade_satis_kodu2"].ToString()),
                        vade_satis_kodu3 = ReplaceStringNull(item["vade_satis_kodu3"].ToString()),
                        vade_satis_kodu4 = ReplaceStringNull(item["vade_satis_kodu4"].ToString()),
                        vade_satis_kodu5 = ReplaceStringNull(item["vade_satis_kodu5"].ToString()),
                        fiyat_listesi = ReplaceIntNull(item["fiyat_listesi"].ToString()),
                        birim_fiyat_degistir = ReplaceIntNull(item["birim_fiyat_degistir"].ToString()),
                        gen_iskonto_degistir = ReplaceIntNull(item["gen_iskonto_degistir"].ToString()),
                        satir_iskonto_degistir = ReplaceIntNull(item["satir_iskonto_degistir"].ToString()),
                        borc_kapatma = ReplaceIntNull(item["borc_kapatma"].ToString()),
                        fat_basimi_yapilsin = ReplaceIntNull(item["fat_basimi_yapilsin"].ToString()),

                        fat_seri_no = ReplaceStringNull(item["fat_seri_no"].ToString()),
                        odeme_tarih_hesapla = ReplaceIntNull(item["odeme_tarih_hesapla"].ToString()),
                        sak_kullanim_sekli = ReplaceIntNull(item["sak_kullanim_sekli"].ToString()),
                        sak_tablosu = ReplaceStringNull(item["sak_tablosu"].ToString()),
                        toplu_mal_ayirma = ReplaceIntNull(item["toplu_mal_ayirma"].ToString()),
                        irsaliye_basimi = ReplaceIntNull(item["irsaliye_basimi"].ToString()),
                        irsaliye_seri_no = ReplaceStringNull(item["irsaliye_seri_no"].ToString()),
                        siparis_yapilsin = ReplaceIntNull(item["siparis_yapilsin"].ToString()),

                        kamyonlastirma_yapilsin = ReplaceIntNull(item["kamyonlastirma_yapilsin"].ToString()),
                        irsaliye_yapilsin = ReplaceIntNull(item["irsaliye_yapilsin"].ToString()),
                        fatura_yapilsin = ReplaceIntNull(item["fatura_yapilsin"].ToString()),
                        kontrol_no = ReplaceStringNull(item["kontrol_no"].ToString()),
                        
                        vade_degistir = ReplaceIntNull(item["vade_degistir"].ToString()),
                        sts_irs_seri_no_rsayac = ReplaceIntNull(item["sts_irs_seri_no_rsayac"].ToString()),
                        sts_irs_basili_form_rsayac = ReplaceIntNull(item["sts_irs_basili_form_rsayac"].ToString()),
                        sts_fat_seri_no_rsayac = ReplaceIntNull(item["sts_fat_seri_no_rsayac"].ToString()),

                        sts_fat_basili_form_rsayac = ReplaceIntNull(item["sts_fat_basili_form_rsayac"].ToString()),
                        sts_fat_irs_basili_form_rsayac = ReplaceIntNull(item["sts_fat_irs_basili_form_rsayac"].ToString()),
                        sts_iade_irsaliye_basimi = ReplaceIntNull(item["sts_iade_irsaliye_basimi"].ToString()),
                        sts_iade_irs_seri_no_rsayac = ReplaceIntNull(item["sts_iade_irs_seri_no_rsayac"].ToString()),
                        sts_iade_irs_basili_form_rsayac = ReplaceIntNull(item["sts_iade_irs_basili_form_rsayac"].ToString()),
                        sts_iade_fatura_basimi = ReplaceIntNull(item["sts_iade_fatura_basimi"].ToString()),
                        sts_iade_fat_seri_no_rsayac = ReplaceIntNull(item["sts_iade_fat_seri_no_rsayac"].ToString()),
                        sts_iade_fat_basili_form_rsayac = ReplaceIntNull(item["sts_iade_fat_basili_form_rsayac"].ToString())


                    };

                    satisTipis.Add(satisTipi);
                }
            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> result = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            result.Add(json_serializer.Serialize(satisTipis));

            vr.result = result;
            vr.successful = true;

            return vr;
        }

        //public List<Fiyat> GetSatisFiyatlari(SdrParametreModel model)
        //{
        //    string _connectionString = "";

        //    _connectionString = GetConnectionString(model.veritabani_adi);
        //    List<Fiyat> fiyatList = new List<Fiyat>();

        //    SqlConnection sqlConnection = new SqlConnection(_connectionString);

        //    try
        //    {
        //        sqlConnection.Open();
        //        String tarih = String.Format("{0:yyyy/MM/dd}", model.tarih);

        //        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_fiyat_listesi '{0}','{1}','{2}' ", model.temsilci_kodu, model.cari_kod, tarih.ToString()), sqlConnection);
        //        DataTable dataTable = new DataTable();
        //        sqlDataAdapter.Fill(dataTable);

        //        foreach (DataRow item in dataTable.Rows)
        //        {
        //            var fiyat = new Fiyat()
        //            {
        //                kod = ReplaceStringNull(item["kod"].ToString()),
        //                fiyat_tipi = ReplaceStringNull(item["fiyat_tipi"].ToString()),
        //                para_birimi = ReplaceStringNull(item["para_birimi"].ToString()),                        
        //                fiyat1 = ReplaceIntNull(item["fiyat1"].ToString()),
        //                fiyat2 = ReplaceIntNull(item["fiyat2"].ToString()),
        //                fiyat3 = ReplaceIntNull(item["fiyat3"].ToString()),
        //                fiyat4 = ReplaceIntNull(item["fiyat4"].ToString()),
        //                fiyat5 = ReplaceIntNull(item["fiyat5"].ToString()),

        //                kdvli_fiyat1 = ReplaceIntNull(item["kdvli_fiyat1"].ToString()),
        //                kdvli_fiyat2 = ReplaceIntNull(item["kdvli_fiyat2"].ToString()),
        //                kdvli_fiyat3 = ReplaceIntNull(item["kdvli_fiyat3"].ToString()),
        //                kdvli_fiyat4 = ReplaceIntNull(item["kdvli_fiyat4"].ToString()),
        //                kdvli_fiyat5 = ReplaceIntNull(item["kdvli_fiyat5"].ToString()),

        //                vade1 = ReplaceIntNull(item["vade1"].ToString()),
        //                vade2 = ReplaceIntNull(item["vade2"].ToString()),
        //                vade3 = ReplaceIntNull(item["vade3"].ToString()),
        //                vade4 = ReplaceIntNull(item["vade4"].ToString()),
        //                vade5 = ReplaceIntNull(item["vade5"].ToString()),

        //                iskonto1 = ReplaceIntNull(item["iskonto1"].ToString()),
        //                iskonto2 = ReplaceIntNull(item["iskonto2"].ToString()),
        //                iskonto3 = ReplaceIntNull(item["iskonto3"].ToString()),
        //                iskonto4 = ReplaceIntNull(item["iskonto4"].ToString()),
        //                iskonto5 = ReplaceIntNull(item["iskonto5"].ToString()),
        //                iskonto6 = ReplaceIntNull(item["iskonto6"].ToString()),
        //                genel_iskonto_yuzde = ReplaceIntNull(item["genel_iskonto_yuzde"].ToString()),
        //                genel_iskonto_tutar = ReplaceDecimalNull(item["genel_iskonto_tutar"].ToString()),

        //                fiyat_tutar1 = ReplaceDecimalNull(item["fiyat_tutar1"].ToString()),
        //                fiyat_tutar2 = ReplaceDecimalNull(item["fiyat_tutar2"].ToString()),
        //                fiyat_tutar3 = ReplaceDecimalNull(item["fiyat_tutar3"].ToString()),
        //                fiyat_tutar4 = ReplaceDecimalNull(item["fiyat_tutar4"].ToString()),
        //                fiyat_tutar5 = ReplaceDecimalNull(item["fiyat_tutar5"].ToString()),

        //                vade_kodu1 = ReplaceStringNull(item["vade_kodu1"].ToString()),
        //                vade_kodu2 = ReplaceStringNull(item["vade_kodu2"].ToString()),
        //                vade_kodu3 = ReplaceStringNull(item["vade_kodu3"].ToString()),
        //                vade_kodu4 = ReplaceStringNull(item["vade_kodu4"].ToString()),
        //                vade_kodu5 = ReplaceStringNull(item["vade_kodu5"].ToString()),

        //                iskonto_tutari1 = ReplaceDecimalNull(item["iskonto_tutari1"].ToString()),
        //                iskonto_tutari2 = ReplaceDecimalNull(item["iskonto_tutari2"].ToString()),
        //                iskonto_tutari3 = ReplaceDecimalNull(item["iskonto_tutari3"].ToString()),
        //                iskonto_tutari4 = ReplaceDecimalNull(item["iskonto_tutari4"].ToString()),
        //                iskonto_tutari5 = ReplaceDecimalNull(item["iskonto_tutari5"].ToString()),
        //                iskonto_tutari6 = ReplaceDecimalNull(item["iskonto_tutari6"].ToString()),

        //                indirim01_flag = ReplaceIntNull(item["indirim01_flag"].ToString()),
        //                indirim02_flag = ReplaceIntNull(item["indirim02_flag"].ToString()),
        //                indirim03_flag = ReplaceIntNull(item["indirim03_flag"].ToString()),
        //                indirim04_flag = ReplaceIntNull(item["indirim04_flag"].ToString()),
        //                indirim05_flag = ReplaceIntNull(item["indirim05_flag"].ToString()),
        //                indirim06_flag = ReplaceIntNull(item["indirim06_flag"].ToString()),
        //                cid = ReplaceStringNull(item["cid"].ToString()),

        //                birim_fiyat_degistir= ReplaceIntNull(item["birim_fiyat_degistir"].ToString()),
        //                gen_iskonto_degistir = ReplaceIntNull(item["gen_iskonto_degistir"].ToString()),
        //                satir_iskonto_degistir = ReplaceIntNull(item["satir_iskonto_degistir"].ToString()),
        //                vade_degistir = ReplaceIntNull(item["vade_degistir"].ToString()),
        //                ortalama_tarih_hesapla = ReplaceIntNull(item["ortalama_tarih_hesapla"].ToString()),

        //                liste_adi = ReplaceStringNull(item["liste_adi"].ToString()),
        //                liste_birim = ReplaceStringNull(item["liste_birim"].ToString()),
        //                baz_birim = ReplaceStringNull(item["baz_birim"].ToString()),
        //                malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
        //                satis_tipi = ReplaceStringNull(item["satis_tipi"].ToString()),
        //                barkod= ReplaceStringNull(item["barkod"].ToString()),
        //                stok_miktari =ReplaceDecimalNull(item["stok_miktari"].ToString())

        //            };

        //            fiyatList.Add(fiyat);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new AppException(ex.Message);
        //    }
        //    finally
        //    {
        //        if (sqlConnection.State == ConnectionState.Open)
        //        {
        //            sqlConnection.Close();
        //        }
        //    }

        //    return fiyatList;
        //}

        //public List<Malzeme> GetMalzeme(SdrParametreModel model)
        //{
        //    string _connectionString = "";

        //    _connectionString = GetConnectionString(model.veritabani_adi);
        //    List<Malzeme> malzemeList = new List<Malzeme>();

        //    SqlConnection sqlConnection = new SqlConnection(_connectionString);

        //    try
        //    {
        //        sqlConnection.Open();
                
        //        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_malzeme_list '{0}' ", model.temsilci_kodu), sqlConnection);
        //        DataTable dataTable = new DataTable();
        //        sqlDataAdapter.Fill(dataTable);

        //        foreach (DataRow item in dataTable.Rows)
        //        {
        //            var malzeme = new Malzeme()
        //            {
        //                r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),                        
        //                malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
        //                malzeme_adi = ReplaceStringNull(item["malzeme_adi"].ToString()),
        //                malzeme_sinifi_adi = ReplaceStringNull(item["malzeme_sinifi_adi"].ToString()),
        //                malzeme_birimi = ReplaceStringNull(item["malzeme_birimi"].ToString()),
        //                satinalma_birimi = ReplaceStringNull(item["satinalma_birimi"].ToString()),
        //                satis_birimi = ReplaceStringNull(item["satis_birimi"].ToString()),
        //                depo_birimi = ReplaceStringNull(item["depo_birimi"].ToString()),
        //                cikis_birimi = ReplaceStringNull(item["cikis_birimi"].ToString()),
        //                birimi = ReplaceStringNull(item["birimi"].ToString()),
        //                malzeme_sinifi_no = ReplaceStringNull(item["malzeme_sinifi_no"].ToString()),
        //                kdv_orani = ReplaceIntNull(item["kdv_orani"].ToString()),
        //                dist_stok_kodu = ReplaceStringNull(item["dist_stok_kodu"].ToString()),
        //                baz_birim = ReplaceStringNull(item["baz_birim"].ToString()),
        //                path = ReplaceStringNull(item["path"].ToString()),
        //                yururlukten_kaldirildi = ReplaceIntNull(item["yururlukten_kaldirildi"].ToString()),
        //                grup_kodu1 = ReplaceStringNull(item["grup_kodu1"].ToString()),
        //                grup_adi1 = ReplaceStringNull(item["grup_adi1"].ToString()),
        //                grup_kodu2 = ReplaceStringNull(item["grup_kodu2"].ToString()),
        //                grup_adi2 = ReplaceStringNull(item["grup_adi2"].ToString()),
        //                grup_kodu3 = ReplaceStringNull(item["grup_kodu3"].ToString()),
        //                grup_adi3 = ReplaceStringNull(item["grup_adi3"].ToString()),
        //                grup_kodu4 = ReplaceStringNull(item["grup_kodu4"].ToString()),
        //                grup_adi4 = ReplaceStringNull(item["grup_adi4"].ToString()),
        //                grup_kodu5 = ReplaceStringNull(item["grup_kodu5"].ToString()),
        //                grup_adi5 = ReplaceStringNull(item["grup_adi5"].ToString()),
        //                fatura_alti_indirimlere_dahil = ReplaceIntNull(item["fatura_alti_indirimlere_dahil"].ToString())                       

        //            };

        //            malzemeList.Add(malzeme);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new AppException(ex.Message);
        //    }
        //    finally
        //    {
        //        if (sqlConnection.State == ConnectionState.Open)
        //        {
        //            sqlConnection.Close();
        //        }
        //    }

        //    return malzemeList;

        //}

        //public List<BirimCevrimi> GetMalzemeBirimCevrimi(SdrParametreModel model)
        //{
        //    string _connectionString = "";

        //    _connectionString = GetConnectionString(model.veritabani_adi);
        //    List<BirimCevrimi> birimList = new List<BirimCevrimi>();

        //    SqlConnection sqlConnection = new SqlConnection(_connectionString);

        //    try
        //    {
        //        sqlConnection.Open();

        //        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_malzeme_birim_cevrimleri '{0}' ", model.temsilci_kodu), sqlConnection);
        //        DataTable dataTable = new DataTable();
        //        sqlDataAdapter.Fill(dataTable);

        //        foreach (DataRow item in dataTable.Rows)
        //        {
        //            var birimCevrimi = new BirimCevrimi()
        //            {
        //                r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
        //                birim_rsayac = ReplaceIntNull(item["birim_rsayac"].ToString()),
        //                birimden = ReplaceStringNull(item["birimden"].ToString()),
        //                birime = ReplaceStringNull(item["birime"].ToString()),
        //                bolen= ReplaceDecimalNull(item["bolen"].ToString()),
        //                bolunen = ReplaceDecimalNull(item["bolunen"].ToString()),
        //                malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString())
        //            };

        //            birimList.Add(birimCevrimi);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new AppException(ex.Message);
        //    }
        //    finally
        //    {
        //        if (sqlConnection.State == ConnectionState.Open)
        //        {
        //            sqlConnection.Close();
        //        }
        //    }

        //    return birimList;

        //}

        public ValidationResponseList GetAllBekleyenSiparis(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<BekleyenSiparis> siparisList = new List<BekleyenSiparis>();
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_bekleyen_siparis_list '{0}' ", model.temsilci_kodu), sqlConnection);
                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);

                foreach (DataRow item in dataTable.Rows)
                {
                    var siparis = new BekleyenSiparis()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        mus_rsayac = ReplaceIntNull(item["mus_rsayac"].ToString()),
                        siparis_no= ReplaceIntNull(item["siparis_no"].ToString()),
                        cid = ReplaceStringNull(item["cid"].ToString()),
                        musteri_no = ReplaceStringNull(item["musteri_no"].ToString()),
                        unvan= ReplaceStringNull(item["unvan"].ToString()),
                        teslim_musteri_no= ReplaceStringNull(item["teslim_musteri_no"].ToString()),
                        siparis_tarihi = ReplaceDateNull(item["siparis_tarihi"].ToString()),
                        siparis_asama = ReplaceStringNull(item["siparis_asama"].ToString()),
                        satis_tipi = ReplaceStringNull(item["satis_tipi"].ToString()),
                        satis_tipi_adi = ReplaceStringNull(item["satis_tipi_adi"].ToString()),
                        para_birimi = ReplaceStringNull(item["para_birimi"].ToString()),
                        temsilci = ReplaceStringNull(item["temsilci"].ToString()),
                        temsilci_adi = ReplaceStringNull(item["temsilci_adi"].ToString()),
                        siparis_tutari = ReplaceDecimalNull(item["siparis_tutari"].ToString()),
                        toplam_tutar = ReplaceDecimalNull(item["toplam_tutar"].ToString()),
                        indirim_tutari = ReplaceDecimalNull(item["indirim_tutari"].ToString()),
                        onay = ReplaceIntNull(item["onay"].ToString()),
                        toplam_kdv = ReplaceDecimalNull(item["toplam_kdv"].ToString()),
                        toplam_otv = ReplaceDecimalNull(item["toplam_otv"].ToString()),

                        sub_fatura_tipi_id= ReplaceStringNull(item["sub_fatura_tipi_id"].ToString()),
                        siparis_firma= ReplaceStringNull(item["siparis_firma"].ToString()),
                        aktarim_tipi= ReplaceStringNull(item["aktarim_tipi"].ToString()),
                        kullanici= ReplaceStringNull(item["kullanici"].ToString()),
                        sube_kodu= ReplaceStringNull(item["sube_kodu"].ToString()),
                        aciklama_android= ReplaceStringNull(item["aciklama_android"].ToString()),
                        sira_no = ReplaceIntNull(item["sira_no"].ToString()),
                        malzeme_kodu= ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        birimi= ReplaceStringNull(item["birimi"].ToString()),
                        birim_fiyat= ReplaceDecimalNull(item["birim_fiyat"].ToString()),
                        miktar= ReplaceDecimalNull(item["miktar"].ToString()),
                        indirim= ReplaceStringNull(item["indirim"].ToString()),
                        asama = ReplaceStringNull(item["asama"].ToString()),
                        sevk_tarihi = ReplaceDateNull(item["sevk_tarihi"].ToString()),
                        teslim_tarihi = ReplaceDateNull(item["teslim_tarihi"].ToString()),

                        fatura_edilen_miktar = ReplaceDecimalNull(item["fatura_edilen_miktar"].ToString()),
                        bedelsiz= ReplaceIntNull(item["bedelsiz"].ToString()),
                        indirim01_flag = ReplaceIntNull(item["indirim01_flag"].ToString()),
                        indirim02_flag = ReplaceIntNull(item["indirim02_flag"].ToString()),
                        indirim03_flag = ReplaceIntNull(item["indirim03_flag"].ToString()),
                        indirim04_flag = ReplaceIntNull(item["indirim04_flag"].ToString()),
                        indirim05_flag = ReplaceIntNull(item["indirim05_flag"].ToString()),
                        indirim06_flag = ReplaceIntNull(item["indirim06_flag"].ToString()),
                        indirim01 = ReplaceDecimalNull(item["indirim01"].ToString()),
                        indirim02 = ReplaceDecimalNull(item["indirim02"].ToString()),
                        indirim03 = ReplaceDecimalNull(item["indirim03"].ToString()),
                        indirim04 = ReplaceDecimalNull(item["indirim04"].ToString()),
                        indirim05 = ReplaceDecimalNull(item["indirim05"].ToString()),
                        indirim06 = ReplaceDecimalNull(item["indirim06"].ToString()),
                        toplam_indirim = ReplaceDecimalNull(item["toplam_indirim"].ToString()),
                        satir_tutari = ReplaceDecimalNull(item["satir_tutari"].ToString()),
                        sablon_kodu = ReplaceStringNull(item["sablon_kodu"].ToString()),
                        kdv_orani = ReplaceDecimalNull(item["kdv_orani"].ToString()),
                        kdv_tutari = ReplaceDecimalNull(item["kdv_tutari"].ToString()),
                        tutar = ReplaceDecimalNull(item["tutar"].ToString()),
                        depo_no = ReplaceStringNull(item["depo_no"].ToString()),
                        tesis_no = ReplaceStringNull(item["tesis_no"].ToString()),
                        stok_tipi_no = ReplaceStringNull(item["stok_tipi_no"].ToString()),
                        grup_kodu = ReplaceStringNull(item["grup_kodu"].ToString()),
                        indirim_kodu = ReplaceStringNull(item["indirim_kodu"].ToString()),
                        kolibasi_kampanya_flag= ReplaceIntNull(item["kolibasi_kampanya_flag"].ToString()),
                        malzeme_adi= ReplaceStringNull(item["malzeme_adi"].ToString()),
                        grup_adi1= ReplaceStringNull(item["grup_adi1"].ToString()),
                        grup_adi2= ReplaceStringNull(item["grup_adi2"].ToString()),
                        grup_adi3= ReplaceStringNull(item["grup_adi3"].ToString()),
                        baz_birim= ReplaceStringNull(item["baz_birim"].ToString())
                    };

                    siparisList.Add(siparis);
                }
            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> result = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            result.Add(json_serializer.Serialize(siparisList));

            vr.result = result;
            vr.successful = true;

            return vr;

        }

        public ValidationResponseList GetKampanya(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            List<string> result = new List<string>();

            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_kampanya_list '{0}','{1}' ", model.temsilci_kodu, model.cari_kod), sqlConnection);
                
                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);

                List<Kampanya> kampanyaList = new List<Kampanya>();
                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    var kampanya = new Kampanya()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        aciklama=ReplaceStringNull(item["aciklama"].ToString()),
                        ana_firma_kodu = ReplaceStringNull(item["ana_firma_kodu"].ToString()),
                        asama = ReplaceStringNull(item["asama"].ToString()),
                        baslangic_tarihi= ReplaceDateNull(item["baslangic_tarihi"].ToString()),
                        bayi_kampanya= ReplaceIntNull(item["bayi_kampanya"].ToString()),
                        bayi_sayisi = ReplaceIntNull(item["bayi_sayisi"].ToString()),
                        birim=ReplaceStringNull(item["birim"].ToString()),
                        bitis_tarihi= ReplaceDateNull(item["bitis_tarihi"].ToString()),
                        cid= ReplaceStringNull(item["cid"].ToString()),
                        grup_miktar_sarti=ReplaceIntNull(item["grup_miktar_sarti"].ToString()),
                        grup_toplam_miktar=ReplaceDecimalNull(item["grup_toplam_miktar"].ToString()),
                        haric_tutulan_istisna_listesi= ReplaceIntNull(item["haric_tutulan_istisna_listesi"].ToString()),
                        hayat_kampanya = ReplaceIntNull(item["hayat_kampanya"].ToString()),
                        bayi_bas_kota = ReplaceDecimalNull(item["bayi_bas_kota"].ToString()),
                        indirim_yuzdesi= ReplaceDecimalNull(item["indirim_yuzdesi"].ToString()),
                        istisna_listesi_kullanildimi= ReplaceIntNull(item["istisna_listesi_kullanildimi"].ToString()),
                        kampanya_adi= ReplaceStringNull(item["kampanya_adi"].ToString()),
                        kampanya_grubu= ReplaceStringNull(item["kampanya_grubu"].ToString()),
                        kampanya_kodu = ReplaceStringNull(item["kampanya_kodu"].ToString()),
                        kampanya_tipi = ReplaceStringNull(item["kampanya_tipi"].ToString()),
                        kontrat= ReplaceIntNull(item["kontrat"].ToString()),
                        kota= ReplaceDecimalNull(item["kota"].ToString()),
                        malzeme_sinifi = ReplaceStringNull(item["malzeme_sinifi"].ToString()),
                        mix_sarti_arama = ReplaceIntNull(item["mix_sarti_arama"].ToString()),
                        modul_id = ReplaceIntNull(item["modul_id"].ToString()),
                        musteri_bas_kota = ReplaceDecimalNull(item["musteri_bas_kota"].ToString()),
                        musteri_sayisi = ReplaceIntNull(item["musteri_sayisi"].ToString()),
                        return_sayac = ReplaceIntNull(item["return_sayac"].ToString()),
                        satilan = ReplaceDecimalNull(item["satilan"].ToString()),
                        tah_maliyet = ReplaceDecimalNull(item["tah_maliyet"].ToString()),
                        tah_satis = ReplaceDecimalNull(item["tah_satis"].ToString()),
                        uretici_rsayac = ReplaceIntNull(item["uretici_rsayac"].ToString()),
                        uygulama_bas_tarihi = ReplaceDateNull(item["uygulama_bas_tarihi"].ToString()),
                        uygulama_bit_tarihi = ReplaceDateNull(item["uygulama_bit_tarihi"].ToString()),
                        zorunlu = ReplaceIntNull(item["zorunlu"].ToString())
                    };
                    kampanyaList.Add(kampanya);
                }

                var json_serializer = new JavaScriptSerializer();
                result.Add(json_serializer.Serialize(kampanyaList));

                List<KampanyaBedelsizSatir> kampanyaBedelsizSatirs = new List<KampanyaBedelsizSatir>();
                foreach (DataRow item in dataSet.Tables[1].Rows)
                {
                    var kampanyaBedelsiz = new KampanyaBedelsizSatir()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        anlasma_durumu= ReplaceStringNull(item["anlasma_durumu"].ToString()),
                        birim = ReplaceStringNull(item["birim"].ToString()),
                        cari_kod = ReplaceStringNull(item["cari_kod"].ToString()),
                        cid = ReplaceStringNull(item["cid"].ToString()),
                        dist = ReplaceStringNull(item["dist"].ToString()),
                        grup_kodu = ReplaceStringNull(item["grup_kodu"].ToString()),
                        grup_rsayac= ReplaceIntNull(item["grup_rsayac"].ToString()),
                        kademe= ReplaceStringNull(item["kademe"].ToString()),
                        kalan_miktar = ReplaceDecimalNull(item["kalan_miktar"].ToString()),
                        kampanya_rsayac = ReplaceIntNull(item["kampanya_rsayac"].ToString()),
                        Kota= ReplaceDecimalNull(item["Kota"].ToString()),
                        malzeme_kodu= ReplaceStringNull(item["malzeme_kodu"].ToString()),                        
                        malzeme_sinifi = ReplaceStringNull(item["malzeme_sinifi"].ToString()),                        
                        miktar_sarti = ReplaceDecimalNull(item["miktar_sarti"].ToString()),
                        musteri_tipi = ReplaceStringNull(item["musteri_tipi"].ToString()),
                        nokta_uygulama= ReplaceIntNull(item["nokta_uygulama"].ToString()),
                        paket= ReplaceStringNull(item["paket"].ToString()),
                        satis_fiyati= ReplaceDecimalNull(item["satis_fiyati"].ToString()),
                        ust_grup= ReplaceStringNull(item["ust_grup"].ToString()),
                        ust_paket= ReplaceStringNull(item["ust_paket"].ToString())
                    };
                    kampanyaBedelsizSatirs.Add(kampanyaBedelsiz);
                }

                result.Add(json_serializer.Serialize(kampanyaBedelsizSatirs));

                List<KampanyaBedelsizVerilen> kampanyaBedelsizVerilens = new List<KampanyaBedelsizVerilen>();
                foreach (DataRow item in dataSet.Tables[2].Rows)
                {
                    var kampanyaBedelsizVerilen = new KampanyaBedelsizVerilen()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),                        
                        birim = ReplaceStringNull(item["birim"].ToString()),                        
                        cid = ReplaceStringNull(item["cid"].ToString()),
                        hayat_kampanya = ReplaceIntNull(item["hayat_kampanya"].ToString()),
                        grup_kodu = ReplaceStringNull(item["grup_kodu"].ToString()),
                        grup_rsayac = ReplaceIntNull(item["grup_rsayac"].ToString()),                        
                        kampanya_rsayac = ReplaceIntNull(item["kampanya_rsayac"].ToString()),
                        kota= ReplaceIntNull(item["kota"].ToString()),
                        malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        miktar=ReplaceDecimalNull(item["miktar"].ToString()),
                        paket = ReplaceStringNull(item["paket"].ToString()),                        
                        ust_paket = ReplaceStringNull(item["ust_paket"].ToString()),
                        zorunlu= ReplaceIntNull(item["zorunlu"].ToString())
                    };
                    kampanyaBedelsizVerilens.Add(kampanyaBedelsizVerilen);
                }

                result.Add(json_serializer.Serialize(kampanyaBedelsizVerilens));

                List<KampanyaYuzdeselSatir> kampanyaYuzdeselSatirs = new List<KampanyaYuzdeselSatir>();
                foreach (DataRow item in dataSet.Tables[3].Rows)
                {
                    var kampanyaYuzdesel = new KampanyaYuzdeselSatir()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        birim = ReplaceStringNull(item["birim"].ToString()),
                        cid = ReplaceStringNull(item["cid"].ToString()),                        
                        grup_kodu = ReplaceStringNull(item["grup_kodu"].ToString()),
                        indirim01 = ReplaceDecimalNull(item["indirim01"].ToString()),
                        indirim02 = ReplaceDecimalNull(item["indirim02"].ToString()),
                        indirim03 = ReplaceDecimalNull(item["indirim03"].ToString()),
                        indirim04 = ReplaceDecimalNull(item["indirim04"].ToString()),
                        indirim05 = ReplaceDecimalNull(item["indirim05"].ToString()),
                        indirim06 = ReplaceDecimalNull(item["indirim06"].ToString()),                        
                        kampanya_rsayac = ReplaceIntNull(item["kampanya_rsayac"].ToString()),
                        Kota = ReplaceDecimalNull(item["Kota"].ToString()),                        
                        malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        malzeme_sinifi= ReplaceStringNull(item["malzeme_sinifi"].ToString()),

                        max_yuzde= ReplaceDecimalNull(item["max_yuzde"].ToString()),
                        miktar_sarti = ReplaceDecimalNull(item["miktar_sarti"].ToString()),
                        nokta_uygulama = ReplaceIntNull(item["nokta_uygulama"].ToString()),
                        satis_fiyati = ReplaceDecimalNull(item["satis_fiyati"].ToString()),
                        yuzde = ReplaceDecimalNull(item["yuzde"].ToString())                        
                    };
                    kampanyaYuzdeselSatirs.Add(kampanyaYuzdesel);
                }

                result.Add(json_serializer.Serialize(kampanyaYuzdeselSatirs));

                List<KampanyaSecimliGruplar> kampanyaSecimliGruplars = new List<KampanyaSecimliGruplar>();
                foreach (DataRow item in dataSet.Tables[4].Rows)
                {
                    var kampanyaSecimli = new KampanyaSecimliGruplar()
                    {
                        r_sayac = ReplaceIntNull(item["r_sayac"].ToString()),
                        ana_grup_kodu = ReplaceStringNull(item["ana_grup_kodu"].ToString()),
                        bayi_kota = ReplaceIntNull(item["bayi_kota"].ToString()),
                        bedelsiz_grup_toplam_miktar = ReplaceDecimalNull(item["bedelsiz_grup_toplam_miktar"].ToString()),
                        cari_kota = ReplaceIntNull(item["cari_kota"].ToString()),
                        cid = ReplaceStringNull(item["cid"].ToString()),
                        grup_adi = ReplaceStringNull(item["grup_adi"].ToString()),
                        grup_toplam_miktar = ReplaceDecimalNull(item["grup_toplam_miktar"].ToString()),
                        grup_kodu = ReplaceStringNull(item["grup_kodu"].ToString()),
                        iskonto_hanesi = ReplaceIntNull(item["iskonto_hanesi"].ToString()),                        
                        kampanya_rsayac = ReplaceIntNull(item["kampanya_rsayac"].ToString()),
                        max_miktar = ReplaceDecimalNull(item["max_miktar"].ToString()),                        
                        min_miktar = ReplaceDecimalNull(item["min_miktar"].ToString())                        

                    };
                    kampanyaSecimliGruplars.Add(kampanyaSecimli);
                }
                result.Add(json_serializer.Serialize(kampanyaSecimliGruplars));

            }
            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            vr.result = result;
            vr.successful = true;

            return vr;

        }

        public ValidationResponse SetSiparis(List<Siparis> siparisler, List<SiparisSatir> siparisSatirs, List<Ziyaret> ziyaretler, AktarimParameterModel model)
        {
            string _connectionString = "";
            ValidationResponse vr = new ValidationResponse() { successful = true, information = "", code = "", result = "" };

            _connectionString = GetConnectionString(model.veritabani_adi);
            List<ZiyaretSonlandirmaTipleri> ziyaret_sonlandirma_tipleri = new List<ZiyaretSonlandirmaTipleri>();

            SqlConnection sqlConnection = new SqlConnection(_connectionString);

            try
            {
                XmlDocument doc = new XmlDocument();
                XmlElement root = doc.CreateElement("TransactionList");

                XmlElement parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("cid", "JOT");
                root.AppendChild(parameter);

                parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("satis_temsilci_kodu", model.temsilci_kodu.ToString());
                root.AppendChild(parameter);

                parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("plasier_kodu", "");
                root.AppendChild(parameter);

                parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("preseller_kodu", "");
                root.AppendChild(parameter);

                parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("user_id", model.user_id.ToString());
                root.AppendChild(parameter);

                parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("host_id", model.user_id.ToString());
                root.AppendChild(parameter);

                parameter = doc.CreateElement("Parameter");
                parameter.SetAttribute("host_ip", "");
                root.AppendChild(parameter);

                SqlCommand cmd;
                foreach (Ziyaret item in ziyaretler)
                {
                    try
                    {
                        int sayac = 0;
                        vr = GetZiyaret(item, model, ref sayac);
                        if (vr.successful == false)
                        {
                            return vr;
                        }

                        foreach (Siparis siparis in siparisler)
                        {
                            if (item.id == siparis.android_gps_sayac)
                            {                                

                                XmlElement Siparis1 = doc.CreateElement("Siparis1");
                                Siparis1.SetAttribute("r_sayac", ReplaceStringNull(siparis.r_sayac.ToString()));
                                Siparis1.SetAttribute("cid", ReplaceStringNull(siparis.cid.ToString()));
                                Siparis1.SetAttribute("musteri_no", ReplaceStringNull(siparis.musteri_no.ToString()));
                                Siparis1.SetAttribute("teslim_musteri_no", ReplaceStringNull(siparis.teslim_musteri_no.ToString()));

                                Siparis1.SetAttribute("siparis_tarihi", ReplaceDateNullAktarim(siparis.siparis_tarihi.ToString()).ToString());
                                Siparis1.SetAttribute("siparis_asama", ReplaceStringNull(siparis.siparis_asama));
                                Siparis1.SetAttribute("satis_tipi", ReplaceStringNull(siparis.satis_tipi));
                                Siparis1.SetAttribute("siparis_no", ReplaceStringNull(siparis.siparis_no.ToString()));

                                Siparis1.SetAttribute("para_birimi", ReplaceStringNull(siparis.para_birimi.ToString()));
                                Siparis1.SetAttribute("satis_temsilcisi", ReplaceStringNull(siparis.satis_temsilcisi.ToString()));
                                Siparis1.SetAttribute("siparis_tutari", ReplaceDecimalNull(siparis.siparis_tutari.ToString()).ToString().Replace(",", "."));
                                Siparis1.SetAttribute("toplam_tutar", ReplaceDecimalNull(siparis.toplam_tutar.ToString()).ToString().Replace(",", "."));

                                Siparis1.SetAttribute("indirim_tutari", ReplaceDecimalNull(siparis.indirim_tutari.ToString()).ToString().Replace(",", "."));
                                Siparis1.SetAttribute("onay", ReplaceIntNull(siparis.onay.ToString()).ToString());
                                Siparis1.SetAttribute("toplam_kdv", ReplaceDecimalNull(siparis.toplam_kdv.ToString()).ToString().Replace(",", "."));
                                Siparis1.SetAttribute("son_versiyon", ReplaceIntNull(siparis.son_versiyon.ToString()).ToString());
                                Siparis1.SetAttribute("toplam_otv", ReplaceDecimalNull(siparis.toplam_otv.ToString()).ToString().Replace(",", "."));
                                Siparis1.SetAttribute("sub_fatura_tipi_id", ReplaceStringNull(siparis.sub_fatura_tipi_id.ToString()));

                                Siparis1.SetAttribute("sub_fatura_tipi_id", ReplaceStringNull(siparis.sub_fatura_tipi_id.ToString()));
                                Siparis1.SetAttribute("tesis_no", ReplaceStringNull(siparis.tesis_no.ToString()));
                                Siparis1.SetAttribute("depo_no", ReplaceStringNull(siparis.depo_no.ToString()));
                                Siparis1.SetAttribute("siparis_firma", ReplaceStringNull(siparis.siparis_firma.ToString()));

                                Siparis1.SetAttribute("aktarim_tipi", ReplaceStringNull(siparis.aktarim_tipi.ToString()));
                                Siparis1.SetAttribute("kullanici", ReplaceStringNull(siparis.kullanici.ToString()));
                                Siparis1.SetAttribute("stok_tipi_no", ReplaceStringNull(siparis.stok_tipi_no.ToString()));

                                Siparis1.SetAttribute("sevk_tarihi", ReplaceDateNullAktarim(siparis.sevk_tarihi.ToString()).ToString());
                                Siparis1.SetAttribute("return_sayac", ReplaceStringNull(siparis.return_sayac.ToString()));
                                Siparis1.SetAttribute("sube_kodu", ReplaceStringNull(siparis.sube_kodu.ToString()));
                                Siparis1.SetAttribute("adres_tanimi_kod2", ReplaceStringNull(siparis.adres_tanimi_kod2.ToString()));
                                Siparis1.SetAttribute("adres_tanimi", ReplaceStringNull(siparis.adres_tanimi.ToString()));
                                Siparis1.SetAttribute("android_gps_sayac", sayac.ToString());
                                Siparis1.SetAttribute("aciklama", ReplaceStringNull(siparis.aciklama.ToString()));
                                Siparis1.SetAttribute("siparis_form_aciklama", ReplaceStringNull(siparis.siparis_form_aciklama.ToString()));
                                Siparis1.SetAttribute("aciklama_android", ReplaceStringNull(siparis.aciklama_android.ToString()));
                                Siparis1.SetAttribute("guid", ReplaceStringNull(siparis.guid.ToString()));
                                root.AppendChild(Siparis1);

                                foreach (SiparisSatir satir in siparisSatirs)
                                {
                                    if (satir.mus_rsayac==siparis.r_sayac)
                                    {
                                        XmlElement Siparis2 = doc.CreateElement("Siparis2");
                                        Siparis2.SetAttribute("r_sayac", ReplaceStringNull(satir.r_sayac.ToString()));
                                        Siparis2.SetAttribute("mus_rsayac", ReplaceStringNull(satir.mus_rsayac.ToString()));
                                        Siparis2.SetAttribute("cid", ReplaceStringNull(satir.cid.ToString()));
                                        Siparis2.SetAttribute("sira_no", ReplaceStringNull(satir.sira_no.ToString()));
                                        Siparis2.SetAttribute("satir_id", ReplaceStringNull(satir.satir_id.ToString()));

                                        Siparis2.SetAttribute("r_trg", ReplaceStringNull(satir.r_trg.ToString()));
                                        Siparis2.SetAttribute("return_sayac", ReplaceStringNull(satir.return_sayac.ToString()));
                                        Siparis2.SetAttribute("sevk_plani_no", ReplaceStringNull(satir.sevk_plani_no.ToString()));
                                        Siparis2.SetAttribute("irsaliye_miktari", ReplaceDecimalNull(satir.irsaliye_miktari.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("masraf01", ReplaceDecimalNull(satir.masraf01.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("masraf02", ReplaceDecimalNull(satir.masraf02.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("masraf03", ReplaceDecimalNull(satir.masraf03.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("toplam_masraf", ReplaceDecimalNull(satir.toplam_masraf.ToString()).ToString().Replace(",", "."));

                                        Siparis2.SetAttribute("masraflar", ReplaceStringNull(satir.masraflar.ToString()));
                                        Siparis2.SetAttribute("miscellenous_update", ReplaceStringNull(satir.miscellenous_update.ToString()));
                                        Siparis2.SetAttribute("malzeme_rsayac", ReplaceStringNull(satir.malzeme_rsayac.ToString()));

                                        Siparis2.SetAttribute("artan_miktar", ReplaceDecimalNull(satir.irsaliye_miktari.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("iade_miktari", ReplaceDecimalNull(satir.iade_miktari.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("sevk_plani_miktari", ReplaceDecimalNull(satir.sevk_plani_miktari.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("toplama_listesi_olustu", ReplaceStringNull(satir.toplama_listesi_olustu.ToString()));

                                        Siparis2.SetAttribute("alt_birim_adedi", ReplaceStringNull(satir.alt_birim_adedi.ToString()));
                                        Siparis2.SetAttribute("artan_top_sayisi", ReplaceStringNull(satir.artan_top_sayisi.ToString()));
                                        Siparis2.SetAttribute("toplama_listesi_top_sayisi", ReplaceStringNull(satir.toplama_listesi_top_sayisi.ToString()));
                                        Siparis2.SetAttribute("kalan_top_sayisi", ReplaceStringNull(satir.kalan_top_sayisi.ToString()));

                                        Siparis2.SetAttribute("proforma_no", ReplaceStringNull(satir.proforma_no.ToString()));
                                        Siparis2.SetAttribute("irsaliye_rsayac", ReplaceStringNull(satir.irsaliye_rsayac.ToString()));
                                        Siparis2.SetAttribute("malzeme_kodu", ReplaceStringNull(satir.malzeme_kodu.ToString()));
                                        Siparis2.SetAttribute("birimi", ReplaceStringNull(satir.birimi.ToString()));

                                        Siparis2.SetAttribute("birim_fiyat", ReplaceDecimalNull(satir.birim_fiyat.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("fiyat_tanimi_rsayac", ReplaceStringNull(satir.fiyat_tanimi_rsayac.ToString()));
                                        Siparis2.SetAttribute("sevk_kalan_miktar", ReplaceDecimalNull(satir.sevk_kalan_miktar.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("miktar", ReplaceDecimalNull(satir.miktar.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("indirim", ReplaceStringNull(satir.indirim.ToString()));
                                        Siparis2.SetAttribute("asama", ReplaceStringNull(satir.asama.ToString()));
                                        Siparis2.SetAttribute("sevk_tarihi", ReplaceDateNullAktarim(satir.sevk_tarihi.ToString()).ToString());
                                        Siparis2.SetAttribute("teslim_tarihi", ReplaceDateNullAktarim(satir.teslim_tarihi.ToString()).ToString());

                                        Siparis2.SetAttribute("fatura_edilen_miktar", ReplaceDecimalNull(satir.fatura_edilen_miktar.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("bedelsiz", ReplaceStringNull(satir.bedelsiz.ToString()));
                                        Siparis2.SetAttribute("indirim01_flag", ReplaceStringNull(satir.indirim01_flag.ToString()));
                                        Siparis2.SetAttribute("indirim02_flag", ReplaceStringNull(satir.indirim02_flag.ToString()));
                                        Siparis2.SetAttribute("indirim03_flag", ReplaceStringNull(satir.indirim03_flag.ToString()));
                                        Siparis2.SetAttribute("indirim04_flag", ReplaceStringNull(satir.indirim04_flag.ToString()));
                                        Siparis2.SetAttribute("indirim05_flag", ReplaceStringNull(satir.indirim05_flag.ToString()));
                                        Siparis2.SetAttribute("indirim06_flag", ReplaceStringNull(satir.indirim06_flag.ToString()));
                                        Siparis2.SetAttribute("indirim01", ReplaceDoubleNull(satir.indirim01.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("indirim02", ReplaceDoubleNull(satir.indirim02.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("indirim03", ReplaceDoubleNull(satir.indirim03.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("indirim04", ReplaceDoubleNull(satir.indirim04.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("indirim05", ReplaceDoubleNull(satir.indirim05.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("indirim06", ReplaceDoubleNull(satir.indirim06.ToString()).ToString().Replace(",", "."));

                                        Siparis2.SetAttribute("toplam_indirim", ReplaceDecimalNull(satir.toplam_indirim.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("std_doviz_kuru", ReplaceDecimalNull(satir.std_doviz_kuru.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("doviz_birim_fiyati", ReplaceDecimalNull(satir.doviz_birim_fiyati.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("doviz_tutar", ReplaceDecimalNull(satir.doviz_tutar.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("doviz_satir_tutari", ReplaceDecimalNull(satir.doviz_satir_tutari.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("doviz_kdv_miktari", ReplaceDecimalNull(satir.doviz_kdv_miktari.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("satir_tutari", ReplaceDecimalNull(satir.satir_tutari.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("sablon_kodu", ReplaceStringNull(satir.sablon_kodu.ToString()));
                                        Siparis2.SetAttribute("kdv_orani", ReplaceDecimalNull(satir.kdv_orani.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("kdv_tutari", ReplaceDecimalNull(satir.kdv_tutari.ToString()).ToString().Replace(",", "."));
                                        Siparis2.SetAttribute("tutar", ReplaceDecimalNull(satir.tutar.ToString()).ToString().Replace(",", "."));

                                        Siparis2.SetAttribute("depo_no", ReplaceStringNull(satir.depo_no.ToString()));
                                        Siparis2.SetAttribute("tesis_no", ReplaceStringNull(satir.tesis_no.ToString()));
                                        Siparis2.SetAttribute("stok_tipi_no", ReplaceStringNull(satir.stok_tipi_no.ToString()));

                                        Siparis2.SetAttribute("grup_kodu", ReplaceStringNull(satir.grup_kodu.ToString()));
                                        Siparis2.SetAttribute("indirim_kodu", ReplaceStringNull(satir.indirim_kodu.ToString()));
                                        Siparis2.SetAttribute("kolibasi_kampanya_flag", ReplaceIntNull(satir.kolibasi_kampanya_flag.ToString()).ToString());
                                        Siparis2.SetAttribute("bedelsiz_kampanya_flag", ReplaceIntNull(satir.bedelsiz_kampanya_flag.ToString()).ToString());
                                        int yuzdesel_kampanya_flag = ReplaceIntNull(satir.bedelsiz_kampanya_flag.ToString());
                                        if (yuzdesel_kampanya_flag> 1)
                                        {
                                            yuzdesel_kampanya_flag = 1;
                                        }

                                        Siparis2.SetAttribute("yuzdesel_kampanya_flag", yuzdesel_kampanya_flag.ToString());
                                        Siparis2.SetAttribute("depozito", ReplaceIntNull(satir.depozito.ToString()).ToString());
                                        Siparis2.SetAttribute("depozito_parent_id", ReplaceStringNull(satir.depozito_parent_id.ToString()).ToString());

                                        Siparis2.SetAttribute("depozito_sira_no", ReplaceIntNull(satir.depozito_sira_no.ToString()).ToString());
                                        Siparis2.SetAttribute("kolibasi_kosul", ReplaceIntNull(satir.kolibasi_kosul.ToString()).ToString());
                                        Siparis2.SetAttribute("kolibasi_cari_kod", ReplaceStringNull(satir.kolibasi_cari_kod.ToString()).ToString());

                                        Siparis2.SetAttribute("bedelsiz_tpr", ReplaceStringNull(satir.bedelsiz_tpr.ToString()).ToString());
                                        Siparis2.SetAttribute("bedelsiz_paket", ReplaceStringNull(satir.bedelsiz_paket.ToString()).ToString());
                                        Siparis2.SetAttribute("aciklama", ReplaceStringNull(satir.aciklama.ToString()).ToString());

                                        root.AppendChild(Siparis2);
                                    }
                                }

                            }
                        }

                    }
                    catch (Exception ex)
                    {
                        vr.successful = false;
                        vr.information = "Sipariş atarken hata:" + ex.Message.ToString();
                        return vr;
                    }

                }

                doc.AppendChild(root);
                string inXML = "";
                inXML = doc.InnerXml;
                inXML = inXML.Replace("<TransactionList xmlns=\"http://tempuri.org/\">", "<TransactionList>");
                inXML = inXML.Replace("''", "' '");

                StringBuilder sb = new StringBuilder("\" ");
                for (int i = 2; i < 255; i++)
                {
                    sb.Append(" ");
                    inXML = inXML.Replace((sb.ToString() + "\""), "\"\"");
                }

                Encoding srcEnc = Encoding.GetEncoding(1252);
                Encoding targetEnc = Encoding.UTF8;
                byte[] srcBytes;
                byte[] encBytes;

                srcBytes = srcEnc.GetBytes(inXML);
                encBytes = Encoding.Convert(srcEnc, targetEnc, srcBytes);
                inXML = targetEnc.GetString(encBytes);

                if (sqlConnection.State == ConnectionState.Closed)
                    sqlConnection.Open();

                cmd = new SqlCommand("ws_server_satis_siparis_insert_android", sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@oXML", SqlDbType.NText).Value = inXML;
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                vr.information = ex.Message;
                vr.successful = false;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            vr.information = "";
            vr.successful = true;
            return vr;

        }

        public ValidationResponseList GetMusteriMalAnalizi(ParameterMMAnaliziModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            List<MusteriMalAnalizi> result = new List<MusteriMalAnalizi>();

            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_musteri_mal_analizleri '{0}',0,'{1}', '{2}' ", model.temsilci_kodu, model.tarih1.Date.ToString("yyyy-MM-dd"), model.tarih2.Date.ToString("yyyy-MM-dd")), sqlConnection);

                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);
                
                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    var musteriMalAnalizi = new MusteriMalAnalizi()
                    {
                        musteri_kodu = ReplaceStringNull(item["musteri_kodu"].ToString()),
                        malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        malzeme_adi = ReplaceStringNull(item["malzeme_adi"].ToString()),
                        birimi = ReplaceStringNull(item["birimi"].ToString()),
                        baz_birim = ReplaceStringNull(item["baz_birim"].ToString()),
                        malzeme_sinifi_no = ReplaceStringNull(item["malzeme_sinifi_no"].ToString()),
                        malzeme_sinifi_adi = ReplaceStringNull(item["malzeme_sinifi_adi"].ToString()),
                        grup_kodu1 = ReplaceStringNull(item["grup_kodu1"].ToString()),
                        grup_kodu2 = ReplaceStringNull(item["grup_kodu2"].ToString()),
                        grup_kodu3 = ReplaceStringNull(item["grup_kodu3"].ToString()),
                        grup_kodu4 = ReplaceStringNull(item["grup_kodu4"].ToString()),
                        grup_kodu5 = ReplaceStringNull(item["grup_kodu5"].ToString()),
                        grup_adi1 = ReplaceStringNull(item["grup_adi1"].ToString()),
                        grup_adi2 = ReplaceStringNull(item["grup_adi2"].ToString()),
                        grup_adi3 = ReplaceStringNull(item["grup_adi3"].ToString()),
                        grup_adi4 = ReplaceStringNull(item["grup_adi4"].ToString()),
                        grup_adi5 = ReplaceStringNull(item["grup_adi5"].ToString()),
                        satis_tip_id= ReplaceStringNull(item["satis_tip_id"].ToString()),
                        satis_tipi_adi = ReplaceStringNull(item["satis_tipi_adi"].ToString()),
                        depo_no= ReplaceStringNull(item["depo_no"].ToString()),
                        depo_adi= ReplaceStringNull(item["depo_adi"].ToString()),
                        rapor_birimi= ReplaceStringNull(item["rapor_birimi"].ToString()),
                        satis_brut_tutar=ReplaceDecimalNull(item["satis_brut_tutar"].ToString()),
                        iade_brut_tutar = ReplaceDecimalNull(item["iade_brut_tutar"].ToString()),
                        iade_indirim_tutari= ReplaceDecimalNull(item["iade_indirim_tutari"].ToString()),
                        iade_kdv_oncesi_tutar= ReplaceDecimalNull(item["iade_kdv_oncesi_tutar"].ToString()),
                        iade_kdv_tutari= ReplaceDecimalNull(item["iade_kdv_tutari"].ToString()),
                        iade_miktari= ReplaceDecimalNull(item["iade_miktari"].ToString()),
                        iade_satir_tutari=ReplaceDecimalNull(item["iade_satir_tutari"].ToString()),
                        net_brut_tutar= ReplaceDecimalNull(item["net_brut_tutar"].ToString()),
                        net_indirim_tutari= ReplaceDecimalNull(item["net_indirim_tutari"].ToString()),
                        net_kdv_oncesi_tutar= ReplaceDecimalNull(item["net_kdv_oncesi_tutar"].ToString()),
                        net_kdv_tutari= ReplaceDecimalNull(item["net_kdv_tutari"].ToString()),
                        net_miktar= ReplaceDecimalNull(item["net_miktar"].ToString()),
                        net_satir_tutari= ReplaceDecimalNull(item["net_satir_tutari"].ToString()),
                        satis_indirim_tutari= ReplaceDecimalNull(item["satis_indirim_tutari"].ToString()),
                        satis_kdv_oncesi_tutar= ReplaceDecimalNull(item["satis_kdv_oncesi_tutar"].ToString()),
                        satis_kdv_tutari= ReplaceDecimalNull(item["satis_kdv_tutari"].ToString()),
                        satis_masraf_tutari= ReplaceDecimalNull(item["satis_masraf_tutari"].ToString()),
                        satis_miktari= ReplaceDecimalNull(item["satis_miktari"].ToString()),
                        satis_satir_tutari= ReplaceDecimalNull(item["satis_satir_tutari"].ToString()),
                        tarih=ReplaceDateTimeNull(item["tarih"].ToString())
                    };
                    result.Add(musteriMalAnalizi);
                }
            }

            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> resultson = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            resultson.Add(json_serializer.Serialize(result));

            vr.result = resultson;
            vr.successful = true;

            return vr;
        }

        public ValidationResponseList GetAcikHesapListesi(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            List<AcikHesapListesi> result = new List<AcikHesapListesi>();

            try
            {
                sqlConnection.Open();

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_acik_hesap_listesi '{0}' ", model.temsilci_kodu), sqlConnection);

                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);

                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    var acikHesap = new AcikHesapListesi()
                    {
                        Id = ReplaceIntNull(item["Id"].ToString()),
                        cari_kodu = ReplaceStringNull(item["cari_kodu"].ToString()),
                        cari_unvan = ReplaceStringNull(item["cari_unvan"].ToString()),
                        fatura_no = ReplaceIntNull(item["fatura_no"].ToString()),
                        islem_tipi = ReplaceStringNull(item["islem_tipi"].ToString()),
                        fis_tarihi= ReplaceDateTimeNull(item["fis_tarihi"].ToString()),
                        vade_gun_sayisi=ReplaceIntNull(item["vade_gun_sayisi"].ToString()),
                        vade_tarihi= ReplaceDateTimeNull(item["vade_tarihi"].ToString()),
                        borc_alacak= ReplaceStringNull(item["borc_alacak"].ToString()),
                        tefat_tutari= ReplaceDecimalNull(item["tefat_tutari"].ToString()),
                        tefat_bakiye_tutari= ReplaceDecimalNull(item["tefat_bakiye_tutari"].ToString()),
                        bakiye_toplami= ReplaceDecimalNull(item["bakiye_toplami"].ToString()),
                        tahsilat_gecikti= ReplaceStringNull(item["tahsilat_gecikti"].ToString()),
                        gecikme_gunu = ReplaceIntNull(item["gecikme_gunu"].ToString()),
                        son_bakiye_bakod = ReplaceStringNull(item["son_bakiye_bakod"].ToString()),                        
                    };
                    result.Add(acikHesap);
                }
            }

            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> resultson = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            resultson.Add(json_serializer.Serialize(result));

            vr.result = resultson;
            vr.successful = true;

            return vr;
        }

        public ValidationResponseList GetGunlukTahsilat(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            List<GunlukTahsilat> result = new List<GunlukTahsilat>();

            try
            {
                sqlConnection.Open();
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_gunluk_tahsilat_raporu '{0}' ", model.temsilci_kodu), sqlConnection);

                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);

                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    var tahsilat = new GunlukTahsilat()
                    {
                        fis_no= ReplaceStringNull(item["fis_no"].ToString()),
                        cari_sayac= ReplaceIntNull(item["cari_sayac"].ToString()),
                        fis_turu= ReplaceStringNull(item["fis_turu"].ToString()),
                        tarih = ReplaceDateTimeNull(item["tarih"].ToString()),
                        aktarim_temsilci= ReplaceStringNull(item["aktarim_temsilci"].ToString()),
                        tl_alacak= ReplaceDecimalNull(item["tl_alacak"].ToString()),
                        tl_borc= ReplaceDecimalNull(item["tl_borc"].ToString()),
                        kasa_kodu= ReplaceStringNull(item["kasa_kodu"].ToString()),
                        sorumlu= ReplaceStringNull(item["sorumlu"].ToString()),
                        cari_kodu = ReplaceStringNull(item["cari_kodu"].ToString()),
                        cari_unvan = ReplaceStringNull(item["cari_unvan"].ToString())
                    };
                    result.Add(tahsilat);
                }
            }

            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> resultson = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            resultson.Add(json_serializer.Serialize(result));

            vr.result = resultson;
            vr.successful = true;

            return vr;

        }

        public ValidationResponseList GetGunlukSiparis(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            List<GunlukSiparis> result = new List<GunlukSiparis>();

            try
            {
                sqlConnection.Open();
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_gunluk_siparis_list '{0}' ", model.temsilci_kodu), sqlConnection);

                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);

                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    var tahsilat = new GunlukSiparis()
                    {
                        malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        malzeme_adi = ReplaceStringNull(item["malzeme_adi"].ToString()),
                        baz_birim = ReplaceStringNull(item["baz_birim"].ToString()),
                        depo_no = ReplaceStringNull(item["depo_no"].ToString()),
                        depo_adi = ReplaceStringNull(item["depo_adi"].ToString()),
                        miktar = ReplaceDecimalNull(item["miktar"].ToString()),
                        satir_tutari = ReplaceDecimalNull(item["satir_tutari"].ToString()),
                        grup_adi1= ReplaceStringNull(item["grup_adi1"].ToString()),
                        grup_adi2 = ReplaceStringNull(item["grup_adi2"].ToString()),
                        grup_adi3 = ReplaceStringNull(item["grup_adi3"].ToString())

                    };
                    result.Add(tahsilat);
                }
            }

            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> resultson = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            resultson.Add(json_serializer.Serialize(result));

            vr.result = resultson;
            vr.successful = true;

            return vr;

        }

        //yarın kontrol edilecek.
        public ValidationResponseList GetStokFiyatListesi(SdrParametreModel model)
        {
            string _connectionString = "";

            _connectionString = GetConnectionString(model.veritabani_adi);
            SqlConnection sqlConnection = new SqlConnection(_connectionString);
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            List<Fiyat> fiyatList = new List<Fiyat>();

            try
            {
                sqlConnection.Open();
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("Exec mobil_stok_fiyat_getir '{0}' ", model.temsilci_kodu), sqlConnection);

                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);

                
                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    var fiyat = new Fiyat()
                    {
                        kod = ReplaceStringNull(""),
                        fiyat_tipi = ReplaceStringNull(""),
                        para_birimi = ReplaceStringNull(item["para_birimi"].ToString()),
                        fiyat1 = ReplaceIntNull(item["fiyat1"].ToString()),
                        fiyat2 = ReplaceIntNull(item["fiyat2"].ToString()),
                        fiyat3 = ReplaceIntNull(item["fiyat3"].ToString()),
                        fiyat4 = ReplaceIntNull(item["fiyat4"].ToString()),
                        fiyat5 = ReplaceIntNull(item["fiyat5"].ToString()),

                        kdvli_fiyat1 = ReplaceIntNull(item["kdvli_fiyat1"].ToString()),
                        kdvli_fiyat2 = ReplaceIntNull(item["kdvli_fiyat2"].ToString()),
                        kdvli_fiyat3 = ReplaceIntNull(item["kdvli_fiyat3"].ToString()),
                        kdvli_fiyat4 = ReplaceIntNull(item["kdvli_fiyat4"].ToString()),
                        kdvli_fiyat5 = ReplaceIntNull(item["kdvli_fiyat5"].ToString()),

                        vade1 = ReplaceIntNull(item["vade1"].ToString()),
                        vade2 = ReplaceIntNull(item["vade2"].ToString()),
                        vade3 = ReplaceIntNull(item["vade3"].ToString()),
                        vade4 = ReplaceIntNull(item["vade4"].ToString()),
                        vade5 = ReplaceIntNull(item["vade5"].ToString()),

                        iskonto1 = ReplaceIntNull(item["iskonto1"].ToString()),
                        iskonto2 = ReplaceIntNull(item["iskonto2"].ToString()),
                        iskonto3 = ReplaceIntNull(item["iskonto3"].ToString()),
                        iskonto4 = ReplaceIntNull(item["iskonto4"].ToString()),
                        iskonto5 = ReplaceIntNull(item["iskonto5"].ToString()),
                        iskonto6 = ReplaceIntNull(item["iskonto6"].ToString()),
                        genel_iskonto_yuzde = ReplaceIntNull(item["genel_iskonto_yuzde"].ToString()),
                        genel_iskonto_tutar = ReplaceDecimalNull(item["genel_iskonto_tutar"].ToString()),

                        fiyat_tutar1 = ReplaceDecimalNull(item["fiyat_tutar1"].ToString()),
                        fiyat_tutar2 = ReplaceDecimalNull(item["fiyat_tutar2"].ToString()),
                        fiyat_tutar3 = ReplaceDecimalNull(item["fiyat_tutar3"].ToString()),
                        fiyat_tutar4 = ReplaceDecimalNull(item["fiyat_tutar4"].ToString()),
                        fiyat_tutar5 = ReplaceDecimalNull(item["fiyat_tutar5"].ToString()),

                        vade_kodu1 = ReplaceStringNull(item["vade_kodu1"].ToString()),
                        vade_kodu2 = ReplaceStringNull(item["vade_kodu2"].ToString()),
                        vade_kodu3 = ReplaceStringNull(item["vade_kodu3"].ToString()),
                        vade_kodu4 = ReplaceStringNull(item["vade_kodu4"].ToString()),
                        vade_kodu5 = ReplaceStringNull(item["vade_kodu5"].ToString()),

                        iskonto_tutari1 = ReplaceDecimalNull(item["iskonto_tutari1"].ToString()),
                        iskonto_tutari2 = ReplaceDecimalNull(item["iskonto_tutari2"].ToString()),
                        iskonto_tutari3 = ReplaceDecimalNull(item["iskonto_tutari3"].ToString()),
                        iskonto_tutari4 = ReplaceDecimalNull(item["iskonto_tutari4"].ToString()),
                        iskonto_tutari5 = ReplaceDecimalNull(item["iskonto_tutari5"].ToString()),
                        iskonto_tutari6 = ReplaceDecimalNull(item["iskonto_tutari6"].ToString()),

                        indirim01_flag = ReplaceIntNull(item["indirim01_flag"].ToString()),
                        indirim02_flag = ReplaceIntNull(item["indirim02_flag"].ToString()),
                        indirim03_flag = ReplaceIntNull(item["indirim03_flag"].ToString()),
                        indirim04_flag = ReplaceIntNull(item["indirim04_flag"].ToString()),
                        indirim05_flag = ReplaceIntNull(item["indirim05_flag"].ToString()),
                        indirim06_flag = ReplaceIntNull(item["indirim06_flag"].ToString()),
                        cid = ReplaceStringNull(item["cid"].ToString()),

                        birim_fiyat_degistir = ReplaceIntNull(item["birim_fiyat_degistir"].ToString()),
                        gen_iskonto_degistir = ReplaceIntNull(item["gen_iskonto_degistir"].ToString()),
                        satir_iskonto_degistir = ReplaceIntNull(item["satir_iskonto_degistir"].ToString()),
                        vade_degistir = ReplaceIntNull(item["vade_degistir"].ToString()),
                        ortalama_tarih_hesapla = ReplaceIntNull(item["ortalama_tarih_hesapla"].ToString()),

                        liste_adi = ReplaceStringNull(item["liste_adi"].ToString()),
                        liste_birim = ReplaceStringNull(item["liste_birim"].ToString()),
                        baz_birim = ReplaceStringNull(item["baz_birim"].ToString()),
                        malzeme_kodu = ReplaceStringNull(item["malzeme_kodu"].ToString()),
                        satis_tipi = ReplaceStringNull(item["satis_tipi"].ToString()),
                        barkod = ReplaceStringNull(item["barkod"].ToString()),
                        stok_miktari = ReplaceDecimalNull(item["stok_miktari"].ToString()),

                        malzeme_adi = ReplaceStringNull(item["malzeme_adi"].ToString()),
                        kdv_orani = ReplaceDecimalNull(item["kdv_orani"].ToString()),
                        grup_adi1 = ReplaceStringNull(item["grup_adi1"].ToString()),
                        grup_adi2 = ReplaceStringNull(item["grup_adi2"].ToString()),
                        grup_adi3 = ReplaceStringNull(item["grup_adi3"].ToString())

                    };

                    fiyatList.Add(fiyat);
                }

            }

            catch (Exception ex)
            {
                vr.successful = false;
                vr.information = ex.Message;
                return vr;
            }
            finally
            {
                if (sqlConnection.State == ConnectionState.Open)
                {
                    sqlConnection.Close();
                }
            }

            List<string> resultson = new List<string>();

            var json_serializer = new JavaScriptSerializer();
            resultson.Add(json_serializer.Serialize(fiyatList));

            vr.result = resultson;
            vr.successful = true;

            return vr;

        }

    }  


}
