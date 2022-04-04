import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Kampanya/kampanya.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_bedelsiz_satir.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_bedelsiz_verilen.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_secimli_gruplar.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_yuzdesel_satir.dart';
import 'package:sdrmobil/models/Raporlar/acik_hesap_listesi.dart';
import 'package:sdrmobil/models/Raporlar/gunluk_tahsilat.dart';
import 'package:sdrmobil/models/Raporlar/musteri_mal_analizi.dart';
import 'package:sdrmobil/models/Satis/aylik_satis.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis.dart';
import 'package:sdrmobil/models/Malzeme/birim_cevrimi.dart';
import 'package:sdrmobil/models/Cari/cari.dart';
import 'package:sdrmobil/models/Cari/cari_hesap_ekstresi.dart';
import 'package:sdrmobil/models/Cari/cari_rut.dart';
import 'package:sdrmobil/models/Cari/cari_sube.dart';
import 'package:sdrmobil/models/Cari/cari_vade_farki.dart';
import 'package:sdrmobil/models/Siparis/gunluk_siparis.dart';
import 'package:sdrmobil/models/Tahsilat/kasa.dart';
import 'package:sdrmobil/models/Malzeme/malzeme.dart';
import 'package:sdrmobil/models/Malzeme/malzeme_picture.dart';
import 'package:sdrmobil/models/Satis/satis_fiyatlari.dart';
import 'package:sdrmobil/models/Satis/satis_tipi.dart';
import 'package:sdrmobil/models/tanimlar.dart';
import 'package:sdrmobil/models/validation_response.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret_sonlandirma_tipleri.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret_tipleri.dart';
import 'package:sdrmobil/models/validation_response_list.dart';
import 'package:sdrmobil/providers/db_provider.dart';

class TableApiProvider {
  String surl;
  String stemsilci;
  String sveritabani;
  String scari;

  TableApiProvider(
      String surl, String stemsilci, String sveritabani, String scari) {
    this.surl = surl;
    this.stemsilci = stemsilci;
    this.sveritabani = sveritabani;
    this.scari = scari;
  }

  Future<int> getTumTanimlar() async {
    List<dynamic> values=<dynamic>[];
    
    var url = surl + "/SDRData/GetAllTanimlar";
    //url= "http://192.168.200.17:5001/SDRData/GetAllTanimlar";
    //url= "http://192.168.1.61:5001/SDRData/GetAllTanimlar";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');

    try {
      await DBProvider.db.deleteTable("Tanimlar");
      await DBProvider.db.deleteTable("Kasa");
      await DBProvider.db.deleteTable("ZiyaretTipleri");
      await DBProvider.db.deleteTable("ZiyaretSonlandirmaTipleri");
      await DBProvider.db.deleteTable("Malzeme");
      await DBProvider.db.deleteTable("BirimCevrimi");
      final client = Dio();

      final response = await client.post(url,
          data: {'temsilci_kodu': stemsilci, 
          'veritabani_adi': sveritabani,
          'token':DBProvider.getToken(),
          'email':DBProvider.getEmail()
        });

      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;

      if (values!=null && values.length>0)
      {
        List<Tanimlar> tanims=<Tanimlar>[];
        var tanimlar = jsonDecode(values[0]);
        (tanimlar as List).map((item) async {        
          tanims.add(Tanimlar.fromJson(item));          
        }).toList();
        await DBProvider.db.insertBulkTanimlar(tanims);
        tanims.clear();

        List<Kasa> kasas=<Kasa>[];
        var kasalar=jsonDecode(values[1]);
        (kasalar as List).map((item) async {        
          kasas.add(Kasa.fromJson(item));          
        }).toList();
        await DBProvider.db.insertbulkKasa(kasas);
        kasas.clear();

        List<ZiyaretTipleri> ziyarets=<ZiyaretTipleri>[];
        var ziyaretTipleri=jsonDecode(values[2]);
        (ziyaretTipleri as List).map((item) async {        
          ziyarets.add(ZiyaretTipleri.fromJson(item));          
        }).toList();
        await DBProvider.db.insertBulkZiyaretTipleri(ziyarets);
        ziyarets.clear();

        List<ZiyaretSonlandirmaTipleri> ziyaretStipleri=<ZiyaretSonlandirmaTipleri>[];
        var ziyaretSonlandirma=jsonDecode(values[3]);
        (ziyaretSonlandirma as List).map((item) async {        
          ziyaretStipleri.add(ZiyaretSonlandirmaTipleri.fromJson(item));          
        }).toList();
        await DBProvider.db.insertBulkZiyaretSonlandirmaTipleri(ziyaretStipleri);
        ziyaretStipleri.clear();

        List<Malzeme> malzemes=<Malzeme>[];
        var malzemeler=jsonDecode(values[4]);
        (malzemeler as List).map((item) async {
          malzemes.add(Malzeme.fromJson(item));          
        }).toList();
        await DBProvider.db.insertBulkMalzeme(malzemes);
        malzemes.clear();

        List<BirimCevrimi> birimcevrimis=<BirimCevrimi>[];
        var birimler=jsonDecode(values[5]);
        (birimler as List).map((item) async {        
          birimcevrimis.add(BirimCevrimi.fromJson(item));          
        }).toList();
        await DBProvider.db.insertBulkBirimCevrimi(birimcevrimis);
        birimcevrimis.clear();
      }
      return 1;

    } on DioError catch (e) {
      snackbar("Hata", e.message, Icons.error);      
      return null;
    }
  }

