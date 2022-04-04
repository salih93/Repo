import 'dart:convert';

List<SatisTipi> satisTipiFromJson(String str) =>
    List<SatisTipi>.from(
        json.decode(str).map((x) => SatisTipi.fromJson(x)));

String satisTipiToJson(List<SatisTipi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SatisTipi {
  int rsayac;
  String satistipid;
  String satistipi;
  String aciklama;
  String harekettipiid;
  String sakkontrolno;
  String fiyattipi;
  String depono;
  String tesisno;
  String stoktipino;
  String iadeharekettipiid;
  String faturatipiid;
  int kampanyalariotomatikuygula;
  int iade;
  int goster;    
  String tablono;       
  String alisfiyattipi;
  String satisfiyattipi;
  int satisfiyati1;
  int satisfiyati2;
  int satisfiyati3;
  int satisfiyati4;
  int satisfiyati5;
  int alisfiyati1;
  int alisfiyati2;
  int alisfiyati3;
  int alisfiyati4;
  int alisfiyati5;
  int vadealis1;
  int vadealis2;
  int vadealis3;
  int vadealis4;
  int vadealis5;

  int vadesatis1;
  int vadesatis2;
  int vadesatis3;
  int vadesatis4;
  int vadesatis5;

  int iskonto1;
  int iskonto2;
  int iskonto3;
  int iskonto4;
  int iskonto5;
  int iskonto6;

  int carivadesigelsin;
  int geneliskontoyuzde;
  double geneliskonto;
  int alisiskonto1;
  int alisiskonto2;
  int alisiskonto3;
  int alisiskonto4;
  int alisiskonto5;
  int alisiskonto6;

  String vadealiskodu1;
  String vadealiskodu2;
  String vadealiskodu3;
  String vadealiskodu4;
  String vadealiskodu5;

  String vadesatiskodu1;
  String vadesatiskodu2;
  String vadesatiskodu3;
  String vadesatiskodu4;
  String vadesatiskodu5;
  int fiyatlistesi;
  int birimfiyatdegistir;
  int geniskontodegistir;
  int satiriskontodegistir;
  int borckapatma;
  int fatbasimiyapilsin;
  String fatserino;
  int odemetarihhesapla;
  int sakkullanimsekli;
  String saktablosu;
  int toplumalayirma;
  int irsaliyebasimi;
  String irsaliyeserino;

  int siparisyapilsin;
  int kamyonlastirmayapilsin;
  int irsaliyeyapilsin;
  int faturayapilsin;
  String kontrolno;
  int vadedegistir;
  int stsirsserinorsayac;
  int stsirsbasiliformrsayac;
  int stsfatserinorsayac;
  int stsfatbasiliformrsayac;
  int stsfatirsbasiliformrsayac;
  int stsiadeirsaliyebasimi;
  int stsiadeirsserinorsayac;

  int stsiadeirsbasiliformrsayac;
  int stsiadefaturabasimi;
  int stsiadefatserinorsayac;
  int stsiadefatbasiliformrsayac;  

 SatisTipi(
      {      
        this.rsayac,
        this.satistipid,
        this.satistipi,
        this.aciklama,
        this.harekettipiid,
        this.sakkontrolno,
        this.fiyattipi,
        this.depono,
        this.tesisno,
        this.stoktipino,
        this.iadeharekettipiid,
        this.faturatipiid,
        this.kampanyalariotomatikuygula,
        this.iade,
        this.goster,
        this.tablono,      
        this.alisfiyattipi,
        this.satisfiyattipi,
        this.satisfiyati1,
        this.satisfiyati2,
        this.satisfiyati3,
        this.satisfiyati4,
        this.satisfiyati5,
        this.alisfiyati1,
        this.alisfiyati2,
        this.alisfiyati3,
        this.alisfiyati4,
        this.alisfiyati5,
        this.vadealis1,
        this.vadealis2,
        this.vadealis3,
        this.vadealis4,
        this.vadealis5,
        this.vadesatis1,
        this.vadesatis2,
        this.vadesatis3,
        this.vadesatis4,
        this.vadesatis5,
        this.iskonto1,
        this.iskonto2,
        this.iskonto3,
        this.iskonto4,
        this.iskonto5,
        this.iskonto6,
        this.carivadesigelsin,
        this.geneliskontoyuzde,
        this.geneliskonto,
        this.alisiskonto1,
        this.alisiskonto2,
        this.alisiskonto3,
        this.alisiskonto4,
        this.alisiskonto5,
        this.alisiskonto6,
        this.vadealiskodu1,
        this.vadealiskodu2,
        this.vadealiskodu3,
        this.vadealiskodu4,
        this.vadealiskodu5,
        this.vadesatiskodu1,
        this.vadesatiskodu2,
        this.vadesatiskodu3,
        this.vadesatiskodu4,
        this.vadesatiskodu5,
        this.fiyatlistesi,
        this.birimfiyatdegistir,
        this.geniskontodegistir,
        this.satiriskontodegistir,
        this.borckapatma,
        this.fatbasimiyapilsin,
        this.fatserino,
        this.odemetarihhesapla,
        this.sakkullanimsekli,
        this.saktablosu,
        this.toplumalayirma,
        this.irsaliyebasimi,
        this.irsaliyeserino,
        this.siparisyapilsin,
        this.kamyonlastirmayapilsin,
        this.irsaliyeyapilsin,
        this.faturayapilsin,
        this.kontrolno,      
        this.vadedegistir,
        this.stsirsserinorsayac,
        this.stsirsbasiliformrsayac,
        this.stsfatserinorsayac,
        this.stsfatbasiliformrsayac,
        this.stsfatirsbasiliformrsayac,
        this.stsiadeirsaliyebasimi,
        this.stsiadeirsserinorsayac,
        this.stsiadeirsbasiliformrsayac,
        this.stsiadefaturabasimi,
        this.stsiadefatserinorsayac,
        this.stsiadefatbasiliformrsayac,   

      });

  SatisTipi.fromJson(Map<String, dynamic> json) {    
    rsayac=json['r_sayac'];
    satistipid=json['satis_tip_id'];
    satistipi=json['satis_tipi'];
    aciklama=json['aciklama'];
    harekettipiid=json['hareket_tipi_id'];
    sakkontrolno=json['sak_kontrol_no'];
    fiyattipi=json['fiyat_tipi'];
    depono=json['depo_no'];
    tesisno=json['tesis_no'];
    stoktipino=json['stok_tipi_no'];
    iadeharekettipiid=json['iade_hareket_tipi_id'];
    faturatipiid=json['fatura_tipi_id'];
    kampanyalariotomatikuygula=json['kampanyalari_otomatik_uygula'];
    iade=json['iade'];
    goster=json['goster'];    
    
    tablono	=	json['tablo_no'];    
    alisfiyattipi	=	json['alis_fiyat_tipi'];
    satisfiyattipi	=	json['satis_fiyat_tipi'];
    satisfiyati1	=	json['satis_fiyati1'];
    satisfiyati2	=	json['satis_fiyati2'];
    satisfiyati3	=	json['satis_fiyati3'];
    satisfiyati4	=	json['satis_fiyati4'];
    satisfiyati5	=	json['satis_fiyati5'];
    alisfiyati1	=	json['alis_fiyati1'];
    alisfiyati2	=	json['alis_fiyati2'];
    alisfiyati3	=	json['alis_fiyati3'];
    alisfiyati4	=	json['alis_fiyati4'];
    alisfiyati5	=	json['alis_fiyati5'];
    vadealis1	=	json['vade_alis1'];
    vadealis2	=	json['vade_alis2'];
    vadealis3	=	json['vade_alis3'];
    vadealis4	=	json['vade_alis4'];
    vadealis5	=	json['vade_alis5'];
    vadesatis1	=	json['vade_satis1'];
    vadesatis2	=	json['vade_satis2'];
    vadesatis3	=	json['vade_satis3'];
    vadesatis4	=	json['vade_satis4'];
    vadesatis5	=	json['vade_satis5'];
    iskonto1	=	json['iskonto1'];
    iskonto2	=	json['iskonto2'];
    iskonto3	=	json['iskonto3'];
    iskonto4	=	json['iskonto4'];
    iskonto5	=	json['iskonto5'];
    iskonto6	=	json['iskonto6'];
    carivadesigelsin	=	json['cari_vadesi_gelsin'];
    geneliskontoyuzde	=	json['genel_iskonto_yuzde'];
    geneliskonto	=	json['genel_iskonto'];
    alisiskonto1	=	json['alis_iskonto1'];
    alisiskonto2	=	json['alis_iskonto2'];
    alisiskonto3	=	json['alis_iskonto3'];
    alisiskonto4	=	json['alis_iskonto4'];
    alisiskonto5	=	json['alis_iskonto5'];
    alisiskonto6	=	json['alis_iskonto6'];
    vadealiskodu1	=	json['vade_alis_kodu1'];
    vadealiskodu2	=	json['vade_alis_kodu2'];
    vadealiskodu3	=	json['vade_alis_kodu3'];
    vadealiskodu4	=	json['vade_alis_kodu4'];
    vadealiskodu5	=	json['vade_alis_kodu5'];
    vadesatiskodu1	=	json['vade_satis_kodu1'];
    vadesatiskodu2	=	json['vade_satis_kodu2'];
    vadesatiskodu3	=	json['vade_satis_kodu3'];
    vadesatiskodu4	=	json['vade_satis_kodu4'];
    vadesatiskodu5	=	json['vade_satis_kodu5'];
    fiyatlistesi	=	json['fiyat_listesi'];
    birimfiyatdegistir	=	json['birim_fiyat_degistir'];
    geniskontodegistir	=	json['gen_iskonto_degistir'];
    satiriskontodegistir	=	json['satir_iskonto_degistir'];
    borckapatma	=	json['borc_kapatma'];
    fatbasimiyapilsin	=	json['fat_basimi_yapilsin'];
    fatserino	=	json['fat_seri_no'];
    odemetarihhesapla	=	json['odeme_tarih_hesapla'];
    sakkullanimsekli	=	json['sak_kullanim_sekli'];
    saktablosu	=	json['sak_tablosu'];
    toplumalayirma	=	json['toplu_mal_ayirma'];
    irsaliyebasimi	=	json['irsaliye_basimi'];
    irsaliyeserino	=	json['irsaliye_seri_no'];
    siparisyapilsin	=	json['siparis_yapilsin'];
    kamyonlastirmayapilsin	=	json['kamyonlastirma_yapilsin'];
    irsaliyeyapilsin	=	json['irsaliye_yapilsin'];
    faturayapilsin	=	json['fatura_yapilsin'];
    kontrolno	=	json['kontrol_no'];    
    vadedegistir	=	json['vade_degistir'];
    stsirsserinorsayac	=	json['sts_irs_seri_no_rsayac'];
    stsirsbasiliformrsayac	=	json['sts_irs_basili_form_rsayac'];
    stsfatserinorsayac	=	json['sts_fat_seri_no_rsayac'];
    stsfatbasiliformrsayac	=	json['sts_fat_basili_form_rsayac'];
    stsfatirsbasiliformrsayac	=	json['sts_fat_irs_basili_form_rsayac'];
    stsiadeirsaliyebasimi	=	json['sts_iade_irsaliye_basimi'];
    stsiadeirsserinorsayac	=	json['sts_iade_irs_seri_no_rsayac'];
    stsiadeirsbasiliformrsayac	=	json['sts_iade_irs_basili_form_rsayac'];
    stsiadefaturabasimi	=	json['sts_iade_fatura_basimi'];
    stsiadefatserinorsayac	=	json['sts_iade_fat_seri_no_rsayac'];
    stsiadefatbasiliformrsayac	=	json['sts_iade_fat_basili_form_rsayac'];  

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac']=this.rsayac;
    data['satis_tip_id']=this.satistipid;
    data['satis_tipi']=this.satistipi;
    data['aciklama']=this.aciklama;
    data['hareket_tipi_id']=this.harekettipiid;
    data['sak_kontrol_no']=this.sakkontrolno;
    data['fiyat_tipi']=this.fiyattipi;
    data['depo_no']=this.depono;
    data['tesis_no']=this.tesisno;
    data['stok_tipi_no']=this.stoktipino;
    data['iade_hareket_tipi_id']=this.iadeharekettipiid;
    data['fatura_tipi_id']=this.faturatipiid;
    data['kampanyalari_otomatik_uygula']=this.kampanyalariotomatikuygula;
    data['iade']=this.iade;
    data['goster']=this.goster;    
    
    data['tablo_no']	=	this.tablono	;    
    data['alis_fiyat_tipi']	=	this.alisfiyattipi	;
    data['satis_fiyat_tipi']	=	this.satisfiyattipi	;
    data['satis_fiyati1']	=	this.satisfiyati1	;
    data['satis_fiyati2']	=	this.satisfiyati2	;
    data['satis_fiyati3']	=	this.satisfiyati3	;
    data['satis_fiyati4']	=	this.satisfiyati4	;
    data['satis_fiyati5']	=	this.satisfiyati5	;
    data['alis_fiyati1']	=	this.alisfiyati1	;
    data['alis_fiyati2']	=	this.alisfiyati2	;
    data['alis_fiyati3']	=	this.alisfiyati3	;
    data['alis_fiyati4']	=	this.alisfiyati4	;
    data['alis_fiyati5']	=	this.alisfiyati5	;
    data['vade_alis1']	=	this.vadealis1	;
    data['vade_alis2']	=	this.vadealis2	;
    data['vade_alis3']	=	this.vadealis3	;
    data['vade_alis4']	=	this.vadealis4	;
    data['vade_alis5']	=	this.vadealis5	;
    data['vade_satis1']	=	this.vadesatis1	;
    data['vade_satis2']	=	this.vadesatis2	;
    data['vade_satis3']	=	this.vadesatis3	;
    data['vade_satis4']	=	this.vadesatis4	;
    data['vade_satis5']	=	this.vadesatis5	;
    data['iskonto1']	=	this.iskonto1	;
    data['iskonto2']	=	this.iskonto2	;
    data['iskonto3']	=	this.iskonto3	;
    data['iskonto4']	=	this.iskonto4	;
    data['iskonto5']	=	this.iskonto5	;
    data['iskonto6']	=	this.iskonto6	;
    data['cari_vadesi_gelsin']=this.carivadesigelsin	;
    data['genel_iskonto_yuzde']	=this.geneliskontoyuzde	;
    data['genel_iskonto']	= this.geneliskonto	;
    data['alis_iskonto1']	=	this.alisiskonto1	;
    data['alis_iskonto2']	=	this.alisiskonto2	;
    data['alis_iskonto3']	=	this.alisiskonto3	;
    data['alis_iskonto4']	=	this.alisiskonto4	;
    data['alis_iskonto5']	=	this.alisiskonto5	;
    data['alis_iskonto6']	=	this.alisiskonto6	;
    data['vade_alis_kodu1']	=	this.vadealiskodu1	;
    data['vade_alis_kodu2']	=	this.vadealiskodu2	;
    data['vade_alis_kodu3']	=	this.vadealiskodu3	;
    data['vade_alis_kodu4']	=	this.vadealiskodu4	;
    data['vade_alis_kodu5']	=	this.vadealiskodu5	;
    data['vade_satis_kodu1'] =	this.vadesatiskodu1	;
    data['vade_satis_kodu2'] = this.vadesatiskodu2	;
    data['vade_satis_kodu3'] = this.vadesatiskodu3	;
    data['vade_satis_kodu4'] = this.vadesatiskodu4	;
    data['vade_satis_kodu5'] = this.vadesatiskodu5	;
    data['fiyat_listesi'] = this.fiyatlistesi	;

    data['birim_fiyat_degistir']	=	this.birimfiyatdegistir;
    data['gen_iskonto_degistir']	=	this.geniskontodegistir;
    data['satir_iskonto_degistir']	=	this.satiriskontodegistir;
    data['borc_kapatma']	=	this.borckapatma;
    data['fat_basimi_yapilsin']	=	this.fatbasimiyapilsin;
    data['fat_seri_no']	=	this.fatserino;
    data['odeme_tarih_hesapla']	=	this.odemetarihhesapla;
    data['sak_kullanim_sekli']	=	this.sakkullanimsekli;
    data['sak_tablosu']	=	this.saktablosu;
    data['toplu_mal_ayirma']	=	this.toplumalayirma;
    data['irsaliye_basimi']	=	this.irsaliyebasimi;
    data['irsaliye_seri_no']	=	this.irsaliyeserino;
    data['siparis_yapilsin']	=	this.siparisyapilsin;
    data['kamyonlastirma_yapilsin']	=	this.kamyonlastirmayapilsin;
    data['irsaliye_yapilsin']	=	this.irsaliyeyapilsin;
    data['fatura_yapilsin']	=	this.faturayapilsin;
    data['kontrol_no']	=	this.kontrolno;    
    data['vade_degistir']	=	this.vadedegistir;
    data['sts_irs_seri_no_rsayac']	=	this.stsirsserinorsayac;
    data['sts_irs_basili_form_rsayac']	=	this.stsirsbasiliformrsayac;
    data['sts_fat_seri_no_rsayac']	=	this.stsfatserinorsayac;
    data['sts_fat_basili_form_rsayac']	=	this.stsfatbasiliformrsayac;
    data['sts_fat_irs_basili_form_rsayac']	=	this.stsfatirsbasiliformrsayac;
    data['sts_iade_irsaliye_basimi']	=	this.stsiadeirsaliyebasimi;
    data['sts_iade_irs_seri_no_rsayac']	=	this.stsiadeirsserinorsayac;
    data['sts_iade_irs_basili_form_rsayac']	=	this.stsiadeirsbasiliformrsayac;
    data['sts_iade_fatura_basimi']	=	this.stsiadefaturabasimi;
    data['sts_iade_fat_seri_no_rsayac']	=	this.stsiadefatserinorsayac;
    data['sts_iade_fat_basili_form_rsayac']	=	this.stsiadefatbasiliformrsayac;

    return data;
  }

  

}
