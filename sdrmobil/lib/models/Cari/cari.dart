import 'dart:convert';

List<Cari> cariFromJson(String str) =>
    List<Cari>.from(json.decode(str).map((x) => Cari.fromJson(x)));

String cariToJson(List<Cari> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cari {
  int rSayac;
  String cariTipi;
  String cid;
  String kod;
  String kodu2;
  String unvan;
  String semt;
  String cariAdsoyad;
  String temsilciKodu;
  String temsilciAdsoyad;
  double tlBorc;
  double tlAlacak;
  double tlAbakiye;
  double tlBbakiye;
  double calisilanBorc;
  double calisilanAlacak;
  double calisilanAbakiye;
  double calisilanBbakiye;
  String calisilanTur;
  String riskTipi;
  int riskTipiIslemDurduruldu;
  String vergiNo;
  double riskLimiti;
  String ustKanalKodu;
  String kanalKodu;
  String altKanalKodu;
  String ustKanalAdi;
  String kanalAdi;
  String altKanalAdi;
  String musteriTipi;
  int efaturaKullanicisi;
  String sehir;
  String ilce;
  String satisBolgeKodu;
  String satisBolgeAdi;
  String yetkili;
  String tabela;
  String eMail;
  double gunlukSiparisTutar;
  double gunlukFaturaTutar;
  double gunlukTahsilatTutar;
  String enlem;
  String boylam;

  Cari({
    this.rSayac,
    this.cariTipi,
    this.cid,
    this.kod,
    this.kodu2,
    this.unvan,
    this.semt,
    this.cariAdsoyad,
    this.temsilciKodu,
    this.temsilciAdsoyad,
    this.tlBorc,
    this.tlAlacak,
    this.tlAbakiye,
    this.tlBbakiye,
    this.calisilanBorc,
    this.calisilanAlacak,
    this.calisilanAbakiye,
    this.calisilanBbakiye,
    this.calisilanTur,
    this.riskTipi,
    this.riskTipiIslemDurduruldu,
    this.vergiNo,
    this.riskLimiti,
    this.ustKanalKodu,
    this.kanalKodu,
    this.altKanalKodu,
    this.ustKanalAdi,
    this.kanalAdi,
    this.altKanalAdi,
    this.musteriTipi,
    this.efaturaKullanicisi,
    this.sehir,
    this.ilce,
    this.satisBolgeKodu,
    this.satisBolgeAdi,
    this.yetkili,
    this.tabela,
    this.eMail,
    this.gunlukSiparisTutar,
    this.gunlukFaturaTutar,
    this.gunlukTahsilatTutar,
    this.enlem,
    this.boylam,
  });

  factory Cari.fromJson(Map<String, dynamic> json) => Cari(
        rSayac: json['r_sayac'],
        cariTipi: json['cari_tipi'],
        cid: json['cid'],
        kod: json['kod'],
        kodu2: json['kodu2'],
        unvan: json['unvan'],
        semt: json['semt'],
        cariAdsoyad: json['cari_adsoyad'],
        temsilciKodu: json['temsilci_kodu'],
        temsilciAdsoyad: json['temsilci_adsoyad'],
        tlBorc: json['tl_borc'],
        tlAlacak: json['tl_alacak'],
        tlAbakiye: json['tl_abakiye'],
        tlBbakiye: json['tl_bbakiye'],
        calisilanBorc: json['calisilan_borc'],
        calisilanAlacak: json['calisilan_alacak'],
        calisilanAbakiye: json['calisilan_abakiye'],
        calisilanBbakiye: json['calisilan_bbakiye'],
        calisilanTur: json['calisilan_tur'],
        riskTipi: json['risk_tipi'],
        riskTipiIslemDurduruldu: json['risk_tipi_islem_durduruldu'],
        vergiNo: json['vergi_no'],
        riskLimiti: json['risk_limiti'].toDouble(),
        ustKanalKodu: json['ust_kanal_kodu'],
        kanalKodu: json['kanal_kodu'],
        altKanalKodu: json['alt_kanal_kodu'],
        ustKanalAdi: json['ust_kanal_adi'],
        kanalAdi: json['kanal_adi'],
        altKanalAdi: json['alt_kanal_adi'],
        musteriTipi: json['musteri_tipi'],
        efaturaKullanicisi: json['efatura_kullanicisi'],
        sehir: json['sehir'],
        ilce: json['ilce'],
        satisBolgeKodu: json['satis_bolge_kodu'],
        satisBolgeAdi: json['satis_bolge_adi'],
        yetkili: json['yetkili'],
        tabela: json['tabela'],
        eMail: json['e_mail'],
        gunlukSiparisTutar: json['gunlukSiparisTutar'],
        gunlukFaturaTutar: json['gunlukFaturaTutar'],
        gunlukTahsilatTutar: json['gunlukTahsilatTutar'],
        enlem: json['enlem'],
        boylam: json['boylam'],
      );

  Map<String, dynamic> toJson() => {
        "r_sayac": rSayac,
        "cari_tipi": cariTipi,
        "cid": cid,
        "kod": kod,
        "kodu2": kodu2,
        "unvan": unvan,
        "semt": semt,
        "cari_adsoyad": cariAdsoyad,
        "temsilci_kodu": temsilciKodu,
        "temsilci_adsoyad": temsilciAdsoyad,
        "tl_borc": tlBorc,
        "tl_alacak": tlAlacak,
        "tl_abakiye": tlAbakiye,
        "tl_bbakiye": tlBbakiye,
        "calisilan_borc": calisilanBorc,
        "calisilan_alacak": calisilanAlacak,
        "calisilan_abakiye": calisilanAbakiye,
        "calisilan_bbakiye": calisilanBbakiye,
        "calisilan_tur": calisilanTur,
        "risk_tipi": riskTipi,
        "risk_tipi_islem_durduruldu": riskTipiIslemDurduruldu,
        "vergi_no": vergiNo,
        "risk_limiti": riskLimiti,
        "ust_kanal_kodu": ustKanalKodu,
        "kanal_kodu": kanalKodu,
        "alt_kanal_kodu": altKanalKodu,
        "ust_kanal_adi": ustKanalAdi,
        "kanal_adi": kanalAdi,
        "alt_kanal_adi": altKanalAdi,
        "musteri_tipi": musteriTipi,
        "efatura_kullanicisi": efaturaKullanicisi,
        "sehir": sehir,
        "ilce": ilce,
        "satis_bolge_kodu": satisBolgeKodu,
        "satis_bolge_adi": satisBolgeAdi,
        "yetkili": yetkili,
        "tabela": tabela,
        "e_mail": eMail,
        "gunlukSiparisTutar": gunlukSiparisTutar,
        "gunlukFaturaTutar": gunlukFaturaTutar,
        "gunlukTahsilatTutar": gunlukTahsilatTutar,
        "enlem": enlem,
        "boylam": boylam,
        
      };
}
