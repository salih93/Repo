import 'dart:convert';
import 'dart:typed_data';

List<KampanyaUygulanacaklar> kampanyaUygulanacaklarFromJson(String str) =>
    List<KampanyaUygulanacaklar>.from(
        json.decode(str).map((x) => KampanyaUygulanacaklar.fromJson(x)));

String kampanyaUygulanacaklarToJson(List<KampanyaUygulanacaklar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KampanyaUygulanacaklar {
  int siparissatirrsayac;
  String malzemekodu;
  String malzemeadi;
  String grupadi1;
  String grupadi2;
  String grupadi3;
  String path;
  double birimfiyat; 
  int	indirim01flag;
  int	indirim02flag;
  int	indirim03flag;
  int	indirim04flag;
  int	indirim05flag;
  int	indirim06flag;
  double iskontotutari1;
  double iskontotutari2;
  double iskontotutari3;
  double iskontotutari4;
  double iskontotutari5;
  double iskontotutari6;
  String vadekodu;
  double kdvorani;
  String grupadi;
  String bazbirim;
  Uint8List picture;  
  double satirtutari;
  double kdvtutari;
  double toplamindirim;
  double tutar;
  int rowNum;
  double miktar;
  String guid;
  int musrsayac;
  String aciklama;
  int bedelsizkampanyaflag;
  int yuzdeselkampanyaflag;
  int kampanyaRsayac;
  String kampanyaadi;
  double satilacakmiktar;
  double bedelsizgruptoplammiktar;
  String grupkodu;
  String kgrupAdi;
  int secim;
  String indirimler;
  String kindirimler;
  int zorunlu;
  String bedelsiztpr;

  KampanyaUygulanacaklar(
      {  
        this.siparissatirrsayac,
        this.malzemekodu,
        this.malzemeadi,
        this.grupadi1,
        this.grupadi2,
        this.grupadi3,
        this.path,
        this.birimfiyat,
        this.indirim01flag,
        this.indirim02flag,
        this.indirim03flag,
        this.indirim04flag,
        this.indirim05flag,
        this.indirim06flag,
        this.iskontotutari1,
        this.iskontotutari2,
        this.iskontotutari3,
        this.iskontotutari4,
        this.iskontotutari5,
        this.iskontotutari6,
        this.vadekodu,
        this.kdvorani,
        this.grupadi,
        this.bazbirim,
        this.picture,    
        this.tutar,
        this.toplamindirim,
        this.kdvtutari,
        this.satirtutari,
        this.rowNum,
        this.miktar,
        this.guid,
        this.musrsayac,
        this.aciklama,
        this.kampanyaRsayac,
        this.kampanyaadi,
        this.bedelsizkampanyaflag,
        this.yuzdeselkampanyaflag,
        this.satilacakmiktar,
        this.bedelsizgruptoplammiktar,
        this.grupkodu,
        this.kgrupAdi,
        this.secim,
        this.indirimler,
        this.kindirimler,
        this.zorunlu,
        this.bedelsiztpr
      });

  KampanyaUygulanacaklar.fromJson(Map<String, dynamic> json) {
      malzemekodu=json['malzeme_kodu'];
      malzemeadi=json['malzeme_adi'];
      grupadi1=json['grup_adi1'];
      grupadi2=json['grup_adi2'];
      grupadi3=json['grup_adi3'];
      path=json['path'];
      birimfiyat=json['birim_fiyat'];
      indirim01flag=json['indirim01_flag'];
      indirim02flag=json['indirim02_flag'];
      indirim03flag=json['indirim03_flag'];
      indirim04flag=json['indirim04_flag'];
      indirim05flag=json['indirim05_flag'];
      indirim06flag=json['indirim06_flag'];
      iskontotutari1=json['iskonto_tutari1'];
      iskontotutari2=json['iskonto_tutari2'];
      iskontotutari3=json['iskonto_tutari3'];
      iskontotutari4=json['iskonto_tutari4'];
      iskontotutari5=json['iskonto_tutari5'];
      iskontotutari6=json['iskonto_tutari6'];   
      vadekodu=json['vade_kodu'];    
      kdvorani=json['kdv_orani'];
      bazbirim=json['baz_birim'];
      picture=json['picture'];
      siparissatirrsayac=json['siparis_satir_rsayac'];
      satirtutari=json['satir_tutari'];
      kdvtutari=json['kdv_tutari'];
      toplamindirim=json['toplam_indirim'];
      tutar=json['tutar'];
      rowNum=json['rowNum'];
      miktar=json['miktar'];
      guid=json['guid'];
      musrsayac=json['mus_rsayac'];
      aciklama=json['aciklama'];
      kampanyaRsayac=json['kampanya_rsayac'];
      kampanyaadi=json['kampanya_adi'];
      bedelsizkampanyaflag=json['bedelsiz_kampanyaflag'];
      yuzdeselkampanyaflag=json['yuzdesel_kampanyaflag'];

      satilacakmiktar=json['satilacak_miktar'];
      bedelsizgruptoplammiktar=json['bedelsiz_grup_toplammiktar'];      
      grupkodu=json['grupkodu'];
      kgrupAdi=json['kgrupAdi'];
      secim=json['secim']==null ? 0:json['secim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['malzeme_kodu']=malzemekodu;
    data['malzeme_adi']=malzemeadi;
    data['grup_adi1']=grupadi1;
    data['grup_adi2']=grupadi2;
    data['grup_adi3']=grupadi3;
    data['path']=path;
    data['birim_fiyat']=birimfiyat;
    data['indirim01_flag']=indirim01flag;
    data['indirim02_flag']=indirim02flag;
    data['indirim03_flag']=indirim03flag;
    data['indirim04_flag']=indirim04flag;
    data['indirim05_flag']=indirim05flag;
    data['indirim06_flag']=indirim06flag;
    data['iskonto_tutari1']=iskontotutari1;
    data['iskonto_tutari2']=iskontotutari2;
    data['iskonto_tutari3']=iskontotutari3;
    data['iskonto_tutari4']=iskontotutari4;
    data['iskonto_tutari5']=iskontotutari5;
    data['iskonto_tutari6']=iskontotutari6;   
    data['vade_kodu']=vadekodu;
    data['kdv_orani']=kdvorani;
    data['baz_birim']=bazbirim;
    data['picture']=picture;
    data['siparis_satir_rsayac']=siparissatirrsayac;
    data['satir_tutari']=satirtutari;
    data['kdv_tutari']=kdvtutari;
    data['toplam_indirim']=toplamindirim;
    data['tutar']=tutar;
    data['rowNum']=rowNum;
    data['miktar']=miktar;
    data['guid']=guid;
    data['mus_rsayac']=musrsayac;
    data['aciklama']=aciklama;
    data['kampanya_rsayac']=kampanyaRsayac;
    data['kampanya_adi']=kampanyaadi;
    data['bedelsiz_kampanyaflag']=bedelsizkampanyaflag;
    data['yuzdesel_kampanyaflag']=yuzdeselkampanyaflag;
    data['satilacak_miktar']=satilacakmiktar;
    data['bedelsiz_grup_toplammiktar']=bedelsizgruptoplammiktar;      
    data['grup_kodu']=grupkodu;
    data['kgrupAdi']=kgrupAdi;
    
    return data;
  }
}
