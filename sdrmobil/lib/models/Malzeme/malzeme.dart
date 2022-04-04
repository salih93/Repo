import 'dart:convert';

List<Malzeme> malzemeFromJson(String str) =>
    List<Malzeme>.from(
        json.decode(str).map((x) => Malzeme.fromJson(x)));

String malzemeToJson(List<Malzeme> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Malzeme {
    int rsayac;
		String malzemekodu;
		String malzemeadi;
		String malzemesinifiadi;
		String malzemebirimi;
		String satinalmabirimi;
		String satisbirimi;
		String depobirimi;
		String cikisbirimi;
		String birimi;
		String malzemesinifino;
		double kdvorani;
		String diststokkodu;
		String bazbirim;
		String path;
		int yururluktenkaldirildi;
		String grupkodu1;
		String grupadi1;
		String grupkodu2;
		String grupadi2;
		String grupkodu3;
		String grupadi3;
		String grupkodu4;
		String grupadi4;
		String grupkodu5;
		String grupadi5;
		int faturaaltiindirimleredahil;

  Malzeme(
      {
        this.rsayac,
        this.malzemekodu,
        this.malzemeadi,
        this.malzemesinifiadi,
        this.malzemebirimi,
        this.satinalmabirimi,
        this.satisbirimi,
        this.depobirimi,
        this.cikisbirimi,
        this.birimi,
        this.malzemesinifino,
        this.kdvorani,
        this.diststokkodu,
        this.bazbirim,
        this.path,
        this.yururluktenkaldirildi,
        this.grupkodu1,
        this.grupadi1,
        this.grupkodu2,
        this.grupadi2,
        this.grupkodu3,
        this.grupadi3,
        this.grupkodu4,
        this.grupadi4,
        this.grupkodu5,
        this.grupadi5,
        this.faturaaltiindirimleredahil,
      });

  Malzeme.fromJson(Map<String, dynamic> json) {
    rsayac=json['r_sayac'];
    malzemekodu=json['malzeme_kodu'];
    malzemeadi=json['malzeme_adi'];
    malzemesinifiadi=json['malzeme_sinifi_adi'];
    malzemebirimi=json['malzeme_birimi'];
    satinalmabirimi=json['satinalma_birimi'];
    satisbirimi=json['satis_birimi'];
    depobirimi=json['depo_birimi'];
    cikisbirimi=json['cikis_birimi'];
    birimi=json['birimi'];
    malzemesinifino=json['malzeme_sinifi_no'];
    kdvorani=json['kdv_orani'];
    diststokkodu=json['dist_stok_kodu'];
    bazbirim=json['baz_birim'];
    path=json['path'];
    yururluktenkaldirildi=json['yururlukten_kaldirildi'];
    grupkodu1=json['grup_kodu1'];
    grupadi1=json['grup_adi1'];
    grupkodu2=json['grup_kodu2'];
    grupadi2=json['grup_adi2'];
    grupkodu3=json['grup_kodu3'];
    grupadi3=json['grup_adi3'];
    grupkodu4=json['grup_kodu4'];
    grupadi4=json['grup_adi4'];
    grupkodu5=json['grup_kodu5'];
    grupadi5=json['grup_adi5'];
    faturaaltiindirimleredahil=json['fatura_alti_indirimlere_dahil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac']=this.rsayac;
    data['malzeme_kodu']=this.malzemekodu;
    data['malzeme_adi']=this.malzemeadi;
    data['malzeme_sinifi_adi']=this.malzemesinifiadi;
    data['malzeme_birimi']=this.malzemebirimi;
    data['satinalma_birimi']=this.satinalmabirimi;
    data['satis_birimi']=this.satisbirimi;
    data['depo_birimi']=this.depobirimi;
    data['cikis_birimi']=this.cikisbirimi;
    data['birimi']=this.birimi;
    data['malzeme_sinifi_no']=this.malzemesinifino;
    data['kdv_orani']=this.kdvorani;
    data['dist_stok_kodu']=this.diststokkodu;
    data['baz_birim']=this.bazbirim;
    data['path']=this.path;
    data['yururlukten_kaldirildi']=this.yururluktenkaldirildi;
    data['grup_kodu1']=this.grupkodu1;
    data['grup_adi1']=this.grupadi1;
    data['grup_kodu2']=this.grupkodu2;
    data['grup_adi2']=this.grupadi2;
    data['grup_kodu3']=this.grupkodu3;
    data['grup_adi3']=this.grupadi3;
    data['grup_kodu4']=this.grupkodu4;
    data['grup_adi4']=this.grupadi4;
    data['grup_kodu5']=this.grupkodu5;
    data['grup_adi5']=this.grupadi5;
    data['fatura_alti_indirimlere_dahil']=this.faturaaltiindirimleredahil;

    return data;
  }
}