  Future<int> getAllCariVeRut() async {
    List<dynamic> values=<dynamic>[];
    
    var url = surl + "/SDRData/GetAllCariVeRut";
    //url= "http://192.168.1.61:5001/SDRData/GetAllCariVeRut";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');

    try {
      Response response = await Dio().post(url,
          data: {'temsilci_kodu': stemsilci, 
          'veritabani_adi': sveritabani,
          'token':DBProvider.getToken(),
          'email':DBProvider.getEmail()
        });

      await DBProvider.db.deleteTable("Cari");
      await DBProvider.db.deleteTable("CariSube");
      await DBProvider.db.deleteTable("CariRut");  
      await DBProvider.db.deleteTable("SatisTipleri");

      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;          

      if (values!=null && values.length>0)
      {
        var cariKartlar = jsonDecode(values[0]);

        print("11111111 Cariler başladı 11111");
        print(DateTime.now());

        List<Cari> cariList=<Cari>[];
        (cariKartlar as List).map((item) async {        
          cariList.add(Cari.fromJson(item));          
        }).toList();
        await DBProvider.db.caribulkInsert(cariList);
        cariList.clear();

        var cariSubeler=jsonDecode(values[1]);
        List<CariSube> carisubes=<CariSube>[];
        (cariSubeler as List).map((item) async {        
          carisubes.add(CariSube.fromJson(item));          
        }).toList();
        await DBProvider.db.bulkInsertCariSube(carisubes);
        carisubes.clear();

        var rutlar=jsonDecode(values[2]);
        List<CariRut> cariRuts=<CariRut>[];
        (rutlar as List).map((item) async {        
          cariRuts.add(CariRut.fromJson(item));          
        }).toList();
        await DBProvider.db.bulkInsertCariRut(cariRuts);
        cariRuts.clear();

        var satisTipleri=jsonDecode(values[3]);
        List<SatisTipi> satisTipis=<SatisTipi>[];

        (satisTipleri as List).map((item) async {        
          satisTipis.add(SatisTipi.fromJson(item));          
        }).toList();
        await DBProvider.db.insertbulkSatisTipi(satisTipis);
        satisTipis.clear();

        print("11111111 Cariler bitti 11111");
        print(DateTime.now());

      }
      return 1;

    } on DioError catch (e) {
      print(e.toString());
      snackbar("Hat", e.message, Icons.error);
      return null;
    }
  }


