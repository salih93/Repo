import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/controller/controller.dart';

class Kampanya {
  final Controller _controller = Get.find();
  int rSayac;
  String kampanyaKodu;
  String cid;
  String kampanyaAdi;
  String kampanyaTipi;
  DateTime baslangicTarihi;
  DateTime bitisTarihi;
  DateTime uygulamaBasTarihi;
  DateTime uygulamaBitTarihi;
  double tahMaliyet;
  double tahSatis;
  int returnSayac;
  int modulId;
  double indirimYuzdesi;
  String anaFirmaKodu;
  String kampanyaGrubu;
  String malzemeSinifi;
  int bayiKampanya;
  String birim;
  double kota;
  int bayiSayisi;
  int musteriSayisi;
  double bayibaskota;
  double musteriBasKota;
  String asama;
  double satilan;
  int mixSartiArama;
  int zorunlu;
  int grupMiktarSarti;
  double grupToplamMiktar;
  String aciklama;
  int hayatKampanya;
  int kontrat;
  int ureticiRsayac;
  int istisnaListesiKullanildimi;
  int haricTutulanIstisnaListesi;
  String carikodu;

  Kampanya(
      {this.rSayac,
      this.kampanyaKodu,
      this.cid,
      this.kampanyaAdi,
      this.kampanyaTipi,
      this.baslangicTarihi,
      this.bitisTarihi,
      this.uygulamaBasTarihi,
      this.uygulamaBitTarihi,
      this.tahMaliyet,
      this.tahSatis,
      this.returnSayac,
      this.modulId,
      this.indirimYuzdesi,
      this.anaFirmaKodu,
      this.kampanyaGrubu,
      this.malzemeSinifi,
      this.bayiKampanya,
      this.birim,
      this.kota,
      this.bayiSayisi,
      this.musteriSayisi,
      this.bayibaskota,
      this.musteriBasKota,
      this.asama,
      this.satilan,
      this.mixSartiArama,
      this.zorunlu,
      this.grupMiktarSarti,
      this.grupToplamMiktar,
      this.aciklama,
      this.hayatKampanya,
      this.kontrat,
      this.ureticiRsayac,
      this.istisnaListesiKullanildimi,
      this.haricTutulanIstisnaListesi,
      this.carikodu});

  Kampanya.fromJson(Map<String, dynamic> json) {
    rSayac = json['r_sayac'];
    kampanyaKodu = json['kampanya_kodu'];
    cid = json['cid'];
    kampanyaAdi = json['kampanya_adi'];
    kampanyaTipi = json['kampanya_tipi'];
    baslangicTarihi = json['baslangic_tarihi'] == null ? null : DateTime.parse(json['baslangic_tarihi']);
    bitisTarihi = json['bitis_tarihi'] == null ? null : DateTime.parse(json['bitis_tarihi']);    
    uygulamaBasTarihi = json['uygulama_bas_tarihi'] == null ? null : DateTime.parse(json['uygulama_bas_tarihi']);    
    uygulamaBitTarihi = json['uygulama_bit_tarihi'] == null ? null : DateTime.parse(json['uygulama_bit_tarihi']);
    
    tahMaliyet = json['tah_maliyet'];
    tahSatis = json['tah_satis'];
    returnSayac = json['return_sayac'];
    modulId = json['modul_id'];
    indirimYuzdesi = json['indirim_yuzdesi'];
    anaFirmaKodu = json['ana_firma_kodu'];
    kampanyaGrubu = json['kampanya_grubu'];
    malzemeSinifi = json['malzeme_sinifi'];
    bayiKampanya = json['bayi_kampanya'];
    birim = json['birim'];
    kota = json['kota'];
    bayiSayisi = json['bayi_sayisi'];
    musteriSayisi = json['musteri_sayisi'];
    bayibaskota = json['bayi_bas_kota'];
    musteriBasKota = json['musteri_bas_kota'];
    asama = json['asama'];
    satilan = json['satilan'];
    mixSartiArama = json['mix_sarti_arama'];
    zorunlu = json['zorunlu'];
    grupMiktarSarti = json['grup_miktar_sarti'];
    grupToplamMiktar = json['grup_toplam_miktar'];
    aciklama = json['aciklama'];
    hayatKampanya = json['hayat_kampanya'];
    kontrat = json['kontrat'];
    ureticiRsayac = json['uretici_rsayac'];
    istisnaListesiKullanildimi = json['istisna_listesi_kullanildimi'];
    haricTutulanIstisnaListesi = json['haric_tutulan_istisna_listesi'];
    carikodu=json['cari_kodu']!=null ? json['cari_kodu']:_controller.carikod.value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac'] = this.rSayac;
    data['kampanya_kodu'] = this.kampanyaKodu;
    data['cid'] = this.cid;
    data['kampanya_adi'] = this.kampanyaAdi;
    data['kampanya_tipi'] = this.kampanyaTipi;
    data['baslangic_tarihi'] = DateFormat('yyyy-MM-dd 00:00:00.000').format(this.baslangicTarihi);    
    data['bitis_tarihi'] = DateFormat('yyyy-MM-dd 00:00:00.000').format(this.bitisTarihi);
    data['uygulama_bas_tarihi'] = DateFormat('yyyy-MM-dd 00:00:00.000').format(this.uygulamaBasTarihi);
    data['uygulama_bit_tarihi'] = DateFormat('yyyy-MM-dd 00:00:00.000').format(this.uygulamaBitTarihi);
    data['tah_maliyet'] = this.tahMaliyet;
    data['tah_satis'] = this.tahSatis;
    data['return_sayac'] = this.returnSayac;
    data['modul_id'] = this.modulId;
    data['indirim_yuzdesi'] = this.indirimYuzdesi;
    data['ana_firma_kodu'] = this.anaFirmaKodu;
    data['kampanya_grubu'] = this.kampanyaGrubu;
    data['malzeme_sinifi'] = this.malzemeSinifi;
    data['bayi_kampanya'] = this.bayiKampanya;
    data['birim'] = this.birim;
    data['kota'] = this.kota;
    data['bayi_sayisi'] = this.bayiSayisi;
    data['musteri_sayisi'] = this.musteriSayisi;
    data['bayi_bas_kota'] = this.bayibaskota;
    data['musteri_bas_kota'] = this.musteriBasKota;
    data['asama'] = this.asama;
    data['satilan'] = this.satilan;
    data['mix_sarti_arama'] = this.mixSartiArama;
    data['zorunlu'] = this.zorunlu;
    data['grup_miktar_sarti'] = this.grupMiktarSarti;
    data['grup_toplam_miktar'] = this.grupToplamMiktar;
    data['aciklama'] = this.aciklama;
    data['hayat_kampanya'] = this.hayatKampanya;
    data['kontrat'] = this.kontrat;
    data['uretici_rsayac'] = this.ureticiRsayac;
    data['istisna_listesi_kullanildimi'] = this.istisnaListesiKullanildimi;
    data['haric_tutulan_istisna_listesi'] = this.haricTutulanIstisnaListesi;
    data['cari_kodu'] = this.carikodu;
    return data;
  }
}
