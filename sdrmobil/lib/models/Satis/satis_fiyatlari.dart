import 'dart:convert';

List<SatisFiyatlari> satisFiyatlariFromJson(String str) =>
    List<SatisFiyatlari>.from(
        json.decode(str).map((x) => SatisFiyatlari.fromJson(x)));

String satisFiyatlariToJson(List<SatisFiyatlari> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SatisFiyatlari {
  String	kod;
  String	fiyattipi;
  String	parabirimi;
  int	fiyat1;
  int	fiyat2;
  int	fiyat3;
  int	fiyat4;
  int	fiyat5;
  int	kdvlifiyat1;
  int	kdvlifiyat2;
  int	kdvlifiyat3;
  int	kdvlifiyat4;
  int	kdvlifiyat5;
  int	vade1;
  int	vade2;
  int	vade3;
  int	vade4;
  int	vade5;
  int	iskonto1;
  int	iskonto2;
  int	iskonto3;
  int	iskonto4;
  int	iskonto5;
  int	iskonto6;
  int	geneliskontoyuzde;
  double	geneliskontotutar;
  double	fiyattutar1;
  double	fiyattutar2;
  double	fiyattutar3;
  double	fiyattutar4;
  double	fiyattutar5;
  String	vadekodu1;
  String	vadekodu2;
  String	vadekodu3;
  String	vadekodu4;
  String	vadekodu5;
  double	iskontotutari1 ;
  double	iskontotutari2 ;
  double	iskontotutari3;
  double	iskontotutari4;
  double	iskontotutari5;
  double	iskontotutari6;
  int	indirim01flag;
  int	indirim02flag;
  int	indirim03flag;
  int	indirim04flag;
  int	indirim05flag;
  int	indirim06flag;
  String	cid;
  int	birimfiyatdegistir;
  int	geniskontodegistir;
  int	satiriskontodegistir;
  int	vadedegistir;
  int	ortalamatarihhesapla;
  String	listeadi;
  String	listebirim;
  String	bazbirim;
  String	malzemekodu;
  String	satistipi;
  String barkod;
  double stokmiktari;
  String malzemeadi;
  String grupadi1;
  String grupadi2;
  String grupadi3;
  double kdvorani;


 SatisFiyatlari(
      {      
      this.kod,
      this.fiyattipi,
      this.parabirimi,
      this.fiyat1,
      this.fiyat2,
      this.fiyat3,
      this.fiyat4,
      this.fiyat5,
      this.kdvlifiyat1,
      this.kdvlifiyat2,
      this.kdvlifiyat3,
      this.kdvlifiyat4,
      this.kdvlifiyat5,
      this.vade1,
      this.vade2,
      this.vade3,
      this.vade4,
      this.vade5,
      this.iskonto1,
      this.iskonto2,
      this.iskonto3,
      this.iskonto4,
      this.iskonto5,
      this.iskonto6,
      this.geneliskontoyuzde,
      this.geneliskontotutar,
      this.fiyattutar1,
      this.fiyattutar2,
      this.fiyattutar3,
      this.fiyattutar4,
      this.fiyattutar5,
      this.vadekodu1,
      this.vadekodu2,
      this.vadekodu3,
      this.vadekodu4,
      this.vadekodu5,
      this.iskontotutari1,
      this.iskontotutari2,
      this.iskontotutari3,
      this.iskontotutari4,
      this.iskontotutari5,
      this.iskontotutari6,
      this.indirim01flag,
      this.indirim02flag,
      this.indirim03flag,
      this.indirim04flag,
      this.indirim05flag,
      this.indirim06flag,
      this.cid,
      this.birimfiyatdegistir,
      this.geniskontodegistir,
      this.satiriskontodegistir,
      this.vadedegistir,
      this.ortalamatarihhesapla,
      this.listeadi,
      this.listebirim,
      this.bazbirim,
      this.malzemekodu,
      this.satistipi,
      this.barkod,
      this.stokmiktari,
      this.malzemeadi,
      this.grupadi1,
      this.grupadi2,
      this.grupadi3,
      this.kdvorani
    });

  SatisFiyatlari.fromJson(Map<String, dynamic> json) {    
    kod=json['kod'];
    fiyattipi=json['fiyat_tipi'];
    parabirimi=json['para_birimi'];
    fiyat1=json['fiyat1'];
    fiyat2=json['fiyat2'];
    fiyat3=json['fiyat3'];
    fiyat4=json['fiyat4'];
    fiyat5=json['fiyat5'];
    kdvlifiyat1=json['kdvli_fiyat1'];
    kdvlifiyat2=json['kdvli_fiyat2'];
    kdvlifiyat3=json['kdvli_fiyat3'];
    kdvlifiyat4=json['kdvli_fiyat4'];
    kdvlifiyat5=json['kdvli_fiyat5'];
    vade1=json['vade1'];
    vade2=json['vade2'];
    vade3=json['vade3'];
    vade4=json['vade4'];
    vade5=json['vade5'];
    iskonto1=json['iskonto1'];
    iskonto2=json['iskonto2'];
    iskonto3=json['iskonto3'];
    iskonto4=json['iskonto4'];
    iskonto5=json['iskonto5'];
    iskonto6=json['iskonto6'];
    geneliskontoyuzde=json['genel_iskonto_yuzde'];
    geneliskontotutar=json['genel_iskonto_tutar'];
    fiyattutar1=json['fiyat_tutar1'];
    fiyattutar2=json['fiyat_tutar2'];
    fiyattutar3=json['fiyat_tutar3'];
    fiyattutar4=json['fiyat_tutar4'];
    fiyattutar5=json['fiyat_tutar5'];
    vadekodu1=json['vade_kodu1'];
    vadekodu2=json['vade_kodu2'];
    vadekodu3=json['vade_kodu3'];
    vadekodu4=json['vade_kodu4'];
    vadekodu5=json['vade_kodu5'];
    iskontotutari1=json['iskonto_tutari1'];
    iskontotutari2=json['iskonto_tutari2'];
    iskontotutari3=json['iskonto_tutari3'];
    iskontotutari4=json['iskonto_tutari4'];
    iskontotutari5=json['iskonto_tutari5'];
    iskontotutari6=json['iskonto_tutari6'];
    indirim01flag=json['indirim01_flag'];
    indirim02flag=json['indirim02_flag'];
    indirim03flag=json['indirim03_flag'];
    indirim04flag=json['indirim04_flag'];
    indirim05flag=json['indirim05_flag'];
    indirim06flag=json['indirim06_flag'];
    cid=json['cid'];
    birimfiyatdegistir=json['birim_fiyat_degistir'];
    geniskontodegistir=json['gen_iskonto_degistir'];
    satiriskontodegistir=json['satir_iskonto_degistir'];
    vadedegistir=json['vade_degistir'];
    ortalamatarihhesapla=json['ortalama_tarih_hesapla'];
    listeadi=json['liste_adi'];
    listebirim=json['liste_birim'];
    bazbirim=json['baz_birim'];
    malzemekodu=json['malzeme_kodu'];
    satistipi=json['satis_tipi'];
    stokmiktari=json['stok_miktari'];
    barkod=json['barkod'];
    malzemeadi=json['malzeme_adi'];
    grupadi1=json['grup_adi1'];
    grupadi2=json['grup_adi2'];
    grupadi3=json['grup_adi3'];
    kdvorani=json['kdv_orani'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kod']=this.kod;
    data['fiyat_tipi']=this.fiyattipi;
    data['para_birimi']=this.parabirimi;
    data['fiyat1']=this.fiyat1;
    data['fiyat2']=this.fiyat2;
    data['fiyat3']=this.fiyat3;
    data['fiyat4']=this.fiyat4;
    data['fiyat5']=this.fiyat5;
    data['kdvli_fiyat1']=this.kdvlifiyat1;
    data['kdvli_fiyat2']=this.kdvlifiyat2;
    data['kdvli_fiyat3']=this.kdvlifiyat3;
    data['kdvli_fiyat4']=this.kdvlifiyat4;
    data['kdvli_fiyat5']=this.kdvlifiyat5;
    data['vade1']=this.vade1;
    data['vade2']=this.vade2;
    data['vade3']=this.vade3;
    data['vade4']=this.vade4;
    data['vade5']=this.vade5;
    data['iskonto1']=this.iskonto1;
    data['iskonto2']=this.iskonto2;
    data['iskonto3']=this.iskonto3;
    data['iskonto4']=this.iskonto4;
    data['iskonto5']=this.iskonto5;
    data['iskonto6']=this.iskonto6;
    data['genel_iskonto_yuzde']=this.geneliskontoyuzde;
    data['genel_iskonto_tutar']=this.geneliskontotutar;
    data['fiyat_tutar1']=this.fiyattutar1;
    data['fiyat_tutar2']=this.fiyattutar2;
    data['fiyat_tutar3']=this.fiyattutar3;
    data['fiyat_tutar4']=this.fiyattutar4;
    data['fiyat_tutar5']=this.fiyattutar5;
    data['vade_kodu1']=this.vadekodu1;
    data['vade_kodu2']=this.vadekodu2;
    data['vade_kodu3']=this.vadekodu3;
    data['vade_kodu4']=this.vadekodu4;
    data['vade_kodu5']=this.vadekodu5;
    data['iskonto_tutari1']=this.iskontotutari1;
    data['iskonto_tutari2']=this.iskontotutari2;
    data['iskonto_tutari3']=this.iskontotutari3;
    data['iskonto_tutari4']=this.iskontotutari4;
    data['iskonto_tutari5']=this.iskontotutari5;
    data['iskonto_tutari6']=this.iskontotutari6;
    data['indirim01_flag']=this.indirim01flag;
    data['indirim02_flag']=this.indirim02flag;
    data['indirim03_flag']=this.indirim03flag;
    data['indirim04_flag']=this.indirim04flag;
    data['indirim05_flag']=this.indirim05flag;
    data['indirim06_flag']=this.indirim06flag;
    data['cid']=this.cid;
    data['birim_fiyat_degistir']=this.birimfiyatdegistir;
    data['gen_iskonto_degistir']=this.geniskontodegistir;
    data['satir_iskonto_degistir']=this.satiriskontodegistir;
    data['vade_degistir']=this.vadedegistir;
    data['ortalama_tarih_hesapla']=this.ortalamatarihhesapla;
    data['liste_adi']=this.listeadi;
    data['liste_birim']=this.listebirim;
    data['baz_birim']=this.bazbirim;
    data['malzeme_kodu']=this.malzemekodu;
    data['satis_tipi']=this.satistipi;
    data['stok_miktari']=this.stokmiktari;
    data['barkod']=this.barkod;
    data['malzeme_adi']=this.malzemeadi;
    data['grup_adi1']=this.grupadi1;
    data['grup_adi2']=this.grupadi2;
    data['grup_adi3']=this.grupadi3;
    data['kdv_orani']=this.kdvorani;
    
    return data;
  }

 

}
