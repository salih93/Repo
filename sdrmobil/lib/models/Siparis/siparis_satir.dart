import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';

List<SiparisSatir> siparisSatirFromJson(String str) =>
    List<SiparisSatir>.from(
        json.decode(str).map((x) => SiparisSatir.fromJson(x)));

String siparisSatirToJson(List<SiparisSatir> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SiparisSatir {
  int rsayac;
  int musrsayac;
  String cid;
  int sirano;
  int satirid;
  int rtrg;
  int returnsayac;
  int sevkplanino;
  double irsaliyemiktari;
  double masraf01;
  double masraf02;
  double masraf03;
  double toplammasraf;
  String masraflar;
  int miscellenousupdate;
  int malzemersayac;
  double artanmiktar;
  double iademiktari;
  double sevkplanimiktari;
  int toplamalistesiolustu;
  double altbirimadedi;
  int artantopsayisi;
  int toplamalistesitopsayisi;
  int kalantopsayisi;
  int proformano;
  int irsaliyersayac;
  String malzemekodu;
  String birimi;
  double birimfiyat;
  int fiyattanimirsayac;
  double sevkkalanmiktar;
  double miktar;
  String indirim;
  String asama;
  DateTime sevktarihi;
  DateTime teslimtarihi;
  double faturaedilenmiktar;
  int bedelsiz;
  int indirim01flag;
  double indirim01 ;
  int indirim02flag;
  double indirim02;
  int indirim03flag;
  double indirim03;
  int indirim04flag;
  double indirim04;
  int indirim05flag;
  double indirim05;
  int indirim06flag;
  double indirim06;
  double toplamindirim;
  double stddovizkuru;
  double dovizbirimfiyati;
  double doviztutar;
  double dovizsatirtutari;
  double dovizkdvmiktari;
  double satirtutari;
  String sablonkodu;
  double kdvorani;
  double kdvtutari;
  double tutar;
  String depono ;
  String tesisno;
  String stoktipino;
  String grupkodu;
  String indirimkodu;
  int kolibasikampanyaflag;
  int bedelsizkampanyaflag;
  int yuzdeselkampanyaflag;
  int depozito;
  String depozitoparentid;
  int depozitosirano ;
  int kolibasikosul;
  String kolibasicarikod;
  String bedelsiztpr;
  String bedelsizpaket;
  String aciklama;
  int siparisno;
  Uint8List picture;
  String malzemeadi;


 SiparisSatir(
  {      
    this.rsayac,
    this.musrsayac,
    this.cid,
    this.sirano,
    this.satirid,
    this.rtrg,
    this.returnsayac,
    this.sevkplanino,
    this.irsaliyemiktari,
    this.masraf01,
    this.masraf02,
    this.masraf03,
    this.toplammasraf,
    this.masraflar,
    this.miscellenousupdate,
    this.malzemersayac ,
    this.artanmiktar ,
    this.iademiktari ,
    this.sevkplanimiktari,
    this.toplamalistesiolustu ,
    this.altbirimadedi,
    this.artantopsayisi,
    this.toplamalistesitopsayisi,
    this.kalantopsayisi,
    this.proformano,
    this.irsaliyersayac,
    this.malzemekodu,
    this.birimi,
    this.birimfiyat,
    this.fiyattanimirsayac,
    this.sevkkalanmiktar,
    this.miktar,
    this.indirim,
    this.asama,
    this.sevktarihi,
    this.teslimtarihi,
    this.faturaedilenmiktar,
    this.bedelsiz,
    this.indirim01flag,
    this.indirim01 ,
    this.indirim02flag,
    this.indirim02,
    this.indirim03flag,
    this.indirim03,
    this.indirim04flag,
    this.indirim04,
    this.indirim05flag,
    this.indirim05,
    this.indirim06flag,
    this.indirim06,
    this.toplamindirim,
    this.stddovizkuru,
    this.dovizbirimfiyati,
    this.doviztutar,
    this.dovizsatirtutari,
    this.dovizkdvmiktari,
    this.satirtutari,
    this.sablonkodu,
    this.kdvorani,
    this.kdvtutari,
    this.tutar,
    this.depono ,
    this.tesisno,
    this.stoktipino,
    this.grupkodu,
    this.indirimkodu,
    this.kolibasikampanyaflag,
    this.bedelsizkampanyaflag,
    this.yuzdeselkampanyaflag,
    this.depozito,
    this.depozitoparentid,
    this.depozitosirano ,
    this.kolibasikosul,
    this.kolibasicarikod,
    this.bedelsiztpr,
    this.bedelsizpaket,
    this.aciklama,
    this.siparisno,
    this.picture,
    this.malzemeadi
  });

  SiparisSatir.fromJson(Map<String, dynamic> json) {    
    rsayac=json['r_sayac'];
    musrsayac=json['mus_rsayac'];
    cid=json['cid'];
    sirano=json['sira_no'];
    satirid=json['satir_id'];
    rtrg=json['r_trg'];
    returnsayac=json['return_sayac'];
    sevkplanino=json['sevk_plani_no'];
    irsaliyemiktari=json['irsaliye_miktari'];
    masraf01=json['masraf01'];
    masraf02=json['masraf02'];
    masraf03=json['masraf03'];
    toplammasraf=json['toplam_masraf'];
    masraflar=json['masraflar'];
    miscellenousupdate=json['miscellenous_update'];
    malzemersayac=json['malzeme_rsayac'];
    artanmiktar=json['artan_miktar'];
    iademiktari=json['iade_miktari'];
    sevkplanimiktari=json['sevk_plani_miktari'];
    toplamalistesiolustu=json['toplama_listesi_olustu'];
    altbirimadedi=json['alt_birim_adedi'];
    artantopsayisi=json['artan_top_sayisi'];
    toplamalistesitopsayisi=json['toplama_listesi_top_sayisi'];
    kalantopsayisi=json['kalan_top_sayisi'];
    proformano=json['proforma_no'];
    irsaliyersayac=json['irsaliye_rsayac'];
    malzemekodu=json['malzeme_kodu'];
    birimi=json['birimi'];
    birimfiyat=json['birim_fiyat'];
    fiyattanimirsayac=json['fiyat_tanimi_rsayac'];
    sevkkalanmiktar=json['sevk_kalan_miktar'];
    miktar=json['miktar'];
    indirim=json['indirim'];
    asama=json['asama'];
    sevktarihi = json['sevk_tarihi'] == null ? null : DateTime.parse(json['sevk_tarihi']);    
    teslimtarihi = json['teslim_tarihi'] == null ? null : DateTime.parse(json['teslim_tarihi']);
    faturaedilenmiktar=json['fatura_edilen_miktar'];
    bedelsiz=json['bedelsiz'];
    indirim01flag=json['indirim01_flag'];
    indirim01=json['indirim01'];
    indirim02flag=json['indirim02_flag'];
    indirim02=json['indirim02'];
    indirim03flag=json['indirim03_flag'];
    indirim03=json['indirim03'];
    indirim04flag=json['indirim04_flag'];
    indirim04=json['indirim04'];
    indirim05flag=json['indirim05_flag'];
    indirim05=json['indirim05'];
    indirim06flag=json['indirim06_flag'];
    indirim06=json['indirim06'];
    toplamindirim=json['toplam_indirim'];
    stddovizkuru=json['std_doviz_kuru'];
    dovizbirimfiyati=json['doviz_birim_fiyati'];
    doviztutar=json['doviz_tutar'];
    dovizsatirtutari=json['doviz_satir_tutari'];
    dovizkdvmiktari=json['doviz_kdv_miktari'];
    satirtutari=json['satir_tutari'];
    sablonkodu=json['sablon_kodu'];
    kdvorani=json['kdv_orani'];
    kdvtutari=json['kdv_tutari'];
    tutar=json['tutar'];
    depono=json['depo_no'];
    tesisno=json['tesis_no'];
    stoktipino=json['stok_tipi_no'];
    grupkodu=json['grup_kodu'];
    indirimkodu=json['indirim_kodu'];
    kolibasikampanyaflag=json['kolibasi_kampanya_flag'];
    bedelsizkampanyaflag=json['bedelsiz_kampanya_flag'];
    yuzdeselkampanyaflag=json['yuzdesel_kampanya_flag'];
    depozito=json['depozito'];
    depozitoparentid=json['depozito_parent_id'];
    depozitosirano=json['depozito_sira_no'];
    kolibasikosul=json['kolibasi_kosul'];
    kolibasicarikod=json['kolibasi_cari_kod'];
    bedelsiztpr=json['bedelsiz_tpr'] == null ? "0" :  json['bedelsiz_tpr'];
    bedelsizpaket=json['bedelsiz_paket'];
    aciklama=json['aciklama'];
    siparisno=json['siparis_no']==null ? 0:json['siparis_no'];
    picture=json['picture']==null ? null:json['picture'];
    malzemeadi=json['malzeme_adi']==null ? "":json['malzeme_adi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();    
    data['mus_rsayac']=this.musrsayac;
    data['cid']=this.cid;
    data['sira_no']=this.sirano;
    data['satir_id']=this.satirid;
    data['r_trg']=this.rtrg;
    data['return_sayac']=this.returnsayac;
    data['sevk_plani_no']=this.sevkplanino;
    data['irsaliye_miktari']=this.irsaliyemiktari;
    data['masraf01']=this.masraf01;
    data['masraf02']=this.masraf02;
    data['masraf03']=this.masraf03;
    data['toplam_masraf']=this.toplammasraf;
    data['masraflar']=this.masraflar;
    data['miscellenous_update']=this.miscellenousupdate;
    data['malzeme_rsayac']=this.malzemersayac;
    data['artan_miktar']=this.artanmiktar;
    data['iade_miktari']=this.iademiktari;
    data['sevk_plani_miktari']=this.sevkplanimiktari;
    data['toplama_listesi_olustu']=this.toplamalistesiolustu;
    data['alt_birim_adedi']=this.altbirimadedi;
    data['artan_top_sayisi']=this.artantopsayisi;
    data['toplama_listesi_top_sayisi']=this.toplamalistesitopsayisi;
    data['kalan_top_sayisi']=this.kalantopsayisi;
    data['proforma_no']=this.proformano;
    data['irsaliye_rsayac']=this.irsaliyersayac;
    data['malzeme_kodu']=this.malzemekodu;
    data['birimi']=this.birimi;
    data['birim_fiyat']=this.birimfiyat;
    data['fiyat_tanimi_rsayac']=this.fiyattanimirsayac;
    data['sevk_kalan_miktar']=this.sevkkalanmiktar;
    data['miktar']=this.miktar;
    data['indirim']=this.indirim;
    data['asama']=this.asama;
    data['sevk_tarihi']=DateFormat('yyyy-MM-dd 00:00:00.000').format(this.sevktarihi);
    data['teslim_tarihi']=DateFormat('yyyy-MM-dd 00:00:00.000').format(this.teslimtarihi);
    data['fatura_edilen_miktar']=this.faturaedilenmiktar;
    data['bedelsiz']=this.bedelsiz;
    data['indirim01_flag']=this.indirim01flag;
    data['indirim01']=this.indirim01;
    data['indirim02_flag']=this.indirim02flag;
    data['indirim02']=this.indirim02;
    data['indirim03_flag']=this.indirim03flag;
    data['indirim03']=this.indirim03;
    data['indirim04_flag']=this.indirim04flag;
    data['indirim04']=this.indirim04;
    data['indirim05_flag']=this.indirim05flag;
    data['indirim05']=this.indirim05;
    data['indirim06_flag']=this.indirim06flag;
    data['indirim06']=this.indirim06;
    data['toplam_indirim']=this.toplamindirim;
    data['std_doviz_kuru']=this.stddovizkuru;
    data['doviz_birim_fiyati']=this.dovizbirimfiyati;
    data['doviz_tutar']=this.doviztutar;
    data['doviz_satir_tutari']=this.dovizsatirtutari;
    data['doviz_kdv_miktari']=this.dovizkdvmiktari;
    data['satir_tutari']=this.satirtutari;
    data['sablon_kodu']=this.sablonkodu;
    data['kdv_orani']=this.kdvorani;
    data['kdv_tutari']=this.kdvtutari;
    data['tutar']=this.tutar;
    data['depo_no']=this.depono;
    data['tesis_no']=this.tesisno;
    data['stok_tipi_no']=this.stoktipino;
    data['grup_kodu']=this.grupkodu;
    data['indirim_kodu']=this.indirimkodu;
    data['kolibasi_kampanya_flag']=this.kolibasikampanyaflag;
    data['bedelsiz_kampanya_flag']=this.bedelsizkampanyaflag;
    data['yuzdesel_kampanya_flag']=this.yuzdeselkampanyaflag;
    data['depozito']=this.depozito;
    data['depozito_parent_id']=this.depozitoparentid;
    data['depozito_sira_no']=this.depozitosirano;
    data['kolibasi_kosul']=this.kolibasikosul;
    data['kolibasi_cari_kod']=this.kolibasicarikod;
    data['bedelsiz_tpr']=this.bedelsiztpr;
    data['bedelsiz_paket']=this.bedelsizpaket;
    data['aciklama']=this.aciklama;

    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['mus_rsayac']=this.musrsayac;
    data['cid']=this.cid;
    data['sira_no']=this.sirano;
    data['satir_id']=this.satirid;
    data['r_trg']=this.rtrg;
    data['return_sayac']=this.returnsayac;
    data['sevk_plani_no']=this.sevkplanino;
    data['irsaliye_miktari']=this.irsaliyemiktari;
    data['masraf01']=this.masraf01;
    data['masraf02']=this.masraf02;
    data['masraf03']=this.masraf03;
    data['toplam_masraf']=this.toplammasraf;
    data['masraflar']=this.masraflar;
    data['miscellenous_update']=this.miscellenousupdate;
    data['malzeme_rsayac']=this.malzemersayac;
    data['artan_miktar']=this.artanmiktar;
    data['iade_miktari']=this.iademiktari;
    data['sevk_plani_miktari']=this.sevkplanimiktari;
    data['toplama_listesi_olustu']=this.toplamalistesiolustu;
    data['alt_birim_adedi']=this.altbirimadedi;
    data['artan_top_sayisi']=this.artantopsayisi;
    data['toplama_listesi_top_sayisi']=this.toplamalistesitopsayisi;
    data['kalan_top_sayisi']=this.kalantopsayisi;
    data['proforma_no']=this.proformano;
    data['irsaliye_rsayac']=this.irsaliyersayac;
    data['malzeme_kodu']=this.malzemekodu;
    data['birimi']=this.birimi;
    data['birim_fiyat']=this.birimfiyat;
    data['fiyat_tanimi_rsayac']=this.fiyattanimirsayac;
    data['sevk_kalan_miktar']=this.sevkkalanmiktar;
    data['miktar']=this.miktar;
    data['indirim']=this.indirim;
    data['asama']=this.asama;
    data['sevk_tarihi']=DateFormat('yyyy-MM-dd 00:00:00.000').format(this.sevktarihi);
    data['teslim_tarihi']=DateFormat('yyyy-MM-dd 00:00:00.000').format(this.teslimtarihi);
    data['fatura_edilen_miktar']=this.faturaedilenmiktar;
    data['bedelsiz']=this.bedelsiz;
    data['indirim01_flag']=this.indirim01flag;
    data['indirim01']=this.indirim01;
    data['indirim02_flag']=this.indirim02flag;
    data['indirim02']=this.indirim02;
    data['indirim03_flag']=this.indirim03flag;
    data['indirim03']=this.indirim03;
    data['indirim04_flag']=this.indirim04flag;
    data['indirim04']=this.indirim04;
    data['indirim05_flag']=this.indirim05flag;
    data['indirim05']=this.indirim05;
    data['indirim06_flag']=this.indirim06flag;
    data['indirim06']=this.indirim06;
    data['toplam_indirim']=this.toplamindirim;
    data['std_doviz_kuru']=this.stddovizkuru;
    data['doviz_birim_fiyati']=this.dovizbirimfiyati;
    data['doviz_tutar']=this.doviztutar;
    data['doviz_satir_tutari']=this.dovizsatirtutari;
    data['doviz_kdv_miktari']=this.dovizkdvmiktari;
    data['satir_tutari']=this.satirtutari;
    data['sablon_kodu']=this.sablonkodu;
    data['kdv_orani']=this.kdvorani;
    data['kdv_tutari']=this.kdvtutari;
    data['tutar']=this.tutar;
    data['depo_no']=this.depono;
    data['tesis_no']=this.tesisno;
    data['stok_tipi_no']=this.stoktipino;
    data['grup_kodu']=this.grupkodu;
    data['indirim_kodu']=this.indirimkodu;
    data['kolibasi_kampanya_flag']=this.kolibasikampanyaflag;
    data['bedelsiz_kampanya_flag']=this.bedelsizkampanyaflag;
    data['yuzdesel_kampanya_flag']=this.yuzdeselkampanyaflag;
    data['depozito']=this.depozito;
    data['depozito_parent_id']=this.depozitoparentid;
    data['depozito_sira_no']=this.depozitosirano;
    data['kolibasi_kosul']=this.kolibasikosul;
    data['kolibasi_cari_kod']=this.kolibasicarikod;
    data['bedelsiz_tpr']=this.bedelsiztpr;
    data['bedelsiz_paket']=this.bedelsizpaket;
    data['aciklama']=this.aciklama;
    return data;
  }

}
