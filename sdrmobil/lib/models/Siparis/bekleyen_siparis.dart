import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';

List<BekleyenSiparis> bekleyenSiparisFromJson(String str) =>
    List<BekleyenSiparis>.from(
        json.decode(str).map((x) => BekleyenSiparis.fromJson(x)));

String bekleyenSiparisToJson(List<BekleyenSiparis> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BekleyenSiparis {
int rsayac;
int musrsayac;
int siparisno;
String cid;
String musterino;
String unvan;
String teslimmusterino;
DateTime siparistarihi	;
String siparisasama;
String satistipi;
String satistipiadi;
String parabirimi;
String temsilci;
String temsilciadi;
double siparistutari;
double toplamtutar;
double indirimtutari;
int onay;
double toplamkdv;
double toplamotv;
String subfaturatipiid;
String siparisfirma;
String aktarimtipi;
String kullanici;
String subekodu;
String aciklamaandroid;
int sirano;
String malzemekodu;
String birimi;
double birimfiyat;
double miktar;
String indirim;
String asama;
DateTime sevktarihi;
DateTime teslimtarihi;
double faturaedilenmiktar;
int bedelsiz;
int indirim01flag	;
double indirim01	;
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
double satirtutari;
String sablonkodu;
double kdvorani;
double kdvtutari;
double tutar;
String depono;
String tesisno;
String stoktipino;
String grupkodu;
String indirimkodu;
int kolibasikampanyaflag;
Uint8List picture;
String malzemeadi;
String grupadi;
String grupAdi1;
String grupAdi2;
String grupAdi3;
String bazbirim;

 BekleyenSiparis(
    {      
      this.rsayac,
      this.musrsayac,
      this.siparisno,
      this.cid,
      this.musterino,
      this.unvan,
      this.teslimmusterino,
      this.siparistarihi,
      this.siparisasama,
      this.satistipi,
      this.satistipiadi,
      this.parabirimi,
      this.temsilci,
      this.temsilciadi,
      this.siparistutari,
      this.toplamtutar,
      this.indirimtutari,
      this.onay,
      this.toplamkdv,
      this.toplamotv,
      this.subfaturatipiid,
      this.siparisfirma,
      this.aktarimtipi,
      this.kullanici,
      this.subekodu,
      this.aciklamaandroid,
      this.sirano,
      this.malzemekodu,
      this.birimi,
      this.birimfiyat,
      this.miktar,
      this.indirim,
      this.asama,
      this.sevktarihi,
      this.teslimtarihi,
      this.faturaedilenmiktar,
      this.bedelsiz,
      this.indirim01flag,
      this.indirim01,
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
      this.satirtutari,
      this.sablonkodu,
      this.kdvorani,
      this.kdvtutari,
      this.tutar,
      this.depono,
      this.tesisno,
      this.stoktipino,
      this.grupkodu,
      this.indirimkodu,
      this.kolibasikampanyaflag,
      this.picture,
      this.malzemeadi,
      this.grupadi,
      this.grupAdi1,
      this.grupAdi2,
      this.grupAdi3,
      this.bazbirim
    });

  BekleyenSiparis.fromJson(Map<String, dynamic> json) {    
    rsayac=json['r_sayac'];
    musrsayac=json['mus_rsayac'];
    siparisno=json['siparis_no'];
    cid=json['cid'];
    musterino=json['musteri_no'];
    unvan=json['unvan'];
    teslimmusterino=json['teslim_musteri_no'];
    siparistarihi = json['siparis_tarihi'] == null ? null : DateTime.parse(json['siparis_tarihi']);
    siparisasama=json['siparis_asama'];
    satistipi=json['satis_tipi'];
    satistipiadi=json['satis_tipi_adi'];
    parabirimi=json['para_birimi'];
    temsilci=json['temsilci'];
    temsilciadi=json['temsilci_adi'];
    siparistutari=json['siparis_tutari'];
    toplamtutar=json['toplam_tutar'];
    indirimtutari=json['indirim_tutari'];
    onay=json['onay'];
    toplamkdv=json['toplam_kdv'];
    toplamotv=double.parse(json['toplam_otv'].toString());
    subfaturatipiid=json['sub_fatura_tipi_id'];
    siparisfirma=json['siparis_firma'];
    aktarimtipi=json['aktarim_tipi'];
    kullanici=json['kullanici'];
    subekodu=json['sube_kodu'];
    aciklamaandroid=json['aciklama_android'];
    sirano=json['sira_no'];
    malzemekodu=json['malzeme_kodu'];    
    birimi=json['birimi'];
    birimfiyat=json['birim_fiyat'];
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
    picture = json['picture'] == null ? null : json['picture'];
    malzemeadi = json['malzeme_adi'];    
    grupadi= json['grupadi'] == null ? null : json['grupadi'];
    grupAdi1= json['grup_adi1'] == null ? null : json['grup_adi1'];
    grupAdi2= json['grup_adi2'] == null ? null : json['grup_adi2'];
    grupAdi3= json['grup_adi3'] == null ? null : json['grup_adi3'];
    bazbirim=json['baz_birim'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    
        
    data['r_sayac']=this.rsayac;
    data['mus_rsayac']=this.musrsayac;
    data['siparis_no']=this.siparisno;
    data['cid']=this.cid;
    data['musteri_no']=this.musterino;
    data['unvan']=this.unvan;
    data['teslim_musteri_no']=this.teslimmusterino;
    data['siparis_tarihi']=DateFormat('yyyy-MM-dd 00:00:00.000').format(this.siparistarihi);
    data['siparis_asama']=this.siparisasama;
    data['satis_tipi']=this.satistipi;
    data['satis_tipi_adi']=this.satistipiadi;
    data['para_birimi']=this.parabirimi;
    data['temsilci']=this.temsilci;
    data['temsilci_adi']=this.temsilciadi;
    data['siparis_tutari']=this.siparistutari;
    data['toplam_tutar']=this.toplamtutar;
    data['indirim_tutari']=this.indirimtutari;
    data['onay']=this.onay;
    data['toplam_kdv']=this.toplamkdv;
    data['toplam_otv']=this.toplamotv;
    data['sub_fatura_tipi_id']=this.subfaturatipiid;
    data['siparis_firma']=this.siparisfirma;
    data['aktarim_tipi']=this.aktarimtipi;
    data['kullanici']=this.kullanici;
    data['sube_kodu']=this.subekodu;
    data['aciklama_android']=this.aciklamaandroid;
    data['sira_no']=this.sirano;
    data['malzeme_kodu']=this.malzemekodu;
    data['birimi']=this.birimi;
    data['birim_fiyat']=this.birimfiyat;
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
    
    data['malzeme_adi']=this.malzemeadi;
    data['grup_adi1']=this.grupAdi1;
    data['grup_adi2']=this.grupAdi2;
    data['grup_adi3']=this.grupAdi3;
    data['baz_birim']=this.bazbirim;
    
    return data;
  }

 

}