  Future<List<Tanimlar>> getAllTanimlar() async {
    var url = surl + "/SDRData/GetAllTanimlar";
    //url= "http://192.168.200.17:5001/SDRData/GetAllTanimlar";

    try {
      Response response = await Dio().post(url,
          data: {'temsilci_kodu': stemsilci, 'veritabani_adi': sveritabani});

      await DBProvider.db.deleteTable("Tanimlar");

      //List<Tanimlar> liste = (response.data as List).map((e) => Tanimlar.fromJson(e)).toList();

      return (response.data as List).map((tanimlar) {
        //print('Inserting $tanimlar');
        DBProvider.db.insertTanimlar(Tanimlar.fromJson(tanimlar));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Cari>> getAllCari() async {
    var url = surl + "/SDRData/GetCariKartlar";
    //url= "http://192.168.200.17:5001/SDRData/GetCariKartlar";

    try {
      Response response = await Dio().post(url,
          data: {'temsilci_kodu': stemsilci, 'veritabani_adi': sveritabani});

      await DBProvider.db.deleteTable("Cari");

      return (response.data as List).map((cari) {
        DBProvider.db.insertCari(Cari.fromJson(cari));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<ValidationResponse> setTahsilat(List<String> values) async {
    var url = surl + "/SDRData/SetTahsilat";
    //url= "http://192.168.200.17:5001/SDRData/SetTahsilat";
    ValidationResponse vr=new ValidationResponse(successful: true, code: "", result: "", information: "");
    try {
      
      Response response = await Dio().post(url, data: values);

      vr=ValidationResponse.fromJson(response.data);

      return vr;
    } on Exception catch (e) {
      vr.successful=false;
      vr.information="Tahsilatlar gönderilemedi." + e.toString();
      print(e.toString());
      return vr;
    }
  }

  Future<ValidationResponse> setZiyaret(List<String> values) async {
    var url = surl + "/SDRData/SetZiyaret";
    //url= "http://192.168.200.17:5001/SDRData/SetZiyaret";    
    ValidationResponse vr=new ValidationResponse(successful: true, code: "", result: "", information: "");
    try {
      
      Response response = await Dio().post(url, data: values);

      vr=ValidationResponse.fromJson(response.data);

      return vr;
    } on Exception catch (e) {
      vr.successful=false;
      vr.information="Ziyaretler gönderilemedi." + e.toString();
      print(e.toString());
      return vr;
    }
  }


  Future<ValidationResponse> setSiparis(List<String> values) async {
    var url = surl + "/SDRData/SetSiparis";
    //url= "http://192.168.1.83:5001/SDRData/SetSiparis";    
    ValidationResponse vr=new ValidationResponse(successful: true, code: "", result: "", information: "");
    try {
      
      Response response = await Dio().post(url, data: values);

      vr=ValidationResponse.fromJson(response.data);

      return vr;
    } on Exception catch (e) {
      vr.successful=false;
      vr.information="Siparişler gönderilemedi." + e.toString();
      print(e.toString());
      return vr;
    }
  }


  Future<String> apiRequest(String url, var data) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(data));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
}


  Future<List<CariSube>> getAllCariSube() async {
     
    var url = surl + "/SDRData/GetCariKartSubeler";
    //url= "http://192.168.200.17:5001/SDRData/GetCariKartSubeler";

    try {
      Response response = await Dio().post(url,
          //data: {'temsilci_kodu': '01', 'veritabani_adi': 'TICARI_DEMO'});
          data: {'temsilci_kodu': stemsilci, 'veritabani_adi': sveritabani});
      await DBProvider.db.deleteTable("CariSube");      

      return (response.data as List).map((carisube) {
        DBProvider.db.insertCariSube(CariSube.fromJson(carisube));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<CariRut>> getAllCariRut() async {
    var url = surl + "/SDRData/GetRutTanimi";
    //url= "http://192.168.200.17:5001/SDRData/GetRutTanimi";

    try {
      Response response = await Dio().post(url,
          data: {'temsilci_kodu': stemsilci, 'veritabani_adi': sveritabani});
      
      await DBProvider.db.deleteTable("CariRut");
      

      return (response.data as List).map((carirut) {
        DBProvider.db.insertCariRut(CariRut.fromJson(carirut));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Kasa>> getAllKasa() async {
    var url = surl + "/SDRData/GetKasalar";
    //url= "http://192.168.200.17:5001/SDRData/GetKasalar";

    try {
      Response response = await Dio().post(url,
          data: {'temsilci_kodu': stemsilci, 'veritabani_adi': sveritabani});

      await DBProvider.db.deleteTable("Kasa");

      return (response.data as List).map((kasa) {
        DBProvider.db.insertKasa(Kasa.fromJson(kasa));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<CariAylikSatis>> getCariAylikSatis() async {
    var url = surl + "/SDRData/GetAylikSatis";
    //url= "http://192.168.200.17:5001/SDRData/GetAylikSatis";

    try {
      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': scari
      });

      await DBProvider.db.deleteTable("CariAylikSatis");

      return (response.data as List).map((ayliksatis) {
        DBProvider.db.insertCariAylikSatis(CariAylikSatis.fromJson(ayliksatis));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<CariHesapEkstresi>> getCariHesapEktresi() async {
    
    var url = surl + "/SDRData/GetCariHesapEkstresi";
    //url= "http://192.168.1.42:5001/SDRData/GetCariHesapEkstresi";

    try {
      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': scari
      });

      await DBProvider.db.deleteTable("CariHesapEkstresi");

      return (response.data as List).map((ekstre) {
        DBProvider.db.insertCariHesapEkstre(CariHesapEkstresi.fromJson(ekstre));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<ZiyaretTipleri>> getZiyaretTipleri() async {
    var url = surl + "/SDRData/GetZiyaretTipleri";
    //url= "http://192.168.200.17:5001/SDRData/GetZiyaretTipleri";

    try {
      Response response = await Dio().post(url, data: {        
        'veritabani_adi': sveritabani        
      });

      await DBProvider.db.deleteTable("ZiyaretTipleri");
      

      return (response.data as List).map((ekstre) {
        DBProvider.db.insertZiyaretTipleri(ZiyaretTipleri.fromJson(ekstre));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<ZiyaretSonlandirmaTipleri>> getZiyaretSonlandirmaTipleri() async {
    var url = surl + "/SDRData/GetZiyaretSonlandirmaTipleri";
    //url= "http://192.168.200.17:5001/SDRData/GetZiyaretSonlandirmaTipleri";

    try {
      Response response = await Dio().post(url, data: {        
        'veritabani_adi': sveritabani        
      });

      await DBProvider.db.deleteTable("ZiyaretSonlandirmaTipleri");
      
      return (response.data as List).map((ekstre) {
        DBProvider.db.insertZiyaretSonlandirmaTipleri(ZiyaretSonlandirmaTipleri.fromJson(ekstre));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }



  Future<List<CariVadeFarki>> getCariVadeFarki() async {
    var url = surl + "/SDRData/GetCariVadefarki";
    //url= "http://192.168.200.17:5001/SDRData/GetCariVadefarki";

    try {
      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': scari
      });

      await DBProvider.db.deleteTable("CariVadeFarki");

      return (response.data as List).map((vadefarki) {
        DBProvider.db.insertCariVadeFarki(CariVadeFarki.fromJson(vadefarki));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<SatisTipi>> getSatisTipi() async {
    var url = surl + "/SDRData/GetSatisTipleri";
    //url= "http://192.168.200.17:5001/SDRData/GetSatisTipleri";

    try {
      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': null
      });

      await DBProvider.db.deleteTable("SatisTipleri");
      

      return (response.data as List).map((satisTipi) {
        DBProvider.db.insertSatisTipi(SatisTipi.fromJson(satisTipi));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());      
      return null;
    }
  }

  Future<List<SatisTipi>> getSatisFiyatlari() async {
    var url = surl + "/SDRData/GetSatisFiyatlari";
    //url= "http://192.168.200.17:5001/SDRData/GetSatisFiyatlari";

    try {
      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': scari,
        "tarih":DateFormat('yyyy-MM-dd').format(DateTime.now())
      });

      await DBProvider.db.deleteTable("SatisFiyatlari");

      return (response.data as List).map((satisFiyatlari) {
        DBProvider.db.insertSatisFiyatlari(SatisFiyatlari.fromJson(satisFiyatlari));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<SatisTipi>> getMalzeme() async {
    var url = surl + "/SDRData/GetMalzeme";
    //url= "http://192.168.200.17:5001/SDRData/GetMalzeme";

    try {
      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani        
      });

      await DBProvider.db.deleteTable("Malzeme");      

      return (response.data as List).map((malzeme) {        
        DBProvider.db.insertMalzeme(Malzeme.fromJson(malzeme));        
        //DBProvider.db.insertMalzemePicture()
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<MalzemePicture>> getMalzemePicture() async {

      List<MalzemePicture> list=<MalzemePicture>[];
      try {
        list=await DBProvider.db.getMalzemePicture();        
      } catch (e) {
        print(e.toString());
        return null;
      }
      
      return list;
  }

  Future<List<SatisTipi>> getMalzemeBirimCevrimi() async {
    var url = surl + "/SDRData/GetMalzemeBirimCevrimi";
    //url= "http://192.168.200.17:5001/SDRData/GetMalzemeBirimCevrimi";

    try {
      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani        
      });

      await DBProvider.db.deleteTable("BirimCevrimi");

      return (response.data as List).map((birimCevrimi) {
        DBProvider.db.insertBirimCevrimi(BirimCevrimi.fromJson(birimCevrimi));
      }).toList();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }



  Future<int> getKampanya() async {
    List<dynamic> values=<dynamic>[];

    var url = surl + "/SDRData/GetKampanya";
    //url= "http://192.168.1.61:5001/SDRData/GetKampanya";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');
    
    try {

      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': scari,
        'token':DBProvider.getToken(),
        'email':DBProvider.getEmail()
      });
    

      // await DBProvider.db.deleteTable("Kampanya");
      // await DBProvider.db.deleteTable("KampanyaBedelsizSatir");
      //await DBProvider.db.deleteTable("KampanyaBedelsizVerilen");
      //await DBProvider.db.deleteTable("KampanyaYuzdeselSatir");
      // await DBProvider.db.deleteTable("KampanyaSecimliGruplar");
      await DBProvider.db.deleteFrom("Delete from KampanyaBedelsizSatir " + 
      "Where Exists(Select a.r_sayac from Kampanya a Where a.r_sayac=KampanyaBedelsizSatir.kampanya_rsayac And a.cari_kodu='$scari')");

      await DBProvider.db.deleteFrom("Delete from KampanyaBedelsizVerilen " + 
      "Where Exists(Select a.r_sayac from Kampanya a Where a.r_sayac=KampanyaBedelsizVerilen.kampanya_rsayac And a.cari_kodu='$scari')");

      await DBProvider.db.deleteFrom("Delete from KampanyaYuzdeselSatir " + 
      "Where Exists(Select a.r_sayac from Kampanya a Where a.r_sayac=KampanyaYuzdeselSatir.kampanya_rsayac And a.cari_kodu='$scari')");

      await DBProvider.db.deleteFrom("Delete from KampanyaSecimliGruplar " + 
      "Where Exists(Select a.r_sayac from Kampanya a Where a.r_sayac=KampanyaSecimliGruplar.kampanya_rsayac And a.cari_kodu='$scari')");

      await DBProvider.db.deleteFrom("Delete from Kampanya Where cari_kodu='$scari'");


      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;

      if (values!=null && values.length>0)
      {
        List<Kampanya> kampanyalar=<Kampanya>[];
        var kampanyaList = jsonDecode(values[0]);
        (kampanyaList as List).map((item) {                  
          kampanyalar.add(Kampanya.fromJson(item));
        }).toList();
        await DBProvider.db.insertBulkKampanya(kampanyalar);
        kampanyalar.clear();
        

        List<KampanyaBedelsizSatir> kampanyaBedelsizSatirlar=<KampanyaBedelsizSatir>[];
        var kampanyaBedelsizSatirs=jsonDecode(values[1]);
        (kampanyaBedelsizSatirs as List).map((item) {
          kampanyaBedelsizSatirlar.add(KampanyaBedelsizSatir.fromJson(item));          
        }).toList();
        await DBProvider.db.insertBulkKampanyaBedelsizSatir(kampanyaBedelsizSatirlar);
        kampanyaBedelsizSatirlar.clear();

        List<KampanyaBedelsizVerilen> kampanyaBedelsizVerilenler=<KampanyaBedelsizVerilen>[];
        var kampanyaBedelsizVerilens=jsonDecode(values[2]);
        (kampanyaBedelsizVerilens as List).map((item) {        
          kampanyaBedelsizVerilenler.add(KampanyaBedelsizVerilen.fromJson(item));          
        }).toList();
        await DBProvider.db.insertBulkKampanyaBedelsizVerilen(kampanyaBedelsizVerilenler);
        kampanyaBedelsizVerilenler.clear();

        List<KampanyaYuzdeselSatir> kampanyaYuzdeselSatirlar=<KampanyaYuzdeselSatir>[];
        var kampanyaYuzdeselSatirs=jsonDecode(values[3]);
        (kampanyaYuzdeselSatirs as List).map((item) {       
          kampanyaYuzdeselSatirlar.add(KampanyaYuzdeselSatir.fromJson(item));           
        }).toList();
        await DBProvider.db.insertBulkKampanyaYuzdeselSatir(kampanyaYuzdeselSatirlar);
        kampanyaYuzdeselSatirlar.clear();

        List<KampanyaSecimliGruplar> kampanyaSecimliGruplar=<KampanyaSecimliGruplar>[];
        var kampanyaSecimliGruplars=jsonDecode(values[4]);
        (kampanyaSecimliGruplars as List).map((item) {
          kampanyaSecimliGruplar.add(KampanyaSecimliGruplar.fromJson(item));          
        }).toList();
        await DBProvider.db.insertBulkKampanyaSecimliGruplar(kampanyaSecimliGruplar);
        kampanyaSecimliGruplar.clear();

      }
      return 1;
    } on DioError catch (e) {
      snackbar("Hata",e.message, Icons.person);
      return null;
    }


  }

  getMusteriMalAnalizi() async {
    List<dynamic> values=<dynamic>[];

    var url = surl + "/SDRData/GetMusteriMalAnalizi";    
    //url= "http://192.168.1.61:5001/SDRData/GetMusteriMalAnalizi";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');

    try {      

      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': null,
        'tarih1':'2000-01-01',        
        'tarih2':DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'token':DBProvider.getToken(),
        'email':DBProvider.getEmail()
      });
      
      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;

      var results = jsonDecode(values[0]);

      
      await DBProvider.db.deleteTable("MusteriMalAnalizi"); 

      List<MusteriMalAnalizi> mmAnalizleri=<MusteriMalAnalizi>[];
      (results as List).map((a) {
        mmAnalizleri.add(MusteriMalAnalizi.fromJson(a));        
      }).toList();

      await DBProvider.db.insertBulkMusteriMalAnalizi(mmAnalizleri);
      mmAnalizleri.clear();

      //snackbar("Bilgi", "Müşteri Mal Analizi Raporu Hazır.", Icons.person);
    } on DioError catch (e) {
      print(e.toString());      
      snackbar("Hata",e.message, Icons.person);
      return null;
    }

    

  }

  getAllSatislar() async {    
    List<dynamic> values=<dynamic>[];
    var url = surl + "/SDRData/GetAllSatislar";
    //url= "http://192.168.1.61:5001/SDRData/GetAllSatislar";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');
    

    try {

      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': scari,
        'token':DBProvider.getToken(),
        'email':DBProvider.getEmail()
      });


      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;


      if (values!=null && values.length>0)
      {
        List<CariAylikSatis> cariSatislar=<CariAylikSatis>[];
        var satislar = jsonDecode(values[0]);
        (satislar as List).map((item) {        
          cariSatislar.add(CariAylikSatis.fromJson(item));
        }).toList();
        await DBProvider.db.insertBulkCariAylikSatis(cariSatislar);
        cariSatislar.clear();

        List<CariHesapEkstresi> cariEkstres=<CariHesapEkstresi>[];
        var ekstres=jsonDecode(values[1]);
        (ekstres as List).map((item) {        
          cariEkstres.add(CariHesapEkstresi.fromJson(item));
        }).toList();
        await DBProvider.db.insertBulkCariHesapEkstresi(cariEkstres);
        cariEkstres.clear();

        List<CariVadeFarki> vadefarklari=<CariVadeFarki>[];
        var vadeFarks=jsonDecode(values[2]);
        (vadeFarks as List).map((item) {        
         vadefarklari.add(CariVadeFarki.fromJson(item));
        }).toList();
        await DBProvider.db.insertBulkCariVadeFarki(vadefarklari);       
        vadefarklari.clear();
      }
      return 1;
    } on DioError catch (e) {
      print(e.toString());
      snackbar("Hata",e.message, Icons.error);
      return null;
    }
    

  }

  getAllFiyatBSiparis() async {
    List<dynamic> values=<dynamic>[];

    var url = surl + "/SDRData/GetAllFiyatBSiparis";
    //url= "http://192.168.1.61:5001/SDRData/GetAllFiyatBSiparis";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');

    try {

      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': scari,
        "tarih":DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'token':DBProvider.getToken(),
        'email':DBProvider.getEmail()
      });

      
      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;          

      if (values!=null && values.length>0)
      {
        List<SatisFiyatlari> satisFiyatlar=<SatisFiyatlari>[];
        var satislar = jsonDecode(values[0]);
        (satislar as List).map((item) {        
          satisFiyatlar.add(SatisFiyatlari.fromJson(item));
        }).toList();
        await DBProvider.db.insertBulkSatisFiyatlari(satisFiyatlar);
        satisFiyatlar.clear();

        List<BekleyenSiparis> bekleyenSiparisler=<BekleyenSiparis>[];
        var siparisler=jsonDecode(values[1]);
        (siparisler as List).map((item) {        
          bekleyenSiparisler.add(BekleyenSiparis.fromJson(item));
        }).toList();
        await DBProvider.db.insertBulkBekleyenSiparis(bekleyenSiparisler);
        bekleyenSiparisler.clear();

        
      }
      return 1;
    } on DioError catch (e) {
      print(e.toString());
      snackbar("Hata",e.message, Icons.error);
      return null;
    }

  }

  Future<int> getAllBekleyenSiparis() async {
    List<dynamic> values=<dynamic>[];
    var url = surl + "/SDRData/GetAllBekleyenSiparis";
    //url= "http://192.168.1.61:5001/SDRData/GetAllBekleyenSiparis";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');

    try {
      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'token':DBProvider.getToken(),
        'email':DBProvider.getEmail()
      });
      
      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;

      var results = jsonDecode(values[0]);

      await DBProvider.db.deleteTable("AllBekleyenSiparis");

      List<BekleyenSiparis> bekleyenSiparisler=<BekleyenSiparis>[];
      (results as List).map((bekleyenSiparis) {
        bekleyenSiparisler.add(BekleyenSiparis.fromJson(bekleyenSiparis));
      }).toList();
      await DBProvider.db.insertBulkAllBekleyenSiparis(bekleyenSiparisler);
      bekleyenSiparisler.clear();
      //snackbar("Bilgi", "Bekleyen Sipariş Raporu Hazır.", Icons.person);
      
      return 1;
    } on DioError catch (e) {
      print(e.toString());
      snackbar("Hata",e.message, Icons.error);
      return null;
    }

  }

  getGunlukTahsilat() async{
    List<dynamic> values=<dynamic>[];

    var url = surl + "/SDRData/GetGunlukTahsilat";    
    //url= "http://192.168.1.61:5001/SDRData/GetGunlukTahsilat";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');

    try {      

      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': null,
        'token':DBProvider.getToken(),
        'email':DBProvider.getEmail()        
      });

      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;

      var results = jsonDecode(values[0]);

      await DBProvider.db.deleteTable("GunlukTahsilat");

      List<GunlukTahsilat> gunlukTahsilat=<GunlukTahsilat>[];
      (results as List).map((a) {
        gunlukTahsilat.add(GunlukTahsilat.fromJson(a));
      }).toList();

      await DBProvider.db.insertBulkGunlukTahsilat(gunlukTahsilat);
      gunlukTahsilat.clear();

      //snackbar("Bilgi", "Günlük Tahsilat Listesi Raporu Hazır.", Icons.person);

      return 1;
    } on DioError catch (e) {
      print(e.toString());
      snackbar("Hata",e.message, Icons.error);
      return null;
    }
  }

  getStokFiyatListesi() async {
    List<dynamic> values=<dynamic>[];
    var url = surl + "/SDRData/GetStokFiyatListesi";    
    //url= "http://192.168.1.61:5001/SDRData/GetStokFiyatListesi";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');

    try {      

      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': null,
        'token':DBProvider.getToken(),
        'email':DBProvider.getEmail()
      });     
      
      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;

      var results = jsonDecode(values[0]);

      await DBProvider.db.deleteTable("StokFiyatListesi"); 

      List<SatisFiyatlari> fiyatlar=<SatisFiyatlari>[];
      (results as List).map((a) {
        fiyatlar.add(SatisFiyatlari.fromJson(a));
      }).toList();

      await DBProvider.db.insertBulkRSatisFiyatlari(fiyatlar);
      fiyatlar.clear();

      snackbar("Bilgi", "Raporlar Hazır.", Icons.person);

      return 1;
    } on Exception catch (e) {
      print(e.toString());
      snackbar("Hata",'StokFiyatListesi Tablosuna insert edilemedi.' + e.toString().substring(0,255), Icons.error);
      return null;
    }

  }

  getGunlukSiparis() async{
    List<dynamic> values=<dynamic>[];

    var url = surl + "/SDRData/GetGunlukSiparis";    
    //url= "http://192.168.1.61:5001/SDRData/GetGunlukSiparis";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');

    try {      

      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': null,
        'token':DBProvider.getToken(),
        'email':DBProvider.getEmail()
      });
      
      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;

      var results = jsonDecode(values[0]);

      await DBProvider.db.deleteTable("GunlukSiparis"); 

      List<GunlukSiparis> gunlukSiparisler=<GunlukSiparis>[];
      (results as List).map((a) {
        gunlukSiparisler.add(GunlukSiparis.fromJson(a));
      }).toList();

      await DBProvider.db.insertBulkGunlukSiparis(gunlukSiparisler);
      gunlukSiparisler.clear();

      //snackbar("Bilgi", "Raporlar Hazır.", Icons.person);

      return 1;
    } on DioError catch (e) {
      print(e.toString());
      snackbar("Hata",e.message, Icons.error);
      return null;
    }
  }

  getAcikHesapListesi() async {
    List<dynamic> values=<dynamic>[];

    var url = surl + "/SDRData/GetAcikHesapListesi";    
    //url= "http://192.168.1.61:5001/SDRData/GetAcikHesapListesi";
    if (kdevTest==1) url=url=url.replaceAll('Client', 'Test');
    try {     

      Response response = await Dio().post(url, data: {
        'temsilci_kodu': stemsilci,
        'veritabani_adi': sveritabani,
        'cari_kod': null,
        'token':DBProvider.getToken(),
        'email':DBProvider.getEmail()        
      });

      ValidationResponseList vr=new ValidationResponseList(successful: true, code: "", result:<String>[], information: "");
      vr=ValidationResponseList.fromJson(response.data);
      if (vr.successful!=true)
      {
        snackbar("Hata", vr.information, Icons.error);
        return null;
      }
      
      if (vr.result!=null)         
          values=vr.result;

      var results = jsonDecode(values[0]);

      await DBProvider.db.deleteTable("AcikHesapListesi"); 
      List<AcikHesapListesi> acikHesap=<AcikHesapListesi>[];
      (results as List).map((a) {
        acikHesap.add(AcikHesapListesi.fromJson(a));        
      }).toList();

      await DBProvider.db.insertBulkAcikHesapListesi(acikHesap);
      acikHesap.clear();

      //snackbar("Bilgi", "Açık Hesap Listesi Raporu Hazır.", Icons.person);
    } on DioError catch (e) {
      print(e.toString());
      snackbar("Hata",e.message, Icons.error);

      return null;
    }

    


  }


}
