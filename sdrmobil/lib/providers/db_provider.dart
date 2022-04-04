import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
import 'package:sdrmobil/models/Kampanya/kampanya.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_bedelsiz_satir.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_bedelsiz_verilen.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_secimli_gruplar.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_yuzdesel_satir.dart';
import 'package:sdrmobil/models/Malzeme/grup_list.dart';
import 'package:sdrmobil/models/Malzeme/grup_list_all.dart';
import 'package:sdrmobil/models/Raporlar/acik_hesap_listesi.dart';
import 'package:sdrmobil/models/Raporlar/grup_bazinda_satislar.dart';
import 'package:sdrmobil/models/Raporlar/gunluk_tahsilat.dart';
import 'package:sdrmobil/models/Raporlar/musteri_mal_analizi.dart';
import 'package:sdrmobil/models/Raporlar/musteri_mal_analizi_ay.dart';
import 'package:sdrmobil/models/Raporlar/musteri_mal_analizi_mlzmus_toplam.dart';
import 'package:sdrmobil/models/Raporlar/musteri_toplamlari.dart';
import 'package:sdrmobil/models/Raporlar/rut_bazinda_cari.dart';
import 'package:sdrmobil/models/Satis/aylik_satis.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis_grup.dart';
import 'package:sdrmobil/models/Malzeme/birim_cevrimi.dart';
import 'package:sdrmobil/models/Cari/cari.dart';
import 'package:sdrmobil/models/Cari/cari_hesap_ekstresi.dart';
import 'package:sdrmobil/models/Cari/cari_hesap_ekstresi_toplam.dart';
import 'package:sdrmobil/models/Cari/cari_rut.dart';
import 'package:sdrmobil/models/Cari/cari_sube.dart';
import 'package:sdrmobil/models/Cari/cari_vade_farki.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis_gruplu.dart';
import 'package:sdrmobil/models/Siparis/gunluk_siparis.dart';
import 'package:sdrmobil/models/Siparis/siparis_indrim.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_gruplu.dart';
import 'package:sdrmobil/models/aktarim_durumu.dart';
import 'package:sdrmobil/models/grup_adi.dart';
import 'package:sdrmobil/models/Tahsilat/kasa_kod_value.dart';
import 'package:sdrmobil/models/Tahsilat/kasa.dart';
import 'package:sdrmobil/models/Malzeme/malzeme.dart';
import 'package:sdrmobil/models/Malzeme/malzeme_fiyat.dart';
import 'package:sdrmobil/models/Malzeme/malzeme_picture.dart';
import 'package:sdrmobil/models/Satis/satis_fiyatlari.dart';
import 'package:sdrmobil/models/Satis/satis_tipi.dart';
import 'package:sdrmobil/models/Siparis/siparis.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_list.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_toplam.dart';
import 'package:sdrmobil/models/Tahsilat/tahsilat_sayisi.dart';
import 'package:sdrmobil/models/validation_response.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret.dart';
import 'package:sdrmobil/models/Satis/rut_listesi.dart';
import 'package:sdrmobil/models/Satis/satis_chart.dart';
import 'package:sdrmobil/models/Tahsilat/tahsilat.dart';
import 'package:sdrmobil/models/tanimlar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret_sonlandirma_tipleri.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret_tipleri.dart';
import 'package:sdrmobil/providers/db_table_create.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';


class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  static String getToken() {
    final Controller _controller =Get.find();
    return _controller.token.value;
  }
  static String getEmail() {
    final Controller _controller =Get.find();
    return _controller.email.value;
  }

  static deleteDatabases() async {    
    Directory documentsDirectory;
    try {
      documentsDirectory= Platform.isAndroid ? 
        await getExternalStorageDirectory():
        await getApplicationSupportDirectory();      
    } catch (e) {
      print(e.toString());
    }
    
    final path = join(documentsDirectory.path, 'SDR.db');
    await deleteDatabase(path);
  }
  

  Future<Database> get database async {
    final Controller _controller = Get.find();
    // If database exists, return database
    if (_controller.deleteDatabase.value!=1)
    {if (_database != null) return _database;}

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    final Controller _controller =Get.find();
    Directory documentsDirectory;
    try {
      documentsDirectory= Platform.isAndroid ? 
        await getExternalStorageDirectory():
        await getApplicationSupportDirectory();      
    } catch (e) {
      print(e.toString());
    }

    final path = join(documentsDirectory.path, 'SDR.db');

    if (_controller.deleteDatabase.value==1)
    {      
      _controller.deleteDatabase.value=0;
      _controller.veritabaniSilindi.value=1;
      await deleteDatabase(path);      
    }

    //await deleteDatabase(path);
        
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _createdb);
  }

  void _createdb(Database db, int versiyon) async {

    await TableCreate().createtable0(db, versiyon);

    await TableCreate().createtable1(db, versiyon);

    await TableCreate().createtable2(db, versiyon);

    await TableCreate().createtable3(db, versiyon);

    await TableCreate().createtable4(db, versiyon);

    await TableCreate().createtable5(db, versiyon);

    await TableCreate().createtable6(db, versiyon);

    await TableCreate().createtable7(db, versiyon);

    await db.close();
  }

  // Delete table
  Future<int> deleteTable(String tablename) async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM  ' + tablename);

    return res;
  }

  Future<int> deleteFrom(String sql) async {
    final db = await database;
    final res = await db.rawDelete(sql);

    return res;
  }


  // Insert tanimlar on database
  insertTanimlar(Tanimlar newTanimlar) async {
    final db = await database;
    final res = await db.insert('Tanimlar', newTanimlar.toJson());
    return res;
  }

  // Insert kasa on database
  insertKasa(Kasa newKasa) async {
    final db = await database;
    final res = await db.insert('Kasa', newKasa.toJson());
    return res;
  }

  // Insert carisube on database
  bulkInsertCariSube(List<CariSube> newCariSube) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (CariSube item in newCariSube) {
        batch.insert('CariSube', item.toJson());
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'CariSube Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
      return;
    }   
  }

  bulkInsertCariRut(List<CariRut> newCariRut) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (CariRut item in newCariRut) {
        batch.insert('CariRut', item.toJson());
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());      
      snackbar("Hata",'CariRut Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
    }   
  }

  insertCariSube(CariSube newCariSube) async {
    final db = await database;
    final res = await db.insert('CariSube', newCariSube.toJson());
    return res;
  }

  // Insert carirut on database
  insertCariRut(CariRut newCarirut) async {
    final db = await database;
    final res = await db.insert('CariRut', newCarirut.toJson());
    return res;
  }

// Insert aylikSatis on database
  insertCariAylikSatis(CariAylikSatis newAylikSatis) async {
    try {
      final db = await database;
      final res = await db.insert('CariAylikSatis', newAylikSatis.toJson());
      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'CariAylikSatis Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
    }
  }

  // Insert hesapekstresi on database
  insertCariHesapEkstre(CariHesapEkstresi newHesapEkstre) async {
    try {
      final db = await database;
      final res = await db.insert('CariHesapEkstresi', newHesapEkstre.toJson());

      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'CariHesapEkstresi Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
    }
  }

  // Insert vadefarki on database
  insertCariVadeFarki(CariVadeFarki newCariVadeFarki) async {
    try {
      final db = await database;
      final res = await db.insert('CariVadeFarki', newCariVadeFarki.toJson());
      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'CariVadeFarki Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
    }
  }

  insertZiyaretTipleri(ZiyaretTipleri newZiyaretTipleri) async {
    try {
      final db = await database;
      final res = await db.insert('ZiyaretTipleri', newZiyaretTipleri.toJson());
      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'ZiyaretTipleri Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
    }
  }
  insertZiyaretSonlandirmaTipleri(ZiyaretSonlandirmaTipleri newZiyaretSonlandirmaTipleri) async {
    try {
      final db = await database;
      final res = await db.insert('ZiyaretSonlandirmaTipleri', newZiyaretSonlandirmaTipleri.toJson());
      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'ZiyaretSonlandirmaTipleri Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
    }
  }

  // Insert cari on database
  insertCari(Cari newCari) async {
    final db = await database;
    print(newCari);

    try {
      print(newCari.toJson());
      final res = await db.insert('Cari', newCari.toJson());
      return res;
    } catch (e) {
      print(newCari.toJson());
      print(e.toString());
      snackbar("Hata",'Cari Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);

    }
  }

  Future<List<Tanimlar>> getAllTanimlar() async {
    final db = await database;
    try {
      final res = await db.rawQuery("SELECT * FROM Tanimlar");
      List<Tanimlar> list =
          res.isNotEmpty ? res.map((c) => Tanimlar.fromJson(c)).toList() : [];

      int rutIcigidilen=0;
      Tanimlar oRutIcigidilen=list.firstWhere((rig) =>
                      rig.groupname == "TemsilciHareketleri" &&
                      rig.key == "rutIcigidilen");

      rutIcigidilen=int.parse(oRutIcigidilen.value);
      rutIcigidilen+=await getRutIciZiyaretSayisi();

      // oRutIcigidilen.value=rutIcigidilen.toString();
      int index = list.indexOf(oRutIcigidilen);
      list[index].value=rutIcigidilen.toString();



      int rutDisigidilen=0;
      Tanimlar oRutDisigidilen=list.firstWhere((rig) =>
                      rig.groupname == "TemsilciHareketleri" &&
                      rig.key == "rutDisigidilen");

      rutDisigidilen=int.parse(oRutDisigidilen.value);
      rutDisigidilen+=await getRutDisiZiyaretSayisi();

      index=0;
      index = list.indexOf(oRutDisigidilen);    
      if (index>0) list[index].value=rutDisigidilen.toString();
      
      return list;
      
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Tanimlar Tablosu alınamadı.' + e.toString().substring(0,100), Icons.error);
      return [];

    }

    
  }       

  Future<List<RutListesi>> getGunRutListesi() async {
    final db = await database;

    var tarih=DateFormat('yyyy-MM-dd').format(DateTime.now());    

    final res = await db.rawQuery(
        "SELECT a.rutDetaySayac,a.gun_sira,a.rut_sira_no,b.enlem,b.boylam,a.aktif,b.gunlukSiparisTutar,b.gunlukFaturaTutar,"
        "b.gunlukTahsilatTutar,a.gun,b.kod,b.unvan,b.tl_borc,b.tl_alacak,b.tl_abakiye,b.tl_bbakiye," +
        "(SELECT Count(Distinct t.cari_kodu) FROM Ziyaret t Where t.cari_kodu=a.kod and t.uzak_siparis=0 and strftime('%Y-%m-%d',t.start_date)=?) as ziyaret_sayisi "+
        "FROM CariRut a,Cari b WHERE b.kod=a.kod ", [tarih]);

    List<RutListesi> list =
        res.isNotEmpty ? res.map((c) => RutListesi.fromJson(c)).toList() : [];
        
    if (list.length>0)
    {
      List<Siparis> siparisler=await DBProvider.db.getSiparisTumList();
      List<Tahsilat> tahsilatlar=await DBProvider.db.getAllTahsilat();
      if (siparisler.length>0 || tahsilatlar.length>0)
      {
        list.forEach((element) {
          if (siparisler.length>0)
          {
            siparisler.forEach((sipItem) { 
              if (element.kod==sipItem.musterino)
              {
                if (sipItem.aciklama!=null)
                {
                  if (sipItem.aciklama!="Yazildi")
                  {
                    element.gunlukSiparisTutar=element.gunlukSiparisTutar + sipItem.toplamtutar;
                    sipItem.aciklama="Yazildi";
                  }
                }
                else {element.gunlukSiparisTutar=element.gunlukSiparisTutar + sipItem.toplamtutar;sipItem.aciklama="Yazildi";}
              }              
            });
          }

          if (tahsilatlar.length>0)
          {
            tahsilatlar.forEach((tahItem) { 

              if (element.kod==tahItem.carikodu)            
              {
                if (tahItem.aciklama!=null)
                {
                  if (tahItem.aciklama!="Yazildi")
                  {
                    element.gunlukTahsilatTutar=element.gunlukTahsilatTutar + tahItem.fiyat;
                    tahItem.aciklama="Yazildi";
                  }
                }
                else {element.gunlukTahsilatTutar=element.gunlukTahsilatTutar + tahItem.fiyat; tahItem.aciklama="Yazildi";}

              }
              
            });
          }        

        });
      }      
    }


    return list;
  }

  Future<List<RutBazindaCari>> getRutCariListesi() async {
    final db = await database;

      final res = await db.rawQuery(
        "SELECT Distinct b.kod,b.unvan,a.gun FROM CariRut a,Cari b WHERE b.kod=a.kod Order By b.unvan ");

    List<RutBazindaCari> list =
        res.isNotEmpty ? res.map((c) => RutBazindaCari.fromJson(c)).toList() : [];

    return list;
  }


  Future<int> getZiyaretSayac(String ziyaretTipiRutIci, String ziyaretTipiRutdisi, int rutDetaySayac) async {
    Controller _controller = Get.find();
    int ziyaretTipiSayac=0;

    final db = await database;
    if (_controller.uzaksiparis.value!=1 && _controller.musteriKarti.value!=1)
    {
      final res = await db.rawQuery(
        "Select a.r_sayac from ZiyaretTipleri a Where a.tipi=? " +
        "And Exists(Select b.kod from CariRut b Where b.bugun=1 And b.rutDetaySayac=?)", [ziyaretTipiRutIci, rutDetaySayac]);

      ziyaretTipiSayac = res.isNotEmpty ? res.first['r_sayac']:0;
      if (ziyaretTipiSayac==0)
      {
        final res = await db.rawQuery(
          "Select a.r_sayac from ZiyaretTipleri a Where a.tipi=? " +
          "And not Exists(Select b.kod from CariRut b Where b.bugun=1 And b.rutDetaySayac=?)", [ziyaretTipiRutdisi, rutDetaySayac]);

        ziyaretTipiSayac = res.isNotEmpty ? res.first['r_sayac']:0;
      }
    }
    else
    {
       final res = await db.rawQuery(
        "Select a.r_sayac from ZiyaretTipleri a Where a.tipi=? " +
        "And Exists(Select b.kod from CariRut b Where b.bugun=1 And b.rutDetaySayac=?)", ["Telefon Rut İçi", rutDetaySayac]);

      ziyaretTipiSayac = res.isNotEmpty ? res.first['r_sayac']:0;
      if (ziyaretTipiSayac==0)
      {
        final res = await db.rawQuery(
          "Select a.r_sayac from ZiyaretTipleri a Where a.tipi=? " +
          "And not Exists(Select b.kod from CariRut b Where b.bugun=1 And b.rutDetaySayac=?)", ["Telefon Rut Dışı", rutDetaySayac]);

        ziyaretTipiSayac = res.isNotEmpty ? res.first['r_sayac']:0;
      }
    }
        
    return ziyaretTipiSayac;
  }


  Future<List<Cari>> getAllCari() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Cari");
    List<Cari> list =
        res.isNotEmpty ? res.map((c) => Cari.fromJson(c)).toList() : [];

    return list;
  }
  Future<List<CariSube>> getCariSube(String carikod) async {
    final db = await database;
    final res = await db.rawQuery("SELECT a.* FROM CariSube a, Cari b Where a.cari_sayac=b.r_sayac And b.kod=?", [carikod]);
    List<CariSube> list =
        res.isNotEmpty ? res.map((c) => CariSube.fromJson(c)).toList() : [];
        
    return list;
  }

  Future<List<CariSube>> getAllCariSube() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM CariSube");
    List<CariSube> list =
        res.isNotEmpty ? res.map((c) => CariSube.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<CariRut>> getAllCariRut() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM CariRut");
    List<CariRut> list =
        res.isNotEmpty ? res.map((c) => CariRut.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Kasa>> getAllKasa() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Kasa");
    List<Kasa> list =
        res.isNotEmpty ? res.map((c) => Kasa.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<RutListesi>> getRutListesi(String gun) async {
    final db = await database;
    String sqlquery =
        "SELECT a.*,b.unvan,ROUND(b.tl_borc) as tl_borc,ROUND(b.tl_alacak) as tl_alacak,";
    sqlquery = sqlquery +
        "b.tl_abakiye,b.tl_bbakiye, ROUND(Abs(b.tl_borc - b.tl_alacak),2) as bakiye,Abs(b.tl_borc - b.tl_alacak),";
    sqlquery = sqlquery +
        "(CASE When b.tl_borc - b.tl_alacak>0 Then 'B' Else 'A' END) as bakiye_tur ";
    sqlquery =
        sqlquery + "FROM CariRut a,Cari b WHERE b.kod=a.kod And a.gun=? ";

    final res = await db.rawQuery(sqlquery, [gun]);

    List<RutListesi> list =
        res.isNotEmpty ? res.map((c) => RutListesi.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<CariRut>> getRutGunListesi() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT distinct a.gun_sira, a.gun FROM CariRut a Order By a.gun_sira");
    List<CariRut> list =
        res.isNotEmpty ? res.map((c) => CariRut.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<CariRut>> getRutGunler() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT  a.gun ,a.gun_sira ,Sum(aktif) aktifnoktasayisi,Max(bugun) as bugun FROM CariRut a GROUP BY a.gun,a.gun_sira ORDER BY a.gun_sira asc ");
    List<CariRut> list =
        res.isNotEmpty ? res.map((c) => CariRut.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<SatisChart>>  getChartSatis() async {
    final db = await database;
    final res = await db.rawQuery("select a.kod, substr(a.unvan,1,14) as unvan,round(SUM(gunlukSiparisTutar),2) as gunlukSiparisTutar, " +
      "round(SUM(gunlukFaturaTutar),2) as gunlukFaturaTutar ,round(SUM(gunlukTahsilatTutar),2) as gunlukTahsilatTutar " + 
      "from Cari a group by a.unvan, a.kod Having (SUM(gunlukSiparisTutar) + SUM(gunlukTahsilatTutar) + SUM(gunlukFaturaTutar))>0");
      
    List<SatisChart> list =
        res.isNotEmpty ? res.map((c) => SatisChart.fromJson(c)).toList() : [];

      List<Siparis> siparisler=await DBProvider.db.getSiparisTumList();
      List<Tahsilat> tahsilatlar=await DBProvider.db.getAllTahsilat();
      if (siparisler.length>0 || tahsilatlar.length>0)
      {        
          if (siparisler.length>0)
          {            
            siparisler.forEach((sipItem) {
              bool bBulundu=false;
              if (list.length>0)
              {
                list.forEach((element) {
                  if (element.kod==sipItem.musterino)
                  {
                    element.gunlukSiparisTutar=element.gunlukSiparisTutar + sipItem.toplamtutar;
                    bBulundu=true;
                  }
                });
              }

              if (!bBulundu)
              {
                SatisChart satisChart=SatisChart(gunlukFaturaTutar: 0, 
                                    gunlukSiparisTutar: sipItem.toplamtutar, 
                                    gunlukTahsilatTutar: 0,
                                    kod: sipItem.musterino,
                                    unvan: sipItem.unvan);
                list.add(satisChart);
              }

            });
          }

          if (tahsilatlar.length>0)
          {
            tahsilatlar.forEach((tahItem) {
              bool bBulundu=false;

              if (list.length>0)
              {
                list.forEach((element) {
                  if (element.kod==tahItem.carikodu)            
                  {
                    element.gunlukTahsilatTutar=element.gunlukTahsilatTutar + tahItem.fiyat;
                    bBulundu=true;                    
                  }                  
                });
              }
              if (!bBulundu)
              {
                SatisChart satisChart=SatisChart(gunlukFaturaTutar: 0, 
                                    gunlukSiparisTutar: 0, 
                                    gunlukTahsilatTutar: tahItem.fiyat,
                                    kod: tahItem.carikodu,
                                    unvan: tahItem.unvan);
                list.add(satisChart);
              }

            });
          }

      }      
    
    

    return list;
  }

  Future<List<CariHesapEkstresi>> getCariHesapEkstresi() async {
    final Controller mainController =Get.find();

    final db = await database;
    final res = await db.rawQuery("Select * from CariHesapEkstresi Where cari_kodu=?", [mainController.carikod.value]);
    List<CariHesapEkstresi> list =
        res.isNotEmpty ? res.map((c) => CariHesapEkstresi.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<CariHesapEkstresiToplam>> getCariHesapEkstresiToplam() async {
    final Controller mainController =Get.find();
    final db = await database;
    final res = await db.rawQuery("Select Sum(IFNULL(borc,0)) as toplamBorc, Sum(IFNULL(alacak,0)) as toplamAlacak from CariHesapEkstresi Where cari_kodu=?", [mainController.carikod.value]);
    List<CariHesapEkstresiToplam> list =
        res.isNotEmpty ? res.map((c) => CariHesapEkstresiToplam.fromJson(c)).toList() : [];

    return list;
  } 


  Future<List<CariAylikSatis>> getCariSatislar() async {
    final Controller mainController =Get.find();

    final db = await database;
    final res = await db.rawQuery(
        "Select Max(id) as id, Max(ay_str) ay_str,malzeme_kodu, malzeme_adi,Max(dist_stok_kodu) as dist_stok_kodu,"+ 
        "Max(ay) as ay, Sum(ciro) as ciro,Sum(miktar) as miktar, Max(birim) as birim,Max(malzeme_sinifi_id) as malzeme_sinifi_id,"+ 
        "Max(malzeme_sinifi_adi) as malzeme_sinifi_adi,Max(path) as path from CariAylikSatis Where cari_kodu=? "+
        "Group By malzeme_kodu, malzeme_adi", [mainController.carikod.value]);

    List<CariAylikSatis> list =
        res.isNotEmpty ? res.map((c) => CariAylikSatis.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<CariAylikSatis>> getCariAylikSatis(String malzemekodu) async {
    final Controller mainController =Get.find();
    final db = await database;
    final res = await db.rawQuery(
        "Select Max(id) as id, Max(ay_str) ay_str,malzeme_kodu, malzeme_adi,Max(dist_stok_kodu) as dist_stok_kodu,"+ 
        "ay, Sum(ciro) as ciro,Sum(miktar) as miktar,Max(birim) as birim,Max(malzeme_sinifi_id) as malzeme_sinifi_id,"+
        "Max(malzeme_sinifi_adi) as malzeme_sinifi_adi,Max(path) as path "+ 
        "from CariAylikSatis Where malzeme_kodu=? And cari_kodu=? Group By malzeme_kodu, malzeme_adi, ay ", [malzemekodu, mainController.carikod.value]);

    List<CariAylikSatis> list =
        res.isNotEmpty ? res.map((c) => CariAylikSatis.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<CariVadeFarki>> getCariVadeFarki() async {
    final Controller mainController =Get.find();

    final db = await database;
    final res = await db.rawQuery("select * from CariVadeFarki Where cari_kodu=?",  [mainController.carikod.value]);
    List<CariVadeFarki> list =
        res.isNotEmpty ? res.map((c) => CariVadeFarki.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<MalzemePicture>> getMalzemePicture() async {
    final db = await database;

    await db.rawQuery("Delete FROM MalzemePicture");
    
    final res = await db.rawQuery("SELECT distinct a.path, a.malzeme_kodu FROM Malzeme a "+
      " Where not Exists(Select t.path FROM MalzemePicture t Where t.picture is null And t.malzeme_kodu=a.malzeme_kodu) ");

    List<MalzemePicture> list =
        res.isNotEmpty ? res.map((c) => MalzemePicture.fromMap(c)).toList() : [];

    try 
    {
      

      list.forEach((element) async {
      //await Future.forEach(list, (MalzemePicture element) async{

        Uint8List bytes;
        
        if (element.path!=null && element.path!="")
        {
          try {
            bytes = (await NetworkAssetBundle(Uri.parse(element.path))
            .load(element.path))
            .buffer
            .asUint8List();  
            MalzemePicture picture=new MalzemePicture(malzemekodu: element.malzemekodu, path: element.path, picture:bytes);
            DBProvider.db.insertMalzemePicture(picture);
          } catch (e) {
            MalzemePicture picture=new MalzemePicture(malzemekodu: element.malzemekodu, path: element.path);
            DBProvider.db.insertMalzemePicture(picture);
          }
        }
        else
        {
          MalzemePicture picture=new MalzemePicture(malzemekodu: element.malzemekodu, path: element.path);
          DBProvider.db.insertMalzemePicture(picture);
        }

      });
    } 
    on Exception catch (e) 
    {
      print(e.toString());
      snackbar("Hata",'MalzemePicture Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
      return null;
    }
    
    return list;

  }


  Future<List<MalzemeFiyat>> getRStokFiyatListesi() async {    
    RaporController _controller = Get.find();

    final db = await database;

    String sql="SELECT b.malzeme_kodu, b.malzeme_adi, b.grup_adi1, b.grup_adi2, b.grup_adi3,"+
      "Case b.fiyat1 When 1 Then b.fiyat_tutar1 Else Case b.fiyat2 When 1 Then b.fiyat_tutar2 Else " +
      "Case b.fiyat3 When 1 Then b.fiyat_tutar3 Else Case b.fiyat4 When 1 Then b.fiyat_tutar4 Else "+
      "Case b.fiyat5 When 1 Then b.fiyat_tutar5 Else 0.0 END END END END END as birim_fiyat,"+
      "b.indirim01_flag, b.iskonto_tutari1, b.indirim02_flag, b.iskonto_tutari2, b.indirim03_flag, b.iskonto_tutari3,"+
      "b.indirim04_flag, b.iskonto_tutari4, b.indirim05_flag, b.iskonto_tutari5, b.indirim06_flag, b.iskonto_tutari6,"+
      "Case b.vade1 When 1 Then b.vade_kodu1 Else Case b.vade2 When 1 Then b.vade_kodu2 Else "+
      "Case b.vade3 When 1 Then b.vade_kodu3 Else Case b.vade4 When 1 Then b.vade_kodu4 Else "+
      "Case b.vade5 When 1 Then b.vade_kodu5 Else '' END END END END END as vade_kodu, b.kdv_orani, b.liste_birim as baz_birim,"+
      "(Select c.picture from MalzemePicture c Where c.malzeme_kodu=b.malzeme_kodu LIMIT 1) as picture,b.barkod,b.stok_miktari,"+
      "(Select c.path from Malzeme c Where c.malzeme_kodu=b.malzeme_kodu LIMIT 1) as path " +
      "FROM StokFiyatListesi b Where 1=1 ";
      
    if (_controller.mgrup1.value!="TÜMÜ")
    {
      sql=sql + "And b.grup_adi1='"+_controller.mgrup1.value + "' ";
    }
    if (_controller.mgrup2.value!="TÜMÜ")
    {
      sql=sql + "And b.grup_adi2='"+_controller.mgrup2.value + "' ";
    }
    if (_controller.mgrup3.value!="TÜMÜ")
    {
      sql=sql + "And b.grup_adi3='"+_controller.mgrup3.value + "' ";
    }
    sql=sql + " Order By b.malzeme_adi ";    

    final res = await db.rawQuery(sql);
    List<MalzemeFiyat> list =
        res.isNotEmpty ? res.map((c) => MalzemeFiyat.fromJson(c)).toList() : [];

    return list;
  }


  Future<List<MalzemeFiyat>> getStokFiyatListesi(String satisTipikodu) async {   
    final Controller mainController=Get.find();

    final db = await database;

    final res = await db.rawQuery("SELECT b.malzeme_kodu, b.malzeme_adi, b.grup_adi1, b.grup_adi2, b.grup_adi3,"+
      "Case b.fiyat1 When 1 Then b.fiyat_tutar1 - ((b.kdvli_fiyat1 * b.fiyat_tutar1 * a.kdv_orani)/(100.00+a.kdv_orani)) " +
      "Else Case b.fiyat2 When 1 Then b.fiyat_tutar2 - ((b.kdvli_fiyat2 * b.fiyat_tutar2 * b.kdv_orani)/(100.00+b.kdv_orani)) " +      
      "Else Case b.fiyat3 When 1 Then b.fiyat_tutar3 - ((b.kdvli_fiyat3 * b.fiyat_tutar3 * b.kdv_orani)/(100.00+b.kdv_orani)) "+
      "Else Case b.fiyat4 When 1 Then b.fiyat_tutar4 - ((b.kdvli_fiyat4 * b.fiyat_tutar4 * b.kdv_orani)/(100.00+b.kdv_orani)) "+
      "Else Case b.fiyat5 When 1 Then b.fiyat_tutar5 - ((b.kdvli_fiyat5 * b.fiyat_tutar5 * b.kdv_orani)/(100.00+b.kdv_orani)) "+
      "Else 0.0 END END END END END as birim_fiyat,"+      
      "b.indirim01_flag, b.iskonto_tutari1, b.indirim02_flag, b.iskonto_tutari2, b.indirim03_flag, b.iskonto_tutari3,"+
      "b.indirim04_flag, b.iskonto_tutari4, b.indirim05_flag, b.iskonto_tutari5, b.indirim06_flag, b.iskonto_tutari6,"+
      "Case b.vade1 When 1 Then b.vade_kodu1 Else Case b.vade2 When 1 Then b.vade_kodu2 Else "+
      "Case b.vade3 When 1 Then b.vade_kodu3 Else Case b.vade4 When 1 Then b.vade_kodu4 Else "+
      "Case b.vade5 When 1 Then b.vade_kodu5 Else '' END END END END END as vade_kodu, b.kdv_orani, b.liste_birim as baz_birim,"+
      "(Select c.picture from MalzemePicture c Where c.malzeme_kodu=b.malzeme_kodu LIMIT 1) as picture,b.barkod,b.stok_miktari,"
      "(Select c.path from Malzeme c Where c.malzeme_kodu=b.malzeme_kodu LIMIT 1) as path "
      "FROM SatisFiyatlari b Where b.satis_tipi=? And b.kod=?  "+    
      "Order By b.malzeme_adi ", [satisTipikodu, mainController.carikod.value]);

    List<MalzemeFiyat> list =
        res.isNotEmpty ? res.map((c) => MalzemeFiyat.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<MalzemeFiyat>> getMalzemeList() async {
    final SiparisController _controller =Get.find();
    final Controller mainController =Get.find();
    final db = await database;

    String sql="SELECT b.malzeme_kodu, b.malzeme_adi, b.grup_adi1, b.grup_adi2, b.grup_adi3,"+
      "Case b.fiyat1 When 1 Then b.fiyat_tutar1 - ((b.kdvli_fiyat1 * b.fiyat_tutar1 * a.kdv_orani)/(100.00+a.kdv_orani)) " +
      "Else Case b.fiyat2 When 1 Then b.fiyat_tutar2 - ((b.kdvli_fiyat2 * b.fiyat_tutar2 * a.kdv_orani)/(100.00+a.kdv_orani)) " +      
      "Else Case b.fiyat3 When 1 Then b.fiyat_tutar3 - ((b.kdvli_fiyat3 * b.fiyat_tutar3 * a.kdv_orani)/(100.00+a.kdv_orani)) "+
      "Else Case b.fiyat4 When 1 Then b.fiyat_tutar4 - ((b.kdvli_fiyat4 * b.fiyat_tutar4 * a.kdv_orani)/(100.00+a.kdv_orani)) "+
      "Else Case b.fiyat5 When 1 Then b.fiyat_tutar5 - ((b.kdvli_fiyat5 * b.fiyat_tutar5 * a.kdv_orani)/(100.00+a.kdv_orani)) "+
      "Else 0.0 END END END END END as birim_fiyat,"+      
      "b.indirim01_flag, b.iskonto_tutari1, b.indirim02_flag, b.iskonto_tutari2, b.indirim03_flag, b.iskonto_tutari3,"+
      "b.indirim04_flag, b.iskonto_tutari4, b.indirim05_flag, b.iskonto_tutari5, b.indirim06_flag, b.iskonto_tutari6,"+
      "Case b.vade1 When 1 Then b.vade_kodu1 Else Case b.vade2 When 1 Then b.vade_kodu2 Else "+
      "Case b.vade3 When 1 Then b.vade_kodu3 Else Case b.vade4 When 1 Then b.vade_kodu4 Else "+
      "Case b.vade5 When 1 Then b.vade_kodu5 Else '' END END END END END as vade_kodu, b.kdv_orani, b.liste_birim as baz_birim,"+
      "(Select c.picture from MalzemePicture c Where c.malzeme_kodu=b.malzeme_kodu LIMIT 1) as picture,b.barkod,b.stok_miktari,"+
      "(Select t.r_sayac from SiparisSatir t Where t.mus_rsayac=? And t.malzeme_kodu=b.malzeme_kodu LIMIT 1) as siparis_satir_rsayac,"+
      "IFNULL((Select CAST(IFNULL(t.value,'0') as INT ) from tanimlar t Where t.key='cift_kayit'),0) as cift_kayit, "+
      "(Select c.path from Malzeme c Where c.malzeme_kodu=b.malzeme_kodu LIMIT 1) as path " + 
      "FROM SatisFiyatlari b INNER JOIN Malzeme a ON a.malzeme_kodu=b.malzeme_kodu Where b.satis_tipi=? And b.kod=? ";

      if (mainController.sifirStokGosterme.value==1)
      {
        sql= sql +" And IFNULL(b.stok_miktari,0)>0 ";  
      }
      sql= sql +"Order By b.malzeme_adi ";
      
    final res = await db.rawQuery(sql, [_controller.siparissayac.value, _controller.satisTipikodu.value, mainController.carikod.value]);

    List<MalzemeFiyat> list =
        res.isNotEmpty ? res.map((c) => MalzemeFiyat.fromJson(c)).toList() : [];

    return list;
  } 

  Future<List<GrupAdi>> getMalzemeGrup() async {
    final SiparisController _controller =Get.find();
    String grupadi="";

    if (_controller.grupkullan.value==1) grupadi="grup_adi1";
    if (_controller.grupkullan.value==2) grupadi="grup_adi2";
    if (_controller.grupkullan.value==3) grupadi="grup_adi3";

    List<GrupAdi> list=<GrupAdi>[];   

    if (grupadi!="" && grupadi!=null)
    {
      //unutma LIMIT 1 kalkacak
      final db = await database;
      final res = await db.rawQuery("select Distinct Case When ifnull($grupadi,'')='' Then 'BOŞ' Else $grupadi End as grupadi "+
      "from Malzeme Order By Case When ifnull($grupadi,'')='' Then 'BOŞ' Else $grupadi End ");

      list = res.isNotEmpty ? res.map((c) => GrupAdi.fromJson(c)).toList() : [];
    }
    else
    {
      GrupAdi grupadi=GrupAdi(grupadi: "Malzemeler");
      list.add(grupadi);
    }

    return list;
  }


  Future<List<KasaKodValue>> getKasa(int krediKartiKasasi) async {
    final db = await database;

    final res = 
    (krediKartiKasasi==1)? 
      await db.rawQuery("SELECT kod, sorumlu FROM Kasa Where kredi_karti_kasasi=1"):
      await db.rawQuery("SELECT kod, sorumlu FROM Kasa Where kredi_karti_kasasi=0");

    List<KasaKodValue> list =
        res.isNotEmpty ? res.map((c) => KasaKodValue.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<SatisTipi>> getSatisTipi() async {
    final db = await database;

    final res =     
      await db.rawQuery("SELECT * FROM SatisTipleri");

    List<SatisTipi> list =
        res.isNotEmpty ? res.map((c) => SatisTipi.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Tahsilat>> getTahsilat(String carikodu) async {
    final db = await database;
    final res = await db.rawQuery("SELECT a.*,c.unvan FROM Tahsilat a, Cari c Where a.cari_kodu=c.kod And a.cari_kodu=? Order By a.r_sayac desc", [carikodu]);
    List<Tahsilat> list =
        res.isNotEmpty ? res.map((c) => Tahsilat.fromJson(c)).toList() : [];

    return list;
  }


  Future<int> getTahsilatCount() async {
    final db = await database;
    final res = await db.rawQuery("SELECT count(a.r_sayac) as kayit_sayisi FROM Tahsilat a,Ziyaret b Where a.android_gps_sayac=b.id ");

    var dbItem = res.first;
    int kayitsayisi = dbItem==null ? 0: dbItem['kayit_sayisi'] as int;
    kayitsayisi=kayitsayisi==null ? 0:kayitsayisi;

    return kayitsayisi;
  }


  Future<List<Tahsilat>> getAllTahsilat() async {
    final db = await database;
    final res = await db.rawQuery("SELECT distinct a.*,c.unvan FROM Tahsilat a,Ziyaret b,Cari c Where a.cari_kodu=c.kod And a.android_gps_sayac=b.id ");
    List<Tahsilat> list =
        res.isNotEmpty ? res.map((c) => Tahsilat.fromJson(c)).toList() : [];
        
    return list;
  }

  Future<TahsilatSayisi> getToplamTahsilat() async {
    
    final db = await database;
    TahsilatSayisi bos=TahsilatSayisi(tahsilat: 0, rutici: 0, rutdisi: 0);
    TahsilatSayisi result;

    var tarih=DateFormat('yyyy-MM-dd').format(DateTime.now());    
    final res = await db.rawQuery("Select (SELECT Count(a.fiyat) "+  
          "FROM Tahsilat a,Ziyaret b Where a.android_gps_sayac=b.id) as tahsilat," +
          "(SELECT Count(Distinct a.cari_kodu) FROM Ziyaret a Where not (STRFTIME('%w', a.start_date)=a.rut_detay_gun) And strftime('%Y-%m-%d',a.start_date)=?) as rut_disi," +
          "(SELECT Count(Distinct a.cari_kodu) FROM Ziyaret a Where STRFTIME('%w', a.start_date)=a.rut_detay_gun And strftime('%Y-%m-%d',a.start_date)=?) as rut_ici,"+
          "(SELECT Max(a.aktarim_tarihi) FROM AktarimDurumu a) as aktarim_tarihi ", [tarih, tarih]);

      result =res.isNotEmpty ? res.map((c) => TahsilatSayisi.fromJson(c)).first : bos;
        
    return result;
  }


  Future<List<Ziyaret>> getAllZiyaret() async {
    try {
      final db = await database;
      final res = await db.rawQuery("Select * from Ziyaret a Where a.is_ziyaret_active=0 And IFNULL(a.aktarildi,0)=0");
      List<Ziyaret> list =
          res.isNotEmpty ? res.map((c) => Ziyaret.fromJson(c)).toList() : [];

      return list;  
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Ziyaret tablosu okunamadı.' + e.toString().substring(0,100), Icons.error);
      return null;
    }

  }
  
  Future<ValidationResponse> deleteAllZiyaret() async {
    ValidationResponse vr=ValidationResponse(successful: true, information: "");
    final db = await database;    
    try 
      { 
        var tarih=DateFormat('yyyy-MM-dd').format(DateTime.now());
        // await db.rawQuery("Update Ziyaret Set is_ziyaret_active=2 from Ziyaret Where is_ziyaret_active=0 And strftime('%Y-%m-%d',a.start_date)=? ", [tarih]);

        await db.rawQuery("Delete FROM Ziyaret Where strftime('%Y-%m-%d',start_date)<>?", [tarih]);
      } 
    catch (e) 
      {        
        vr.successful=false;
        vr.information=e.toString();
      } 
    return vr;
  }

  Future<ValidationResponse> deleteAllTahsilat() async {
    ValidationResponse vr=ValidationResponse(successful: true, information: "Silme işlemi başarılı");
    final db = await database;
    try 
      {
        await db.rawQuery("Delete FROM Tahsilat");            
      } 
    catch (e) 
      {
        vr.successful=false;
        vr.information=e.toString();
      } 
    return vr;
  }

  Future<String> deleteTahsilat(int rsayac) async {
    String result="";
    final db = await database;    
    try 
      {
        await db.rawQuery("Delete FROM Tahsilat Where r_sayac=? ", [rsayac]);    
        result="Silme işlemi başarılı";
      } 
    catch (e) 
      {
        result=e.toString();
      } 
    return result;
  }
  

  Future<List<ZiyaretTipleri>> getZiyaretTipleri() async {
    final db = await database;
    db.isOpen;
    final res = await db.rawQuery("SELECT * FROM ZiyaretTipleri");
    List<ZiyaretTipleri> list =
        res.isNotEmpty ? res.map((c) => ZiyaretTipleri.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<ZiyaretSonlandirmaTipleri>> getZiyaretSonlandirmaTipleri() async {
    final db = await database;
    db.isOpen;
    final res = await db.rawQuery("SELECT * FROM ZiyaretSonlandirmaTipleri a Order By a.sira");
    List<ZiyaretSonlandirmaTipleri> list =
        res.isNotEmpty ? res.map((c) => ZiyaretSonlandirmaTipleri.fromJson(c)).toList() : [];

    return list;
  }


  insertTahsilat(Tahsilat newTahsilat) async {
    try {
      final db = await database;      
      final res = await db.insert('Tahsilat', newTahsilat.toJson());      
      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Tahsilat Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
    }
  }

  updateTahsilat(Tahsilat newTahsilat) async {
    try {
      final db = await database;      
      final res = await db.update('Tahsilat', newTahsilat.toJsonUpdate(), where: ' r_sayac=? ',whereArgs: [newTahsilat.rsayac]);
      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Tahsilat güncellenemedi.' + e.toString().substring(0,100), Icons.error);
    }
  }

  Future<int> insertAktarimDurumu(AktarimDurumu newAktarim) async {
    try {
      final db = await database;      
      int res = await db.insert('AktarimDurumu', newAktarim.toJson());      
      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'AktarimDurumu Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
      return 0;
    }

  }

  Future<int> updateAktarimDurumu(AktarimDurumu newAktarim) async {
    try {
      final db = await database;
      int res=0;      
      res= await db.update('AktarimDurumu', newAktarim.toJsonUpdate());      
      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'AktarimDurumu güncellenemedi.' + e.toString().substring(0,100), Icons.error);
      return 0;
    }
  }

  Future<AktarimDurumu> getAktarimDurumu() async {
    final db = await database;
    final res = await db.rawQuery("Select * from AktarimDurumu ");
    AktarimDurumu result =
        res.isNotEmpty ? res.map((c) => AktarimDurumu.fromJson(c)).first : AktarimDurumu();

    return result;    
  }

  
  Future<int> getRutIciZiyaretSayisi() async {

    try {
      final db = await database;

      int result=0;
      var tarih=DateFormat('yyyy-MM-dd').format(DateTime.now());
            
      final res = await db.rawQuery("Select count(distinct a.cari_kodu) as ziyaretSayisi " + 
        "from Ziyaret a INNER JOIN ZiyaretTipleri b ON a.ziyaret_tipi_sayac=b.r_sayac " + 
        "Where strftime('%Y-%m-%d',a.start_date)=? And IFNULL(a.aktarildi,0)=0 " +
        "And not Exists(Select t.cari_kodu from Ziyaret t Where t.cari_kodu=a.cari_kodu And IFNULL(t.aktarildi,0)=1) " +
        "And b.tipi IN ('Ziyaret Rut İçi','Telefon Rut İçi') ", [tarih]);

      var dbItem = res.isNotEmpty ? res.first['ziyaretSayisi'].toString():'0';
      result=int.parse(dbItem);

      return result;    
      
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Ziyaret Tablosu okunamadı.' + e.toString().substring(0,100), Icons.error);
      return null;
    }
    
  }
  
  
  Future<int> getRutDisiZiyaretSayisi() async {

    try {
      final db = await database;
      int result=0;
      var tarih=DateFormat('yyyy-MM-dd').format(DateTime.now());

      final res = await db.rawQuery("Select count(distinct a.cari_kodu) as ziyaretSayisi " + 
        "from Ziyaret a INNER JOIN ZiyaretTipleri b ON a.ziyaret_tipi_sayac=b.r_sayac " + 
        "Where strftime('%Y-%m-%d',a.start_date)=? And IFNULL(a.aktarildi,0)=0 " +
        "And not Exists(Select t.cari_kodu from Ziyaret t Where t.cari_kodu=a.cari_kodu And IFNULL(t.aktarildi,0)=1)" +
        "And b.tipi IN ('Ziyaret Rut Dışı','Telefon Rut Dışı') " +
        "And not Exists(Select t1.cari_kodu from Ziyaret t1 INNER JOIN ZiyaretTipleri t2 ON t1.ziyaret_tipi_sayac=t2.r_sayac " +
        "Where t1.cari_kodu=a.cari_kodu And t2.tipi IN ('Ziyaret Rut İçi','Telefon Rut İçi') " +  
        "and strftime('%Y-%m-%d',t1.start_date)=?) ",[tarih, tarih]);

      var dbItem = res.isNotEmpty ? res.first['ziyaretSayisi'].toString():'0';
      result=int.parse(dbItem);

      return result;
      
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Ziyaret Tablosu okunamadı.' + e.toString().substring(0,100), Icons.error);
      return null;
    }
            
  }
  Future<Ziyaret> getZiyaretId(int ziyaretId) async {
    final db = await database;
    
    Ziyaret result;
    final res = await db.rawQuery("Select * from Ziyaret a Where a.id=?", [ziyaretId]);
    Ziyaret ziyaret =
        res.isNotEmpty ? res.map((c) => Ziyaret.fromJson(c)).first : result;
        
    return ziyaret;    
  }

  Future<int> getAktarilmamisZiyaret() async {
    final db = await database;
    
    var tarih=DateFormat('yyyy-MM-dd').format(DateTime.now());    

    final res = await db.rawQuery(
        "SELECT Count(t.cari_kodu) as ziyaret_sayisi FROM Ziyaret t Where strftime('%Y-%m-%d',t.start_date)<>? And IFNULL(t.aktarildi,0)=0 ", [tarih]);

    
    var dbItem=res.first;
    int ziyaretSayisi=dbItem['ziyaret_sayisi']==null ? 0: dbItem['ziyaret_sayisi'];
        
    return ziyaretSayisi;
  }


  Future<Ziyaret> getActivateZiyaretId() async {
    final db = await database;
    final Controller mainController=Get.find();

    Ziyaret result;

    final res = await db.rawQuery("Select * from Ziyaret a Where a.is_ziyaret_active=1 And a.uzak_siparis=?", [mainController.uzaksiparis.value]);
    Ziyaret list =
        res.isNotEmpty ? res.map((c) => Ziyaret.fromJson(c)).first : result;
        
    return list;    
  }

  Future<RutListesi> getRut(int ziyaretId) async {
    final db = await database;
    
    final res = await db.rawQuery(
        "SELECT b.enlem,b.boylam,a.aktif,b.gunlukSiparisTutar,b.gunlukFaturaTutar,b.gunlukTahsilatTutar,a.gun,b.kod," +
        "b.unvan,b.tl_borc,b.tl_alacak,b.tl_abakiye,b.tl_bbakiye FROM CariRut a,Cari b, Ziyaret c " +
        "WHERE b.kod=a.kod And a.kod=c.cari_kodu And c.id=? ", [ziyaretId]);

    RutListesi rut =
        res.isNotEmpty ? res.map((c) => RutListesi.fromJson(c)).first : [];
    

    return rut;
  }


  Future<int> insertZiyaret(Ziyaret newZiyaret) async {
    try {
      final db = await database;      
      final res = await db.insert('Ziyaret', newZiyaret.toJson());      
      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Ziyaret Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
      return 0;
    }
  }

  Future<int> updateZiyaret(Ziyaret updateZiyaret) async {
    try {
      final db = await database;      
      final res = await db.update('Ziyaret', updateZiyaret.toJsonUpdate(), where: ' id=? ', whereArgs: [updateZiyaret.id]);
      return res;
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Ziyaret Tablosu gğncellenemedi.' + e.toString().substring(0,100), Icons.error);
      return 0;
    }

  }

  insertSatisTipi(SatisTipi newSatisTipi) async {
    final db = await database;
    final res = await db.insert('SatisTipleri', newSatisTipi.toJson());
    return res;
  }

  insertSatisFiyatlari(SatisFiyatlari newSatisFiyatlari) async {
    final db = await database;
    final res = await db.insert('SatisFiyatlari', newSatisFiyatlari.toJson());
    return res;
  }

  insertMalzeme(Malzeme newMalzeme) async {
    final db = await database;
    final res = await db.insert('Malzeme', newMalzeme.toJson());
    return res;
  }

  insertBirimCevrimi(BirimCevrimi birimCevrimi) async {
    final db = await database;
    final res = await db.insert('BirimCevrimi', birimCevrimi.toJson());
    return res;
  }

  insertMalzemePicture(MalzemePicture picture) async {
    final db = await database;
    final res = await db.insert('MalzemePicture', picture.toMap());
    return res;
  }

  Future<String> getSatisTipiKodu(String satistipi) async {
    final db = await database;

    final res =  await db.rawQuery("SELECT a.satis_tip_id FROM SatisTipleri a Where a.satis_tipi=?", [satistipi]);
    
    String satisTipiKodu="";
    if (res!=null)
    {
      res.forEach((element) { 
        satisTipiKodu=element.values.first;
      });
    }

    return satisTipiKodu;
  }

  Future<SatisTipi> getSatisTipiParametreleri(String satistipid) async {
    final db = await database;
    final res =  await db.rawQuery("SELECT a.* FROM SatisTipleri a Where a.satis_tip_id=?", [satistipid]);    

    SatisTipi satisTipi =
        res.isNotEmpty ? res.map((c) => SatisTipi.fromJson(c)).first : new SatisTipi();

    return satisTipi;
  }

  Future<String> getNewId() async {
    final db = await database;
    final res =  await db.rawQuery("select SUBSTR(UUID, 1, 8)||'-'||SUBSTR(UUID,8,4)||'-'||SUBSTR(UUID,12,4)||'-'|| SUBSTR(UUID,16,4)||'-'||SUBSTR(UUID,20,12) as guid " +
    "from (select hex(randomblob(16)) AS UUID ) ");

    var dbItem = res.first;

    String guid;
    guid = dbItem['guid'] as String;

    return guid;
  }

  Future<BirimCevrimi> getBirimCevrimiBirimli(String malzemekodu, String birimden, String birime) async {
    final db = await database;

    final res =  await db.rawQuery("SELECT DISTINCT r_sayac, birim_rsayac, birimden, birime, bolen, bolunen, ana_birim, malzeme_kodu "+
      "From (Select a.r_sayac,a.birim_rsayac, a.birime, a.birimden, a.bolen, a.bolunen, 2 as ana_birim, b.malzeme_kodu "+
      "from BirimCevrimi a INNER JOIN malzeme b ON a.birim_rsayac=b.r_sayac Where a.birime=b.baz_birim "+
      "UNION " +
      "Select a.r_sayac, a.birim_rsayac, a.birimden, a.birime, a.bolunen as bolen, a.bolen as bolunen, 2 as ana_birim, b.malzeme_kodu "+
      "from BirimCevrimi a INNER JOIN malzeme b ON a.birim_rsayac=b.r_sayac Where a.birimden=b.baz_birim) "+
      "Where malzeme_kodu=? And birimden=? And birime=?", [malzemekodu, birimden, birime]);

    BirimCevrimi birimcevrimi =
        res.isNotEmpty ? res.map((c) => BirimCevrimi.fromJson(c)).first : BirimCevrimi(malzemekodu: malzemekodu, 
          birimrsayac: 0, anabirim: 0, birimden:birimden, birime: birime, bolen: 0, bolunen: 0, rsayac: 0 );

    return birimcevrimi;
  }


  Future<List<BirimCevrimi>> getBirimCevrimi(String malzemekodu) async {
    final db = await database;

    final res =  await db.rawQuery("SELECT r_sayac, birim_rsayac, birimden, birime, bolen, bolunen, ana_birim, malzeme_kodu "+
      "From (Select b.r_sayac, b.r_sayac as birim_rsayac ,b.baz_birim as birimden, b.baz_birim as birime,"+
	    "CAST(1 as REAL) as bolen, CAST(1 as REAL) as bolunen, 1 as ana_birim, b.malzeme_kodu from malzeme b "+
      "UNION "+
      "Select a.r_sayac,a.birim_rsayac, a.birime, a.birimden, a.bolen, a.bolunen, 2 as ana_birim, b.malzeme_kodu "+
      "from BirimCevrimi a INNER JOIN malzeme b ON a.birim_rsayac=b.r_sayac Where a.birime=b.baz_birim "+
      "UNION " +
      "Select a.r_sayac, a.birim_rsayac,a.birimden, a.birime, a.bolunen as bolen, a.bolen as bolunen, 2 as ana_birim, b.malzeme_kodu "+
      "from BirimCevrimi a INNER JOIN malzeme b ON a.birim_rsayac=b.r_sayac Where a.birimden=b.baz_birim) "+
      "Where malzeme_kodu=?", [malzemekodu]);

    List<BirimCevrimi> birimcevrimi =
        res.isNotEmpty ? res.map((c) => BirimCevrimi.fromJson(c)).toList() : [];

    return birimcevrimi;
  }

  Future<double> getBirimCarpanValue(String malzemekodu, String birimden, String birime, double tutar, bool isTutar) async 
  {
    double result=0;
    BirimCevrimi birimcevrimi;

    final db = await database;
    final res =  await db.rawQuery("Select a.r_sayac,a.birim_rsayac, a.birime, a.birimden, a.bolen, a.bolunen, 2 as ana_birim, b.malzeme_kodu " +
     "from BirimCevrimi a INNER JOIN malzeme b ON a.birim_rsayac=b.r_sayac Where b.malzeme_kodu=? And a.birimden=? And a.birime=? ", [malzemekodu, birimden, birime]);

    if (res.isNotEmpty)
    {
      birimcevrimi =  res.map((c) => BirimCevrimi.fromJson(c)).first;
    }
    else
    {
      final res2 =  await db.rawQuery("Select a.r_sayac,a.birim_rsayac, a.birimden as birime, a.birime as birimden, a.bolunen as bolen, a.bolen as bolunen, 2 as ana_birim, b.malzeme_kodu " +
     "from BirimCevrimi a INNER JOIN malzeme b ON a.birim_rsayac=b.r_sayac Where b.malzeme_kodu=? And a.birime=? And a.birimden=? ", [malzemekodu, birimden, birime]);

      birimcevrimi =
        res2.isNotEmpty ? res2.map((c) => BirimCevrimi.fromJson(c)).first : new 
        BirimCevrimi(malzemekodu: malzemekodu, birimden: birimden, birime: birime, bolen: 0, bolunen: 0);      
    }

    if(isTutar)
    {
      if (birimcevrimi.rsayac!=null &&  birimcevrimi.rsayac!=0)
      {
        result=tutar / (birimcevrimi.bolunen/birimcevrimi.bolen);
      }
    }

    if(!isTutar)
    {
      if (birimcevrimi.rsayac!=null &&  birimcevrimi.rsayac!=0)
      {
        result=(birimcevrimi.bolunen * tutar)/birimcevrimi.bolen;
      }
    }

    return result;
  }

  updateSiparis(Siparis newSiparis) async {
    try {
      final db = await database;      
      final res = await db.update('Siparis', newSiparis.toJsonUpdate(), where: ' r_sayac=? ',whereArgs: [newSiparis.rsayac]);
      return res;
    } catch (e) {
      print(e.toString());      
      Get.snackbar("Hata", "Sipariş güncellenemedi.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
        duration: Duration(seconds: 5),);
    }
  }

  updateSiparisSatir(Siparis siparis, SiparisSatir newSiparisSatir) async {
    try {

      final db = await database;      
      await db.transaction((txn) async {
        Batch batch = txn.batch();
        batch.update('Siparis', siparis.toJsonUpdate(), where: ' r_sayac=? ',whereArgs: [siparis.rsayac]);

        batch.update('SiparisSatir', newSiparisSatir.toJsonUpdate(), where: ' r_sayac=? ',whereArgs: [newSiparisSatir.rsayac]);
        batch.commit(noResult: true);        
      });

      return 1;
    } catch (e) {
      print(e.toString());      
      Get.snackbar("Hata", "Sipariş satırı güncellenemedi.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
        duration: Duration(seconds: 5),);
      return 0;
    }
  }

  Future<List<SiparisSatirToplam>> getSiparisToplam(int siparissayac) async {
    final db = await database;

    final res =  await db.rawQuery("Select Max(a.mus_rsayac) as mus_rsayac, Max(a.sira_no) as sira_no, Sum(a.tutar) as tutar," +
      "Sum(a.toplam_indirim) as indirim_tutari, Sum(a.kdv_tutari) as toplam_kdv, Sum(a.satir_tutari) as toplam_tutar, Sum(a.miktar) as miktar," +
      "(Select t.satis_tipi from Siparis t Where t.r_sayac=a.mus_rsayac) as satis_tipi "+
      "FROM SiparisSatir a Where a.mus_rsayac=? Group By a.mus_rsayac ", [siparissayac]);

    List<SiparisSatirToplam> list =
      res.isNotEmpty ? res.map((c) => SiparisSatirToplam.fromJson(c)).toList() : 
      [new SiparisSatirToplam(
        tutar: 0,
        toplamaTutar: 0,
        indirimTutari: 0,
        kdvTutari: 0,
        sirano: 0,
        musrsayac: 0
      )];
      
    return list;
  }


  Future<SiparisSatirToplam> getSiparisSatirToplam(int siparissayac, int siparissatirrsayac) async {
    final db = await database;

    int sirano=0;
    if (siparissatirrsayac>0)
    {
      final res =  await db.rawQuery("Select t.sira_no from SiparisSatir t Where t.r_sayac=? ",[siparissatirrsayac]);
      var dbItem=res.first;
      sirano=dbItem['sira_no'];
    }
    else
    {
      final res =  await db.rawQuery("Select Max(t.sira_no) as sira_no from SiparisSatir t Where t.mus_rsayac=? ",[siparissayac]);
      var dbItem=res.first;
      sirano=dbItem['sira_no'];
      sirano= sirano==null ? 0:sirano;
      sirano=sirano + 1;
    }    

    final res =  await db.rawQuery("Select Max(a.mus_rsayac) as mus_rsayac, Max(a.sira_no) as sira_no, Sum(a.tutar) as tutar," + 
      "Sum(a.toplam_indirim) as indirim_tutari, Sum(a.kdv_tutari) as toplam_kdv, Sum(a.satir_tutari) as toplam_tutar," +
      "(Select t.sira_no from SiparisSatir t Where t.r_sayac=?) as siparis_sira_no,"+
      "(Select t.satis_tipi from Siparis t Where t.r_sayac=a.mus_rsayac) as satis_tipi "+
      "FROM SiparisSatir a Where a.mus_rsayac=? And a.r_sayac<>?", [siparissatirrsayac,siparissayac, siparissatirrsayac]);

    
    SiparisSatirToplam siparisSatirToplam =
        res.isNotEmpty ? res.map((c) => SiparisSatirToplam.fromJson(c)).first : new 
        SiparisSatirToplam(musrsayac: 0, sirano: 0, tutar: 0, indirimTutari: 0, kdvTutari: 0, toplamaTutar: 0);

    if (sirano>0)
      siparisSatirToplam.sirano=sirano;
    else
      siparisSatirToplam.sirano=1;
    

    return siparisSatirToplam;
  }

  Future<int> getAllSiparisCount() async {    
    final db = await database;
    var res=await db.rawQuery("SELECT count(c.r_sayac) as kayit_sayisi FROM Siparis c Where c.onay=1 ");

    var dbItem = res.first;
    int kayitsayisi = dbItem==null ? 0 : dbItem['kayit_sayisi'] as int;
    kayitsayisi = kayitsayisi==null ? 0 : kayitsayisi;
    
    return kayitsayisi;
  }


  Future<int> getSiparisListCount(int ouput) async {
    final SiparisController _controller =Get.find();
    Controller mainController=Get.find();
    final db = await database;

    var res=await db.rawQuery("SELECT count(b.r_sayac) as kayit_sayisi, Max(b.mus_rsayac) as siparis_rsayac "+
    "FROM SiparisSatir b INNER JOIN Siparis c ON b.mus_rsayac=c.r_sayac Where IFNull(c.onay,0)=0 And c.musteri_no=?", [mainController.carikod.value]);

    var dbItem = res.first;
    int kayitsayisi = dbItem['kayit_sayisi'] as int;
    int siparisrsayac=dbItem['siparis_rsayac'] as int;

    if (siparisrsayac!=null && kayitsayisi!=null && ouput==1)
    {      
      var res1=await db.rawQuery("SELECT a.guid FROM Siparis a Where a.r_sayac=? ", [siparisrsayac]);
      var dbItem1 = res1.first;
      String sGuid = dbItem1['guid'] as String;
      _controller.siparissayac.value=siparisrsayac;
      _controller.sGuid.value=sGuid;
    }

    return kayitsayisi;
  }

  Future<List<SiparisSatirGruplu>> getSiparisListGruplu() async {
    final SiparisController _controller =Get.find();
  
    final db = await database;
    final res = await db.rawQuery("Select c.malzeme_kodu, c.birimi, Sum(c.miktar) as miktar "+
    "FROM SiparisSatir c Where c.mus_rsayac=? And IFNULL(c.bedelsiz_kampanya_flag,0)=0 And IFNull(c.yuzdesel_kampanya_flag,0)=0 " +
    "Group By c.malzeme_kodu, c.birimi ", [_controller.siparissayac.value]);
    
    List<SiparisSatirGruplu> list =
        res.isNotEmpty ? res.map((c) => SiparisSatirGruplu.fromJson(c)).toList() : [];

    return list;
  }

  Future<SiparisSatirList> getSiparisSatirList(int siparissatirsayac) async {
  
    final db = await database;
    final res = await db.rawQuery("Select a.malzeme_kodu, a.malzeme_adi, a.grup_adi1, a.grup_adi2, a.grup_adi3,a.path,"+
      "b.birim_fiyat, b.indirim01_flag, b.indirim01 as iskonto_tutari1, b.indirim02_flag, b.indirim02 as iskonto_tutari2,"+
      "b.indirim03_flag, b.indirim03 as iskonto_tutari3, b.indirim04_flag, b.indirim04 as iskonto_tutari4,"+
      "b.indirim05_flag, b.indirim05 as iskonto_tutari5, b.indirim06_flag, b.indirim06 as iskonto_tutari6,"+
      "Case d.vade1 When 1 Then d.vade_kodu1 Else Case d.vade2 When 1 Then d.vade_kodu2 Else "+ 
      "Case d.vade3 When 1 Then d.vade_kodu3 Else Case d.vade4 When 1 Then d.vade_kodu4 Else "+ 
      "Case d.vade5 When 1 Then d.vade_kodu5 Else '' END END END END END as vade_kodu,"+    
      "b.kdv_orani, b.birimi as baz_birim,IFNUll(b.bedelsiz_kampanya_flag,0) as bedelsiz_kampanya_flag, IFNUll(b.yuzdesel_kampanya_flag,0) as yuzdesel_kampanya_flag,"+
      "(Select c.picture from MalzemePicture c Where c.malzeme_kodu=a.malzeme_kodu LIMIT 1) as picture,"+
      "b.r_sayac as siparis_satir_rsayac, b.satir_tutari, b.kdv_tutari,b.toplam_indirim,b.tutar, b.miktar, c.guid, b.mus_rsayac, b.aciklama,d.stok_miktari,d.barkod "+
    "FROM Malzeme a INNER JOIN SiparisSatir b ON a.malzeme_kodu=b.malzeme_kodu "+
      "INNER JOIN Siparis c ON b.mus_rsayac=c.r_sayac "+ 
      "INNER JOIN SatisFiyatlari d ON d.satis_tipi=c.satis_tipi And c.musteri_no=d.kod "+
    "Where a.malzeme_kodu=d.malzeme_kodu And b.r_sayac=? Order By b.r_sayac desc", [siparissatirsayac]);
    
    SiparisSatirList list =
        res.isNotEmpty ? res.map((c) => SiparisSatirList.fromJson(c)).first : new SiparisSatirList();

    return list;
  }



  Future<List<SiparisSatirList>> getSiparisList(int kampanyaharic) async {
  final SiparisController _controller =Get.find();
    if (kampanyaharic==0) kampanyaharic=-1;

    final db = await database;
    final res = await db.rawQuery("Select a.malzeme_kodu, a.malzeme_adi, a.grup_adi1, a.grup_adi2, a.grup_adi3,a.path,"+
      "b.birim_fiyat, b.indirim01_flag, b.indirim01 as iskonto_tutari1, b.indirim02_flag, b.indirim02 as iskonto_tutari2,"+
      "b.indirim03_flag, b.indirim03 as iskonto_tutari3, b.indirim04_flag, b.indirim04 as iskonto_tutari4,"+
      "b.indirim05_flag, b.indirim05 as iskonto_tutari5, b.indirim06_flag, b.indirim06 as iskonto_tutari6,"+
      "Case d.vade1 When 1 Then d.vade_kodu1 Else Case d.vade2 When 1 Then d.vade_kodu2 Else "+ 
      "Case d.vade3 When 1 Then d.vade_kodu3 Else Case d.vade4 When 1 Then d.vade_kodu4 Else "+ 
      "Case d.vade5 When 1 Then d.vade_kodu5 Else '' END END END END END as vade_kodu,"+    
      "b.kdv_orani, b.birimi as baz_birim,IFNUll(b.bedelsiz_kampanya_flag,0) as bedelsiz_kampanya_flag, IFNUll(b.yuzdesel_kampanya_flag,0) as yuzdesel_kampanya_flag,"+
      "(Select c.picture from MalzemePicture c Where c.malzeme_kodu=a.malzeme_kodu LIMIT 1) as picture,"+
      "b.r_sayac as siparis_satir_rsayac, b.satir_tutari, b.kdv_tutari,b.toplam_indirim,b.tutar, b.miktar, c.guid, b.mus_rsayac, b.aciklama,d.stok_miktari,d.barkod "+
    "FROM Malzeme a INNER JOIN SiparisSatir b ON a.malzeme_kodu=b.malzeme_kodu "+
      "INNER JOIN Siparis c ON b.mus_rsayac=c.r_sayac "+ 
      "INNER JOIN SatisFiyatlari d ON d.satis_tipi=c.satis_tipi And c.musteri_no=d.kod "+
    "Where a.malzeme_kodu=d.malzeme_kodu And c.r_sayac=? And IFNUll(b.bedelsiz_kampanya_flag,0)<>? Order By b.r_sayac desc", [_controller.siparissayac.value, kampanyaharic]);
    
    List<SiparisSatirList> list =
        res.isNotEmpty ? res.map((c) => SiparisSatirList.fromJson(c)).toList() : [];

    return list;
  }


  insertSiparisSatir(Siparis newSiparis, SiparisSatir newsiparisSatir) async {
    final SiparisController _controller =Get.find();

    try {
      final db = await database;
      await db.transaction((txn) async {
          Batch batch = txn.batch();

          int siparisrsayac=_controller.siparissayac.value;
          if (siparisrsayac==0 || siparisrsayac==null)
          {
            await txn.insert('Siparis', newSiparis.toJson(0));

            final List<Map<String, dynamic>> res=await txn.rawQuery('SELECT r_sayac FROM Siparis Where guid=?', [newSiparis.guid]);            
            var dbItem = res.first;            
            siparisrsayac = dbItem['r_sayac'] as int;

            if(siparisrsayac>0)
              _controller.sGuid.value=newSiparis.guid;

            _controller.siparissayac.value=siparisrsayac;
          }
          else
          {
            await txn.update('Siparis', newSiparis.toJsonUpdate(), where: ' r_sayac=? ',whereArgs: [newSiparis.rsayac]);
          }
                    
          if (siparisrsayac>0)
          {
            newsiparisSatir.musrsayac=siparisrsayac;
            await txn.insert('SiparisSatir', newsiparisSatir.toJson());
            int siparissatirrsayac=0;

            await txn.rawUpdate('Update SiparisSatir Set satir_id=r_sayac Where sira_no=? And mus_rsayac=?', [newsiparisSatir.sirano, newsiparisSatir.musrsayac]);

            var res=await txn.rawQuery('SELECT r_sayac FROM SiparisSatir Where sira_no=? And mus_rsayac=?', [newsiparisSatir.sirano, newsiparisSatir.musrsayac]);
            var dbItem = res.first;            
            siparissatirrsayac = dbItem['r_sayac'] as int;

            _controller.siparissatirrsayac.value=siparissatirrsayac;
          }
          
          batch.commit(noResult: true);
        }
      );
      return 1;
      
    } catch (e) {
      print(e.toString());      
      Get.snackbar("Hata", "Sipariş satırı kayıt edilemedi.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
        duration: Duration(seconds: 5),);
      return 0;
    }
  }

  Future<List<Siparis>> getSiparisTumList() async {    
    final db = await database;

      var res=await db.rawQuery("SELECT a.*,IFNULL((SELECT t.satis_tipi FROM SatisTipleri t Where t.satis_tip_id=a.satis_tipi),'') as satis_tipi_adi,"+ 
      "(Select Sum(t.miktar) from SiparisSatir t Where t.mus_rsayac=a.r_sayac) as toplam_miktar,"+
      "(SELECT COUNT(DISTINCT t.malzeme_kodu) FROM SiparisSatir as t Where t.mus_rsayac=a.r_sayac) as urun_cesidi, "+
      "(Select Max(t.unvan) from Cari t Where t.kod=a.musteri_no) as unvan "+
      "FROM Siparis a Where a.onay=1 Order By a.r_sayac desc");
      List<Siparis> list =
        res.isNotEmpty ? res.map((c) => Siparis.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Siparis>> getAllSiparis() async {
    Controller mainController=Get.find();
    final db = await database;

      var res=await db.rawQuery("SELECT a.*,IFNULL((SELECT t.satis_tipi FROM SatisTipleri t Where t.satis_tip_id=a.satis_tipi),'') as satis_tipi_adi,"+ 
      "(Select Sum(t.miktar) from SiparisSatir t Where t.mus_rsayac=a.r_sayac) as toplam_miktar,"+
      "(SELECT COUNT(DISTINCT t.malzeme_kodu) FROM SiparisSatir as t Where t.mus_rsayac=a.r_sayac) as urun_cesidi "+
      "FROM Siparis a Where a.onay=1 And a.musteri_no=? Order By a.r_sayac desc",[mainController.carikod.value]);
      List<Siparis> list =
        res.isNotEmpty ? res.map((c) => Siparis.fromJson(c)).toList() : [];

    return list;
  }

  Future<Siparis> getSiparisTekli(int siparissayac) async {
    final db = await database;

      var res=await db.rawQuery("SELECT a.*,IFNULL((SELECT t.satis_tipi FROM SatisTipleri t Where t.satis_tip_id=a.satis_tipi),'') as satis_tipi_adi,"+
      "(Select Sum(t.miktar) from SiparisSatir t Where t.mus_rsayac=a.r_sayac) as toplam_miktar,"+
      "(SELECT COUNT(DISTINCT t.malzeme_kodu) FROM SiparisSatir as t Where t.mus_rsayac=a.r_sayac) as urun_cesidi "+
      "FROM Siparis a Where a.r_sayac=? ", [siparissayac]);


      Siparis siparis =
        res.isNotEmpty ? res.map((c) => Siparis.fromJson(c)).first : [];

      return siparis;
  }


Future<Siparis> getSiparis(int siparissayac) async {
    final SiparisController _controller =Get.find();
    final db = await database;

      var res=await db.rawQuery("SELECT a.*,IFNULL((SELECT t.satis_tipi FROM SatisTipleri t Where t.satis_tip_id=a.satis_tipi),'') as satis_tipi_adi,"+
      "(Select Sum(t.miktar) from SiparisSatir t Where t.mus_rsayac=a.r_sayac) as toplam_miktar,"+
      "(SELECT COUNT(DISTINCT t.malzeme_kodu) FROM SiparisSatir as t Where t.mus_rsayac=a.r_sayac) as urun_cesidi "+
      "FROM Siparis a Where a.r_sayac=? ", [siparissayac]);


      Siparis siparis =
        res.isNotEmpty ? res.map((c) => Siparis.fromJson(c)).first : new Siparis();

      if (res!=null)
      {
        _controller.siparisTipi.value="Satış Siparişi";
        var dbItem = res.first;
        _controller.satisTipi.value=dbItem['satis_tipi_adi'] as String;
        _controller.satisTipikodu.value=siparis.satistipi.toString();            
        _controller.siparisTarihiController.text=DateFormat('dd-MM-yyyy').format(siparis.siparistarihi).toString();
        _controller.sevkTarihiController.text=DateFormat('dd-MM-yyyy').format(siparis.sevktarihi).toString();
        _controller.aciklamaController.text=siparis.aciklama.toString();
        _controller.tutar.value=siparis.siparistutari;
        _controller.indirimTutari.value=siparis.indirimtutari;
        _controller.kdvTutari.value=siparis.toplamkdv;
        _controller.toplamaTutar.value=siparis.toplamtutar;
      }

      return siparis;
  }

   Future<int> getSiparisSatirCount(int siparissayac) async {
    final db = await database;

    final res =  await db.rawQuery("Select count(a.mus_rsayac) as kayit_sayisi FROM SiparisSatir a Where a.mus_rsayac=? ", [siparissayac]);

    var dbItem = res.first;
    int kayitsayisi = dbItem==null ? 0: dbItem['kayit_sayisi'] as int;
    kayitsayisi=kayitsayisi==null ? 0:kayitsayisi;

    return kayitsayisi;
    
  }

  Future<int> getOnaysizSiparisCount(int siparissayac) async {
    final db = await database;

    final res =  await db.rawQuery("Select count(a.r_sayac) as kayit_sayisi FROM Siparis a Where a.r_sayac=? And IFNUll(a.onay,0)=0 ", [siparissayac]);

    var dbItem = res.first;
    int kayitsayisi = dbItem==null ? 0: dbItem['kayit_sayisi'] as int;
    kayitsayisi=kayitsayisi==null ? 0:kayitsayisi;

    return kayitsayisi;
    
  }


  Future<int> deleteSiparis(int siparissayac) async {
    
    try {

      final db = await database;

      await db.transaction((txn) async {
        Batch batch = txn.batch();
        batch.rawDelete("Delete FROM SiparisSatir Where mus_rsayac=? ", [siparissayac]);

        batch.rawDelete("Delete FROM Siparis Where r_sayac=? ", [siparissayac]);

        batch.rawDelete("Delete FROM SiparisIndirim Where siparis_rsayac=? ", [siparissayac]);

        batch.commit(noResult: true);
      });
      return 1;      
    } 
    catch (e) {
      print(e.toString());
      Get.snackbar("Hata", "Sipariş silinemedi.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
        duration: Duration(seconds: 5),);
      return 0;
    }
  }


  deleteSiparisSatir(int siparissatirsayac) async {
    final SiparisController _controller =Get.find();

    try {

      final db = await database;
      
      await db.transaction((txn) async {
        Batch batch = txn.batch();
        batch.rawDelete("Delete FROM SiparisSatir Where r_sayac=? ", [siparissatirsayac]);

        batch.rawDelete("Delete FROM SiparisIndirim Where siparis_satir_rsayac=? ", [siparissatirsayac]);

        final List<Map<String, dynamic>> 
          exist = await txn.rawQuery("Select Max(a.mus_rsayac) as mus_rsayac, Max(a.sira_no) as sira_no, Sum(a.tutar) as tutar," + 
          "Sum(a.toplam_indirim) as indirim_tutari, Sum(a.kdv_tutari) as toplam_kdv, Max(a.satir_tutari) as toplam_tutar," +
          "(Select t.sira_no from SiparisSatir t Where t.r_sayac=?) as siparis_sira_no "+
          "FROM SiparisSatir a Where a.mus_rsayac=? And a.r_sayac<>?", [siparissatirsayac,_controller.siparissayac.value, siparissatirsayac]);
          
          var dbItem=exist.first;
          SiparisSatirToplam siparisSatirToplam =new 
            SiparisSatirToplam(musrsayac: dbItem['mus_rsayac'], sirano:dbItem['sira_no'] , tutar: dbItem['tutar'], 
              indirimTutari: dbItem['indirim_tutari'], kdvTutari: dbItem['toplam_kdv'], toplamaTutar: dbItem['toplam_tutar']);

          batch.rawUpdate("Update Siparis Set siparis_tutari=?, indirim_tutari=?, toplam_kdv=?, toplam_tutar=?  Where r_sayac=? ", 
          [siparisSatirToplam.tutar, siparisSatirToplam.indirimTutari, siparisSatirToplam.kdvTutari, siparisSatirToplam.toplamaTutar, _controller.siparissayac.value]);


        batch.commit(noResult: true);
      });
      
      return 1;      
    } 
    catch (e) {
      print(e.toString());      
      Get.snackbar("Hata", "Sipariş satırı silinemedi.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
        duration: Duration(seconds: 5),);              
      return 0;
    }
  }


  siparisOnayla(int siparissayac) async {
    final db = await database;

    try {
      await db.transaction((txn) async {
      Batch batch = txn.batch();

      final res =  await txn.rawQuery("Select Max(a.mus_rsayac) as mus_rsayac, Max(a.sira_no) as sira_no, Sum(a.tutar) as tutar," + 
      "Sum(a.toplam_indirim) as indirim_tutari, Sum(a.kdv_tutari) as toplam_kdv, Sum(a.satir_tutari) as toplam_tutar, "+
      "(Select t.satis_tipi from Siparis t Where t.r_sayac=a.mus_rsayac) as satis_tipi "+      
      "FROM SiparisSatir a Where a.mus_rsayac=? Group By a.mus_rsayac", [siparissayac]);

      SiparisSatirToplam siparisSToplam =
        res.isNotEmpty ? res.map((c) => SiparisSatirToplam.fromJson(c)).first : new 
        SiparisSatirToplam(musrsayac: 0, sirano: 0, tutar: 0, indirimTutari: 0, kdvTutari: 0, toplamaTutar: 0);

      batch.rawUpdate("Update Siparis Set siparis_tutari=?, indirim_tutari=?, toplam_kdv=?, toplam_tutar=?, onay=1  Where r_sayac=? ", 
          [siparisSToplam.tutar, siparisSToplam.indirimTutari, siparisSToplam.kdvTutari, siparisSToplam.toplamaTutar, siparissayac]);

      

      batch.commit(noResult: true);
    });
    return 1;
      
    } 
    catch (e) {
      print(e.toString());
      Get.snackbar("Hata", "Sipariş onaylanamadı.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
        duration: Duration(seconds: 5),);
      return 0;
    }
  }
  insertBekleyenSiparis(BekleyenSiparis bekleyenSiparis) async {
    final db = await database;
    final res = await db.insert('BekleyenSiparis', bekleyenSiparis.toJson());    
    return res;
  }

  Future<List<BekleyenSiparisGruplu>> getBekleyenSiparisGruplu(int rapor) async {
    final db = await database;

    //Sipariş detayı yazılacak unutma.
    String sql="";
    if (rapor==1)
    {      
      sql="Select a.malzeme_kodu, a.birimi, Sum(a.miktar) as miktar, Max(a.baz_birim) as baz_birim "+ 
      "from AllBekleyenSiparis a Group By a.malzeme_kodu, a.birimi ";
    }
    else
    {
      sql="Select a.malzeme_kodu, a.birimi, Sum(a.miktar) as miktar, Max(b.baz_birim) as baz_birim "+ 
        "from BekleyenSiparis a INNER JOIN Malzeme b On a.malzeme_kodu=b.malzeme_kodu Group By a.malzeme_kodu, a.birimi ";
    }

    final res =  await db.rawQuery(sql);

    List<BekleyenSiparisGruplu> list =
      res.isNotEmpty ? res.map((c) => BekleyenSiparisGruplu.fromJson(c)).toList() : [] ;

    List<BekleyenSiparisGruplu> resultlist=<BekleyenSiparisGruplu>[];
    double miktar=0;
    await Future.forEach(list, (BekleyenSiparisGruplu item) async{        
      if (item.birimi.toString().toLowerCase().trim()!=item.bazbirim.toString().toLowerCase().trim())
      {
        BirimCevrimi birimCevrimi= await DBProvider.db.getBirimCevrimiBirimli(item.malzemekodu, item.birimi, item.bazbirim);
        if (birimCevrimi.rsayac>0)
        {
          item.miktar=(birimCevrimi.bolunen * item.miktar)/birimCevrimi.bolen;
        }
      }
      miktar=0;
      if (resultlist.where((element) => element.malzemekodu==item.malzemekodu).length>0)
      {
        BekleyenSiparisGruplu result=resultlist.where((element) => element.malzemekodu==item.malzemekodu).first;
        miktar=result.miktar;        
        resultlist.removeWhere((element) => element.malzemekodu==item.malzemekodu);
      }
      resultlist.add(
        new BekleyenSiparisGruplu(malzemekodu:item.malzemekodu,
          bazbirim:item.bazbirim, birimi:item.bazbirim, miktar: item.miktar + miktar)
      );
    });

    return resultlist;
  }
  

  Future<List<BekleyenSiparis>> getBekleyenSiparisDetay() async {
    Controller mainController=Get.find();
    final db = await database;

    //Sipariş detayı yazılacak unutma.
    final res =  await db.rawQuery("Select a.*,(Select c.picture from MalzemePicture c Where c.malzeme_kodu=a.malzeme_kodu LIMIT 1) as picture," +
    "a.malzeme_adi from BekleyenSiparis a Where a.musteri_no=?", [mainController.carikod.value]);
    
    List<BekleyenSiparis> list =
      res.isNotEmpty ? res.map((c) => BekleyenSiparis.fromJson(c)).toList() : [] ;
      
    return list;

  }

  Future<List<SiparisSatir>> getSiparisDetay() async {
    final db = await database;

    //Sipariş detayı yazılacak unutma.
    final res =  await db.rawQuery("Select a.*,(Select c.picture from MalzemePicture c Where c.malzeme_kodu=a.malzeme_kodu LIMIT 1) as picture," +
    "b.malzeme_adi, c.siparis_no from SiparisSatir a LEFT JOIN Malzeme b On a.malzeme_kodu=b.malzeme_kodu INNER JOIN Siparis c ON a.mus_rsayac=c.r_sayac ");
 
    List<SiparisSatir> list =
      res.isNotEmpty ? res.map((c) => SiparisSatir.fromJson(c)).toList() : [] ;
      
    return list;

  }


  Future<List<BekleyenSiparisGrupAdi>> getbekleyenSiparisGrup() async {
    final Controller mainController =Get.find();
    final db = await database;
    

    
    final res =  await db.rawQuery("Select a.siparis_no, Max(a.unvan) as unvan, Max(a.temsilci_adi) as temsilci_adi," +
      "a.siparis_tarihi, Max(a.toplam_tutar) as tutar, Sum(a.miktar)  as miktar " +         
      "FROM BekleyenSiparis a Where a.musteri_no=? Group By a.siparis_tarihi, a.siparis_no Order By a.siparis_tarihi desc, a.siparis_no desc", [mainController.carikod.value]);

    List<BekleyenSiparisGrupAdi> list =
      res.isNotEmpty ? res.map((c) => BekleyenSiparisGrupAdi.fromJson(c)).toList() : [];
      
    return list;
  }



  Future<List<KampanyaBedelsizVerilen>> getKampanyaBedelsizVerilen(int kampanyaRsayac) async {
    final db = await database;
    final SiparisController _controller =Get.find();
    final Controller mainController =Get.find();
    
    final res =  await db.rawQuery("Select DISTINCT a.kampanya_rsayac, c.kampanya_kodu,a.birim,a.cid,a.grup_kodu,a.grup_rsayac,a.hayat_kampanya,a.kota,a.malzeme_kodu, a.miktar, a.paket, a.ust_paket,IFNull(c.zorunlu,0) as zorunlu,"+
      "Case b.fiyat1 When 1 Then b.fiyat_tutar1 Else Case b.fiyat2 When 1 Then b.fiyat_tutar2 Else "+ 
      "Case b.fiyat3 When 1 Then b.fiyat_tutar3 Else Case b.fiyat4 When 1 Then b.fiyat_tutar4 Else "+
      "Case b.fiyat5 When 1 Then b.fiyat_tutar5 Else 0.0 END END END END END as birim_fiyat, "+
      "(Select count(t.r_sayac) from KampanyaBedelsizVerilen t Where t.kampanya_rsayac=a.kampanya_rsayac) kayit_sayisi "+       
    "from KampanyaBedelsizVerilen a INNER JOIN SatisFiyatlari b ON a.malzeme_kodu=b.malzeme_kodu INNER JOIN Kampanya c On a.kampanya_rsayac=c.r_sayac "+
    "Where a.kampanya_rsayac=? And b.satis_tipi=? And c.cari_kodu=? And b.kod=c.cari_kodu ", 
    [kampanyaRsayac, _controller.satisTipikodu.value, mainController.carikod.value]);

    List<KampanyaBedelsizVerilen> list =
      res.isNotEmpty ? res.map((c) => KampanyaBedelsizVerilen.fromJson(c)).toList() : [];
    
    return list;

  }

  insertKampanya(Kampanya newKampanya) async {
    final db = await database;
    final res = await db.insert('Kampanya', newKampanya.toJson());
    return res;
  }

  insertKampanyaBedelsizSatir(KampanyaBedelsizSatir newKampanyabedelsizSatir) async {
    final db = await database;
    final res = await db.insert('KampanyaBedelsizSatir', newKampanyabedelsizSatir.toJson());
    return res;
  }

  insertKampanyaBedelsizVerilen(KampanyaBedelsizVerilen newKampanyaBedelsizVerilen) async {
    final db = await database;
    final res = await db.insert('KampanyaBedelsizVerilen', newKampanyaBedelsizVerilen.toJson());
    return res;
  }

  insertKampanyaYuzdeselSatir(KampanyaYuzdeselSatir newKampanyaYuzdeselSatir) async {
    final db = await database;
    final res = await db.insert('KampanyaYuzdeselSatir', newKampanyaYuzdeselSatir.toJson());
    return res;
  }

  insertKampanyaSecimliGruplar(KampanyaSecimliGruplar newKampanyaSecimliGruplar) async {
    final db = await database;
    final res = await db.insert('KampanyaSecimliGruplar', newKampanyaSecimliGruplar.toJson());
    return res;
  }

  Future<KampanyaYuzdeselSatir> getKampanyaYuzdeselMalzeme(String malzemeKodu) async {
    final db = await database;
    final Controller _controller=Get.find();

    final res= await db.rawQuery("Select DISTINCT b.*, c.max_miktar, c.min_miktar, c.iskonto_hanesi,c.grup_adi,a.kampanya_adi,a.kampanya_kodu, IFNull(a.zorunlu,0) as zorunlu "+
        "from Kampanya a INNER JOIN KampanyaYuzdeselSatir b ON a.r_sayac=b.kampanya_rsayac " +
        "INNER JOIN KampanyaSecimliGruplar c On a.r_sayac=c.kampanya_rsayac And b.grup_kodu=c.grup_kodu " +
        "Where (b.indirim01>0 Or b.indirim02>0 Or b.indirim03>0 Or b.indirim04>0 Or b.indirim05>0 Or b.indirim06>0) "+        
        "And b.malzeme_kodu=? And a.cari_kodu=? ",[malzemeKodu,_controller.carikod.value]);

      KampanyaYuzdeselSatir yuzdeselbos=new KampanyaYuzdeselSatir(malzemeKodu: "", 
        indirim01: 0, indirim02: 0, indirim03: 0, indirim04: 0, indirim05: 0, indirim06: 0);

      KampanyaYuzdeselSatir list =
      res.isNotEmpty ? res.map((c) => KampanyaYuzdeselSatir.fromJson(c)).first : yuzdeselbos;
    if (malzemeKodu=='AK3')
      {
        print('test');
      }

    return list;
  }

  Future<KampanyaBedelsizSatir> getKampanyaBedelsizMalzeme(String malzemeKodu) async {
    final db = await database;
    final Controller _controller=Get.find();

      final res1= await db.rawQuery("Select b.*,c.grup_toplam_miktar,c.bedelsiz_grup_toplam_miktar,c.iskonto_hanesi,c.grup_adi,c.grup_kodu,a.kampanya_adi "+
        "from Kampanya a INNER JOIN KampanyaBedelsizSatir b ON a.r_sayac=b.kampanya_rsayac " +
        "INNER JOIN KampanyaSecimliGruplar c On a.r_sayac=c.kampanya_rsayac And b.grup_kodu=c.grup_kodu " +
        "Where c.iskonto_hanesi>0  And b.malzeme_kodu=? And a.cari_kodu=?", [malzemeKodu, _controller.carikod.value]);

      KampanyaBedelsizSatir bedelsizbos=new KampanyaBedelsizSatir(grupAdi: "", malzemeKodu: "");

      KampanyaBedelsizSatir list =
        res1.isNotEmpty ? res1.map((c) => KampanyaBedelsizSatir.fromJson(c)).first : bedelsizbos;

      return list;
  }




  Future<List<KampanyaYuzdeselSatir>> getKampanyaYuzdeselSatir(int mussayac) async {
    final db = await database;
    final Controller _controller=Get.find();

    final res= await db.rawQuery("Select DISTINCT b.*, c.max_miktar, c.min_miktar, c.iskonto_hanesi,c.grup_adi,a.kampanya_adi,a.kampanya_kodu, IFNull(a.zorunlu,0) as zorunlu "+
        "from Kampanya a INNER JOIN KampanyaYuzdeselSatir b ON a.r_sayac=b.kampanya_rsayac " +
        "INNER JOIN KampanyaSecimliGruplar c On a.r_sayac=c.kampanya_rsayac And b.grup_kodu=c.grup_kodu " +
        "Where (b.indirim01>0 Or b.indirim02>0 Or b.indirim03>0 Or b.indirim04>0 Or b.indirim05>0 Or b.indirim06>0) "+
        "And Exists(Select t.r_sayac FROM SiparisSatir t, KampanyaYuzdeselSatir t1 Where t.malzeme_kodu=t1.malzeme_kodu "+ 
        "And t1.kampanya_rsayac=b.kampanya_rsayac And t1.grup_kodu=b.grup_kodu And t.mus_rsayac=?) And a.cari_kodu=? ",[mussayac, _controller.carikod.value]);
        
      List<KampanyaYuzdeselSatir> list =
      res.isNotEmpty ? res.map((c) => KampanyaYuzdeselSatir.fromJson(c)).toList() : [];
    
    return list;
  }

  Future<List<KampanyaBedelsizSatir>> getKampanyaBedelsizSatir(int mussayac) async {
    final db = await database;
    final Controller _controller=Get.find();


      final res1= await db.rawQuery("Select DISTINCT b.*,c.grup_toplam_miktar,c.bedelsiz_grup_toplam_miktar,c.iskonto_hanesi,c.grup_adi,c.grup_kodu,a.kampanya_adi "+
        "from Kampanya a INNER JOIN KampanyaBedelsizSatir b ON a.r_sayac=b.kampanya_rsayac " +
        "INNER JOIN KampanyaSecimliGruplar c On a.r_sayac=c.kampanya_rsayac And b.grup_kodu=c.grup_kodu " +
        "Where c.iskonto_hanesi>0 And a.cari_kodu=? "+
        "And Exists(Select t.r_sayac FROM SiparisSatir t Where t.malzeme_kodu=b.malzeme_kodu And t.mus_rsayac=?) ",[_controller.carikod.value, mussayac]);

      List<KampanyaBedelsizSatir> list =
        res1.isNotEmpty ? res1.map((c) => KampanyaBedelsizSatir.fromJson(c)).toList() : [];

      return list;
  }

  Future<bool> insertSiparisIndirim(SiparisIndirim siparisIndirim) async {
    try {
      final db = await database;
      int res = await db.insert('SiparisIndirim', siparisIndirim.toJson());

      if (res>0)
      {
        return true;
      }

    } catch (e) {
      print(e.toString());
      Get.snackbar("Hata", "Sipariş kampanya indirimleri yazılamadı.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
        duration: Duration(seconds: 5),);
      return false;
    }
    return true; 
  }

  Future<List<SiparisIndirim>> getSiparisIndirim(int siparisrsayac) async {
    final db = await database;

      final res= await db.rawQuery("Select a.* from SiparisIndirim a Where a.siparis_rsayac=?",[siparisrsayac]);

      List<SiparisIndirim> list =
        res.isNotEmpty ? res.map((c) => SiparisIndirim.fromJson(c)).toList() : [];

      return list;

  }
  Future<List<SiparisIndirim>> getAllSiparisIndirim() async {
    final db = await database;

      final res= await db.rawQuery("Select a.* from SiparisIndirim a,Siparis b Where b.r_sayac=a.siparis_rsayac And b.onay=1");

      List<SiparisIndirim> list =
        res.isNotEmpty ? res.map((c) => SiparisIndirim.fromJson(c)).toList() : [];

      return list;
  }

  Future<bool> deleteSiparisIndirim(int siparissatirrsayac, String indirimkodu, String grupkodu) async {

    try {
      final db = await database;    
      await db.rawQuery("Delete from SiparisIndirim Where siparis_satir_rsayac=? And indirim_kodu=? And grup_kodu=?",[siparissatirrsayac, indirimkodu, grupkodu]);

      return true;
    } catch (e) {
      Get.snackbar("Hata", "Kampanyada SiparisIndirim tablosu silinemedi.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
        duration: Duration(seconds: 5),);
       print(e.toString());
       return false;
    }
        
  }

  Future<List<Siparis>> getAktarilacakSiparis() async {    
    final db = await database;

      var res=await db.rawQuery("SELECT a.*,IFNULL((SELECT t.satis_tipi FROM SatisTipleri t Where t.satis_tip_id=a.satis_tipi),'') as satis_tipi_adi,"+ 
      "(Select Sum(t.miktar) from SiparisSatir t Where t.mus_rsayac=a.r_sayac) as toplam_miktar,"+
      "(SELECT COUNT(DISTINCT t.malzeme_kodu) FROM SiparisSatir as t Where t.mus_rsayac=a.r_sayac) as urun_cesidi "+
      "FROM Siparis a Where a.onay=1 Order By a.r_sayac");
      List<Siparis> list =
        res.isNotEmpty ? res.map((c) => Siparis.fromJson(c)).toList() : [];

    return list;

  }



  Future<List<SiparisSatir>> getAktarilacakSiparisSatir() async {
  
    final db = await database;
    final res = await db.rawQuery("Select b.* FROM SiparisSatir b INNER JOIN Siparis c ON b.mus_rsayac=c.r_sayac And c.onay=1 "+
    "Order By b.r_sayac");    

    List<SiparisSatir> list =
        res.isNotEmpty ? res.map((c) => SiparisSatir.fromJson(c)).toList() : [];

    return list;
  }
  
  Future<ValidationResponse> deleteAllSiparisIndirim() async {
    ValidationResponse vr=ValidationResponse(successful: true, information: "");
    final db = await database;    
    try 
      {
        await db.rawQuery("Delete FROM SiparisIndirim");
      } 
    catch (e) 
      {        
        vr.successful=false;
        vr.information=e.toString();
      } 
    return vr;
  }

  Future<ValidationResponse> deleteAllSiparisSatir() async {
    ValidationResponse vr=ValidationResponse(successful: true, information: "");
    final db = await database;    
    try 
      {
        await db.rawQuery("Delete FROM SiparisSatir");
      } 
    catch (e) 
      {        
        vr.successful=false;
        vr.information=e.toString();
      } 
    return vr;
  }
  Future<ValidationResponse> deleteAllSiparis() async {
    ValidationResponse vr=ValidationResponse(successful: true, information: "");
    final db = await database;    
    try 
      {
        await db.rawQuery("Delete FROM Siparis");
      } 
    catch (e) 
      {        
        vr.successful=false;
        vr.information=e.toString();
      } 
    return vr;
  }

  

  insertMusteriMalAnalizi(MusteriMalAnalizi musteriMalAnalizi) async {
    final db = await database;
    final res = await db.insert('MusteriMalAnalizi', musteriMalAnalizi.toJson());
    return res;
  }

  Future<List<GrupBazindaSatislarM>> getGrupBazindaSatislar() async {
    RaporController _controller = Get.find();
    String grupadi="";

    if (_controller.grupkullan.value==1) grupadi="a.grup_adi1";
    if (_controller.grupkullan.value==2) grupadi="a.grup_adi2";
    if (_controller.grupkullan.value==3) grupadi="a.grup_adi3";

    String sql="SELECT Max(a.grup_adi1) as grup_adi1, Max(a.grup_adi2) as grup_adi2, Max(a.grup_adi3) as grup_adi3, a.musteri_kodu, Max(b.unvan) as unvan,"+ 
      "Sum(a.satis_miktari) as satis_miktari, a.rapor_birimi, Sum(a.iade_miktari) as iade_miktari," +
      "Sum(a.net_miktar) as net_miktar, Sum(a.satis_kdv_oncesi_tutar) as satis_kdv_oncesi_tutar," +
      "Sum(a.iade_kdv_oncesi_tutar) as iade_kdv_oncesi_tutar, Sum(a.net_kdv_oncesi_tutar) as net_kdv_oncesi_tutar," +
      "Max(a.grup_kodu1) as grup_kodu1, Max(a.grup_kodu2) as grup_kodu2, Max(a.grup_kodu3) as grup_kodu3 " +
    "FROM MusteriMalAnalizi as a,Cari as b Where b.kod=a.musteri_kodu ";
    
    if (_controller.mgrup1.value!="TÜMÜ")
    {
      sql=sql + "And a.grup_adi1='"+_controller.mgrup1.value + "' ";
    }
    if (_controller.mgrup2.value!="TÜMÜ")
    {
      sql=sql + "And a.grup_adi2='"+_controller.mgrup2.value + "' ";
    }
        
    if (_controller.musteriAdi.value!="TÜMÜ" )
    {
      sql=sql + "And b.unvan='"+_controller.musteriAdi.value + "' ";
    }
    else
    {
      if (_controller.rut.value=="TÜMÜ")
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_kodu) ";
      else
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_kodu And t.gun='"+ _controller.rut.value +"') ";
    }

    if (_controller.tarih1Controller.text!="")
      sql=sql + "And a.tarih>='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih1Controller.text).toString() + "' ";
    else
      sql=sql + "And a.tarih>='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih1.toString()).toString() + "' ";

    if (_controller.tarih2Controller.text!="")
      sql=sql + "And a.tarih<='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih2Controller.text).toString() + "' ";
    else
      sql=sql + "And a.tarih<='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih2.toString()).toString() + "' ";

    sql=sql +  "Group BY "+grupadi+", a.musteri_kodu, a.rapor_birimi ";  
    sql=sql +  "Order By "+grupadi+", Max(b.unvan) ";

    final db = await database;
    final res = await db.rawQuery(sql);

    List<GrupBazindaSatislarM> list =
        res.isNotEmpty ? res.map((c) => GrupBazindaSatislarM.fromJson(c)).toList() : [];

    return list;
    
  }


  Future<List<MusteriMalAnaliziMlzMusToplam>> getMusteriMalAnalizi() async {
    RaporController _controller = Get.find();


    //String sql="SELECT a.*,t.unvan FROM MusteriMalAnalizi as a,Cari as t Where t.kod=a.musteri_kodu ";
    String sql="SELECT a.musteri_kodu, Max(b.unvan) as unvan, a.malzeme_kodu, Max(a.malzeme_adi) as malzeme_adi,"+ 
      "Sum(a.satis_miktari) as satis_miktari, a.rapor_birimi, Sum(a.iade_miktari) as iade_miktari," +
      "Sum(a.net_miktar) as net_miktar, Sum(a.satis_kdv_oncesi_tutar) as satis_kdv_oncesi_tutar," +
      "Sum(a.iade_kdv_oncesi_tutar) as iade_kdv_oncesi_tutar, Sum(a.net_kdv_oncesi_tutar) as net_kdv_oncesi_tutar," +
      "Max(a.grup_kodu1) as grup_kodu1, Max(a.grup_kodu2) as grup_kodu2, Max(a.grup_kodu3) as grup_kodu3 " +
    "FROM MusteriMalAnalizi as a,Cari as b Where b.kod=a.musteri_kodu ";
        
    if (_controller.mgrup1.value!="TÜMÜ")
    {
      sql=sql + "And a.grup_adi1='"+_controller.mgrup1.value + "' ";
    }
    if (_controller.mgrup2.value!="TÜMÜ")
    {
      sql=sql + "And a.grup_adi2='"+_controller.mgrup2.value + "' ";
    }
        
    if (_controller.musteriAdi.value!="TÜMÜ" )
    {
      sql=sql + "And b.unvan='"+_controller.musteriAdi.value + "' ";
    }
    else
    {
      if (_controller.rut.value=="TÜMÜ")
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_kodu) ";
      else
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_kodu And t.gun='"+ _controller.rut.value +"') ";
    }

    if (_controller.tarih1Controller.text!="")
      sql=sql + "And a.tarih>='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih1Controller.text).toString() + "' ";
    else
      sql=sql + "And a.tarih>='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih1.toString()).toString() + "' ";

    if (_controller.tarih2Controller.text!="")
      sql=sql + "And a.tarih<='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih2Controller.text).toString() + "' ";
    else
      sql=sql + "And a.tarih<='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih2.toString()).toString() + "' ";
    
    sql=sql +  "Group By a.musteri_kodu, a.malzeme_kodu, a.rapor_birimi ";
    sql=sql +  "Order By Max(b.unvan), Max(a.malzeme_adi), a.rapor_birimi ";

    final db = await database;
    final res = await db.rawQuery(sql);

    List<MusteriMalAnaliziMlzMusToplam> list =
        res.isNotEmpty ? res.map((c) => MusteriMalAnaliziMlzMusToplam.fromJson(c)).toList() : [];

    return list;
    
  }

  Future<List<MusteriMalAnaliziAy>> getMusteriMalAnaliziAylikGruplu() async{
    RaporController _controller = Get.find();
    String grupadi="";
    String grupkodu="";

    if (_controller.grupkullan.value==1) {grupadi="Max(a.grup_adi1) as malzeme_adi"; grupkodu="a.grup_kodu1";}
    if (_controller.grupkullan.value==2) {grupadi="Max(a.grup_adi2) as malzeme_adi"; grupkodu="a.grup_kodu2";}
    if (_controller.grupkullan.value==3) {grupadi="Max(a.grup_adi3) as malzeme_adi"; grupkodu="a.grup_kodu3";}

    if (grupadi==null || grupadi=="")
    {
      grupadi="Max(a.malzeme_adi) as malzeme_adi"; 
      grupkodu="a.malzeme_kodu";
    }
    

    try {

      DateTime tarih=DateTime(DateTime.now().year, DateTime.now().month - 3, 1);

      String sql="SELECT a.musteri_kodu, Max(t.unvan) as unvan, " + grupadi + ", " + grupkodu + " as malzeme_kodu," +
      "CAST(strftime('%m', tarih) as INTEGER) as ay, Sum(a.satis_miktari) - Sum(a.iade_miktari) as net_miktar,"+
      "Sum(a.satis_kdv_oncesi_tutar) - Sum(a.iade_kdv_oncesi_tutar) as net_tutar " +
      "FROM MusteriMalAnalizi as a,Cari as t Where t.kod=a.musteri_kodu And a.tarih>=? ";

      if (_controller.mgrup1.value!="TÜMÜ")
      {
        sql=sql + "And a.grup_adi1='"+_controller.mgrup1.value + "' ";
      }
      if (_controller.mgrup2.value!="TÜMÜ")
      {
        sql=sql + "And a.grup_adi2='"+_controller.mgrup2.value + "' ";
      }
          
      if (_controller.musteriAdi.value!="TÜMÜ" )
      {
        sql=sql + "And t.unvan='"+_controller.musteriAdi.value + "' ";
      }
      else
      {
        if (_controller.rut.value=="TÜMÜ")
          sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_kodu) ";
        else
          sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_kodu And t.gun='"+ _controller.rut.value +"') ";
      }

      if (_controller.tarih1Controller.text!="")
        sql=sql + "And a.tarih>='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih1Controller.text).toString() + "' ";
      else
        sql=sql + "And a.tarih>='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih1.toString()).toString() + "' ";

      if (_controller.tarih2Controller.text!="")
        sql=sql + "And a.tarih<='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih2Controller.text).toString() + "' ";
      else
        sql=sql + "And a.tarih<='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih2.toString()).toString() + "' ";

      
      sql=sql + "Group BY CAST(strftime('%m', a.tarih) as INTEGER),$grupkodu ,a.musteri_kodu ";
      sql=sql + "Order By $grupkodu ,a.musteri_kodu, CAST(strftime('%Y', a.tarih) || strftime('%m', a.tarih) as INTEGER) ";
      
      final db = await database;
      final res = await db.rawQuery(sql, [tarih.toString()]);

      List<MusteriMalAnaliziAy> list =
        res.isNotEmpty ? res.map((c) => MusteriMalAnaliziAy.fromJson(c)).toList() : [];

      return list;
        
    } catch (e) {
      print(e.toString());
      return null;
    }



  }

  Future<List<MusteriMalAnaliziAy>> getMusteriMalAnaliziAy() async {
    RaporController _controller = Get.find();

    try {

      DateTime tarih=DateTime(DateTime.now().year, DateTime.now().month - 3, 1);

      String sql="SELECT a.musteri_kodu, Max(t.unvan) as unvan, a.malzeme_kodu, Max(a.malzeme_adi) as malzeme_adi," +
      "CAST(strftime('%m', tarih) as INTEGER) as ay, Sum(a.satis_miktari) - Sum(a.iade_miktari) as net_miktar,"+
      "Sum(a.satis_kdv_oncesi_tutar) - Sum(a.iade_kdv_oncesi_tutar) as net_tutar " +
      "FROM MusteriMalAnalizi as a,Cari as t Where t.kod=a.musteri_kodu And a.tarih>=? ";

      if (_controller.mgrup1.value!="TÜMÜ")
      {
        sql=sql + "And a.grup_adi1='"+_controller.mgrup1.value + "' ";
      }
      if (_controller.mgrup2.value!="TÜMÜ")
      {
        sql=sql + "And a.grup_adi2='"+_controller.mgrup2.value + "' ";
      }
          
      if (_controller.musteriAdi.value!="TÜMÜ" )
      {
        sql=sql + "And t.unvan='"+_controller.musteriAdi.value + "' ";
      }
      else
      {
        if (_controller.rut.value=="TÜMÜ")
          sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_kodu) ";
        else
          sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_kodu And t.gun='"+ _controller.rut.value +"') ";
      }

      if (_controller.tarih1Controller.text!="")
        sql=sql + "And a.tarih>='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih1Controller.text).toString() + "' ";
      else
        sql=sql + "And a.tarih>='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih1.toString()).toString() + "' ";

      if (_controller.tarih2Controller.text!="")
        sql=sql + "And a.tarih<='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih2Controller.text).toString() + "' ";
      else
        sql=sql + "And a.tarih<='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih2.toString()).toString() + "' ";

      
      sql=sql + "Group BY CAST(strftime('%m', a.tarih) as INTEGER), a.musteri_kodu, a.malzeme_kodu ";
      sql=sql + "Order By a.musteri_kodu, a.malzeme_kodu, CAST(strftime('%Y', a.tarih) || strftime('%m', a.tarih) as INTEGER) ";

      final db = await database;
      final res = await db.rawQuery(sql, [tarih.toString()]);

      List<MusteriMalAnaliziAy> list =
        res.isNotEmpty ? res.map((c) => MusteriMalAnaliziAy.fromJson(c)).toList() : [];

      return list;
        
    } catch (e) {
      print(e.toString());
      return null;
    }
       

    
    
  }

  Future<List<GrupList>> getGrupList() async {    
    final db = await database;  
    List<GrupList> list=<GrupList>[];

    final res = await db.rawQuery("Select Distinct Case When ifnull(grup_adi1,'')='' Then 'BOŞ' Else grup_adi1 End as grup_adi1, " +
      "Case When ifnull(grup_adi2,'')='' Then 'BOŞ' Else grup_adi2 End as grup_adi2 " +
      "from malzeme Order By Case When ifnull(grup_adi1,'')='' Then 'BOŞ' Else grup_adi1 End ");
      list = res.isNotEmpty ? res.map((c) => GrupList.fromJson(c)).toList() : [];

    return list;
    
  }

  Future<List<GrupAdi>> getMMGrupList() async {    
    final db = await database;    
    List<GrupAdi> list=<GrupAdi>[];

    final res = await db.rawQuery("Select Distinct Case When ifnull(grup_adi1,'')='' Then 'BOŞ' Else grup_adi1 End as grupadi "+
    "from malzeme Order By Case When ifnull(grup_adi1,'')='' Then 'BOŞ' Else grup_adi1 End");

    list = res.isNotEmpty ? res.map((c) => GrupAdi.fromJson(c)).toList() : [];

    return list;
    
  }

  Future<List<GrupListAll>> getGrupListAll() async {    
    final db = await database;  
    List<GrupListAll> list=<GrupListAll>[];

    final res = await db.rawQuery("Select Distinct Case When ifnull(grup_adi1,'')='' Then 'BOŞ' Else grup_adi1 End as grup_adi1, " +
      "Case When ifnull(grup_adi2,'')='' Then 'BOŞ' Else grup_adi2 End as grup_adi2," +
      "Case When ifnull(grup_adi3,'')='' Then 'BOŞ' Else grup_adi3 End as grup_adi3 " +
      "from malzeme Order By Case When ifnull(grup_adi1,'')='' Then 'BOŞ' Else grup_adi1 End, Case When ifnull(grup_adi2,'')='' Then 'BOŞ' Else grup_adi2 End ");
      
      list = res.isNotEmpty ? res.map((c) => GrupListAll.fromJson(c)).toList() : [];

    return list;
    
  }


  Future<double> getMMAnaliziMusCount() async {
    final db = await database;
    final res = await db.rawQuery("SELECT Count(distinct a.musteri_kodu) as kayit_sayisi FROM MusteriMalAnalizi a ");

    var dbItem = res.first;
    int kayitsayisi = dbItem['kayit_sayisi'] as int;

    return double.parse(kayitsayisi.toString());
  }

  



  Future<List<MusteriToplamlari>> getMusteriMalAnaliziToplam() async {
    RaporController _controller = Get.find();
    
    String sql="SELECT Max(a.musteri_kodu) as cari_kodu, Max(t.unvan) as unvan, "+
    "Sum(a.satis_miktari) as toplamSMiktar, Sum(a.satis_kdv_oncesi_tutar) as toplamSTutar,"+
    "Sum(a.iade_miktari) as toplamIMiktar, Sum(a.iade_kdv_oncesi_tutar) as toplamITutar,"+
    "Sum(a.net_miktar) as toplamNMiktar, Sum(a.net_kdv_oncesi_tutar) as toplamKdvsiz " +
    "FROM MusteriMalAnalizi as a,Cari as t Where t.kod=a.musteri_kodu ";

    if (_controller.mgrup1.value!="TÜMÜ")
    {
      sql=sql + "And a.grup_adi1='"+_controller.mgrup1.value + "' ";
    }
    if (_controller.mgrup2.value!="TÜMÜ")
    {
      sql=sql + "And a.grup_adi2='"+_controller.mgrup2.value + "' ";
    }
    if (_controller.musteriAdi.value!="TÜMÜ" )
    {
      sql=sql + "And t.unvan='"+_controller.musteriAdi.value + "' ";
    }
    else
    {
      if (_controller.rut.value=="TÜMÜ")
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_kodu) ";
      else
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_kodu And t.gun='"+ _controller.rut.value +"') ";
    }
    
    if (_controller.tarih1Controller.text!="")
      sql=sql + "And a.tarih>='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih1Controller.text).toString() + "' ";
    else
      sql=sql + "And a.tarih>='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih1.toString()).toString() + "' ";

    if (_controller.tarih2Controller.text!="")
      sql=sql + "And a.tarih<='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih2Controller.text).toString() + "' ";
    else
      sql=sql + "And a.tarih<='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih2.toString()).toString() + "' ";

    sql=sql +  "Order By a.musteri_kodu, a.tarih, a.r_sayac ";

    final db = await database;
    final res = await db.rawQuery(sql);

    List<MusteriToplamlari> list =
        res.isNotEmpty ? res.map((c) => MusteriToplamlari.fromJson(c)).toList() : [];
        
    return list;

  }

  caribulkInsert(List<Cari> newCari) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (Cari item in newCari) {
        batch.insert('Cari', item.toJson());
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Cari Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.error);
    }
    
  }

  insertbulkSatisTipi(List<SatisTipi> newSatisTipi) async {    
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (SatisTipi item in newSatisTipi) {
        batch.insert('SatisTipleri', item.toJson());
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'SatisTipi Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkTanimlar(List<Tanimlar> tanims) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (Tanimlar item in tanims) {
        batch.insert('Tanimlar', item.toJson());
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Tanimlar Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertbulkKasa(List<Kasa> kasas) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (Kasa item in kasas) {
        batch.insert('Kasa', item.toJson());
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Kasa Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkZiyaretTipleri(List<ZiyaretTipleri> ziyarets) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (ZiyaretTipleri item in ziyarets) {
        batch.insert('ZiyaretTipleri', item.toJson());
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'ZiyaretTipleri Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkZiyaretSonlandirmaTipleri(List<ZiyaretSonlandirmaTipleri> ziyaretStipleri) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (ZiyaretSonlandirmaTipleri item in ziyaretStipleri) {
        batch.insert('ZiyaretSonlandirmaTipleri', item.toJson());
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'ZiyaretSonlandirmaTipleri Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkMalzeme(List<Malzeme> malzemes) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (Malzeme item in malzemes) {
        batch.insert('Malzeme', item.toJson());
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Malzeme Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkBirimCevrimi(List<BirimCevrimi> birimcevrimis) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (BirimCevrimi item in birimcevrimis) {
        batch.insert('BirimCevrimi', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'BirimCevrimi Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }
    
  }

  insertBulkCariAylikSatis(List<CariAylikSatis> cariSatislar) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (CariAylikSatis item in cariSatislar) {
        batch.insert('CariAylikSatis', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'CariAylikSatis Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkCariHesapEkstresi(List<CariHesapEkstresi> cariEkstres) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (CariHesapEkstresi item in cariEkstres) {
        batch.insert('CariHesapEkstresi', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'CariHesapEkstresi Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkCariVadeFarki(List<CariVadeFarki> vadefarklari) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (CariVadeFarki item in vadefarklari) {
        batch.insert('CariVadeFarki', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'CariVadeFarki Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }
  }

  insertBulkSatisFiyatlari(List<SatisFiyatlari> satisFiyatlar) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (SatisFiyatlari item in satisFiyatlar) {
        batch.insert('SatisFiyatlari', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'SatisFiyatlari Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkRSatisFiyatlari(List<SatisFiyatlari> satisFiyatlar) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (SatisFiyatlari item in satisFiyatlar) {
        batch.insert('StokFiyatListesi', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'StokFiyatListesi Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }


  insertBulkBekleyenSiparis(List<BekleyenSiparis> bekleyenSiparisler) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (BekleyenSiparis item in bekleyenSiparisler) {
        batch.insert('BekleyenSiparis', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'BekleyenSiparis Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkAllBekleyenSiparis(List<BekleyenSiparis> bekleyenSiparisler) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (BekleyenSiparis item in bekleyenSiparisler) {
        batch.insert('AllBekleyenSiparis', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'AllBekleyenSiparis Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkKampanya(List<Kampanya> kampanyalar) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (Kampanya item in kampanyalar) {
        batch.insert('Kampanya', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Kampanya Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkKampanyaBedelsizSatir(List<KampanyaBedelsizSatir> kampanyaBedelsizSatirlar) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (KampanyaBedelsizSatir item in kampanyaBedelsizSatirlar) {
        batch.insert('KampanyaBedelsizSatir', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'KampanyaBedelsizSatir Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }


  }

  insertBulkKampanyaBedelsizVerilen(List<KampanyaBedelsizVerilen> kampanyaBedelsizVerilenler) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (KampanyaBedelsizVerilen item in kampanyaBedelsizVerilenler) {
        batch.insert('KampanyaBedelsizVerilen', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'KampanyaBedelsizVerilen Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  insertBulkKampanyaYuzdeselSatir(List<KampanyaYuzdeselSatir> kampanyaYuzdeselSatirlar) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (KampanyaYuzdeselSatir item in kampanyaYuzdeselSatirlar) {
        batch.insert('KampanyaYuzdeselSatir', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'KampanyaYuzdeselSatir Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }
  }

  insertBulkKampanyaSecimliGruplar(List<KampanyaSecimliGruplar> kampanyaSecimliGruplar) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (KampanyaSecimliGruplar item in kampanyaSecimliGruplar) {
        batch.insert('KampanyaSecimliGruplar', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'KampanyaSecimliGruplar Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }
  }

  insertBulkMusteriMalAnalizi(List<MusteriMalAnalizi> mmAnalizleri)async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (MusteriMalAnalizi item in mmAnalizleri) {
        batch.insert('MusteriMalAnalizi', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'MusteriMalAnalizi Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }


  }

  insertBulkAcikHesapListesi(List<AcikHesapListesi> acikHesap) async {
     try {
      final db = await database;

      final Batch batch = db.batch();
      for (AcikHesapListesi item in acikHesap) {
        batch.insert('AcikHesapListesi', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'AcikHesapListesi Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  Future<List<AcikHesapListesi>> getAcikHesapListesi() async {
    RaporController _controller = Get.find();


    String sql="SELECT a.* FROM AcikHesapListesi as a Where 1=1  ";
   
    if (_controller.musteriAdi.value!="TÜMÜ" )
    {
      sql=sql + "And a.cari_unvan='"+_controller.musteriAdi.value + "' ";
    }
    else
    {
      if (_controller.rut.value=="TÜMÜ")
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.cari_kodu) ";
      else
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.cari_kodu And t.gun='"+ _controller.rut.value +"') ";
    }

    if (_controller.tarih1Controller.text!="")
      sql=sql + "And a.fis_tarihi>='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih1Controller.text).toString() + "' ";
    else
      sql=sql + "And a.fis_tarihi>='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih1.toString()).toString() + "' ";

    if (_controller.tarih2Controller.text!="")
      sql=sql + "And a.fis_tarihi<='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih2Controller.text).toString() + "' ";
    else
      sql=sql + "And a.fis_tarihi<='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih2.toString()).toString() + "' ";
        
    sql=sql + "Order By a.cari_kodu,a.borc_alacak,a.vade_tarihi,a.Id ";

      
    final db = await database;
    final res = await db.rawQuery(sql);

    List<AcikHesapListesi> list =
        res.isNotEmpty ? res.map((c) => AcikHesapListesi.fromJson(c)).toList() : [];

    return list;
  }




  insertBulkGunlukTahsilat(List<GunlukTahsilat> gunlukTahsilat) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (GunlukTahsilat item in gunlukTahsilat) {
        batch.insert('GunlukTahsilat', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'GunlukTahsilat Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }
  
  Future<List<GrupAdi>> getDepoList() async {
    final db = await database;
    final res = await db.rawQuery("SELECT a.depo_adi as grupadi FROM GunlukSiparis as a Order BY depo_adi ");
    List<GrupAdi> list =
        res.isNotEmpty ? res.map((c) => GrupAdi.fromJson(c)).toList() : [];
    return list;

  }


  Future<List<GunlukSiparisToplam>> getGunlukSiparisToplam() async {
    RaporController _controller = Get.find();
    
    String sql="SELECT Sum(a.satir_tutari) as toplamTutar, Sum(a.Miktar) as toplamMiktar FROM GunlukSiparis as a  Where 1=1  ";

    if (_controller.mgrup1.value!="TÜMÜ")
    {
      sql=sql + "And a.grup_adi1='"+_controller.mgrup1.value + "' ";
    }
    if (_controller.mgrup2.value!="TÜMÜ" )
    {
      sql=sql + "And a.grup_adi2='"+_controller.mgrup2.value + "' ";
    }

    if (_controller.depo.value!="TÜMÜ" )
    {
      sql=sql + "And a.depo_adi='"+_controller.depo.value + "' ";
    }


    final db = await database;
    final res = await db.rawQuery(sql);

     List<GunlukSiparisToplam> result =
        res.isNotEmpty ? res.map((c) => GunlukSiparisToplam.fromJson(c)).toList() : [];

    return result;
  }



  Future<List<double>> getGunlukTahsilatToplam() async {
    RaporController _controller = Get.find();
    List<double> result=<double>[];

    String sql="SELECT Sum(a.tl_alacak) as tl_alacak FROM GunlukTahsilat as a Where 1=1  ";
   
    if (_controller.musteriAdi.value!="TÜMÜ" )
    {
      sql=sql + "And a.cari_unvan='"+_controller.musteriAdi.value + "' ";
    }
    else
    {
      if (_controller.rut.value=="TÜMÜ")
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.cari_kodu) ";
      else
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.cari_kodu And t.gun='"+ _controller.rut.value +"') ";
    }

    if (_controller.tarih1Controller.text!="")
      sql=sql + "And a.tarih>='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih1Controller.text).toString() + "' ";
    else
      sql=sql + "And a.tarih>='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih1.toString()).toString() + "' ";

    if (_controller.tarih2Controller.text!="")
      sql=sql + "And a.tarih<='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih2Controller.text).toString() + "' ";
    else
      sql=sql + "And a.tarih<='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih2.toString()).toString() + "' ";
        
    

    final db = await database;
    final res = await db.rawQuery(sql);

    var dbItem = res.first;
    double tlalacak = dbItem==null ? 0: dbItem['tl_alacak'] as double;
    tlalacak=tlalacak==null ? 0:tlalacak;

    result.add(tlalacak);

    return result;


  }

  Future<List<GunlukSiparis>> getGunlukSiparis() async {
    RaporController _controller = Get.find();

    String sql="SELECT a.* FROM GunlukSiparis as a Where 1=1  ";

    if (_controller.mgrup1.value!="TÜMÜ")
    {
      sql=sql + "And a.grup_adi1='"+_controller.mgrup1.value + "' ";
    }
    if (_controller.mgrup2.value!="TÜMÜ" )
    {
      sql=sql + "And a.grup_adi2='"+_controller.mgrup2.value + "' ";
    }

    if (_controller.depo.value!="TÜMÜ" )
    {
      sql=sql + "And a.depo_adi='"+_controller.depo.value + "' ";
    }
    
    final db = await database;
    final res = await db.rawQuery(sql);

    List<GunlukSiparis> result =
        res.isNotEmpty ? res.map((c) => GunlukSiparis.fromJson(c)).toList() : [];

    return result;


  }


  Future<List<GunlukTahsilat>> getGunlukTahsilat() async {
    RaporController _controller = Get.find();


    String sql="SELECT a.* FROM GunlukTahsilat as a Where 1=1  ";
   
    if (_controller.musteriAdi.value!="TÜMÜ" )
    {
      sql=sql + "And a.cari_unvan='"+_controller.musteriAdi.value + "' ";
    }
    else
    {
      if (_controller.rut.value=="TÜMÜ")
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.cari_kodu) ";
      else
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.cari_kodu And t.gun='"+ _controller.rut.value +"') ";
    }

    if (_controller.tarih1Controller.text!="")
      sql=sql + "And a.tarih>='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih1Controller.text).toString() + "' ";
    else
      sql=sql + "And a.tarih>='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih1.toString()).toString() + "' ";

    if (_controller.tarih2Controller.text!="")
      sql=sql + "And a.tarih<='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih2Controller.text).toString() + "' ";
    else
      sql=sql + "And a.tarih<='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih2.toString()).toString() + "' ";
        
    sql=sql + "Order By a.tarih, a.fis_no ";

    final db = await database;
    final res = await db.rawQuery(sql);

    List<GunlukTahsilat> list =
        res.isNotEmpty ? res.map((c) => GunlukTahsilat.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<BekleyenSiparis>> getAllBekleyenSiparis() async {
    RaporController _controller = Get.find();
    String grupadi="";

    if (_controller.grupkullan.value==1) grupadi="a.grup_adi1";
    if (_controller.grupkullan.value==2) grupadi="a.grup_adi2";
    if (_controller.grupkullan.value==3) grupadi="a.grup_adi3";

    String sql="SELECT a.*, a.malzeme_adi, Case When ifnull($grupadi,'')='' Then 'BOŞ' Else $grupadi End as grupadi "+
    "FROM AllBekleyenSiparis as a Where 1=1  ";

    if (_controller.mgrup1.value!="TÜMÜ")
    {
      sql=sql + "And a.grup_adi1='"+_controller.mgrup1.value + "' ";
    }
    if (_controller.mgrup2.value!="TÜMÜ" )
    {
      sql=sql + "And a.grup_adi2='"+_controller.mgrup2.value + "' ";
    }

    if (_controller.musteriAdi.value!="TÜMÜ" )
    {
      sql=sql + "And a.unvan='"+_controller.musteriAdi.value + "' ";
    }
    else
    {
      if (_controller.rut.value=="TÜMÜ")
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_no) ";
      else
        sql=sql + "And Exists(SELECT t.kod FROM CariRut t WHERE t.kod=a.musteri_no And t.gun='"+ _controller.rut.value +"') ";
    }

    if (_controller.tarih1Controller.text!="")
      sql=sql + "And a.siparis_tarihi>='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih1Controller.text).toString() + "' ";
    else
      sql=sql + "And a.siparis_tarihi>='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih1.toString()).toString() + "' ";

    if (_controller.tarih2Controller.text!="")
      sql=sql + "And a.siparis_tarihi<='" + DateFormat('dd-MM-yyyy').parse(_controller.tarih2Controller.text).toString() + "' ";
    else
      sql=sql + "And a.siparis_tarihi<='" + DateFormat('yyyy-MM-dd').parse(_controller.tarih2.toString()).toString() + "' ";
        
    sql=sql + "Order By a.siparis_no desc, a.r_sayac ";

    final db = await database;
    final res = await db.rawQuery(sql);
    
    List<BekleyenSiparis> list =
        res.isNotEmpty ? res.map((c) => BekleyenSiparis.fromJson(c)).toList() : [];

    return list;


  }

  Future<List<ZiyaretSonlandirmaTipleri>> getSiparisTahsilatKontrol(int ziyaretId) async {
    final db = await database;
    try {

      final res = await db.rawQuery("Select (Select count(android_gps_sayac) from Tahsilat Where android_gps_sayac=?) as tahsilat_sayisi, " +
      " (Select count(android_gps_sayac) from Siparis Where android_gps_sayac=?) as siparis_sayisi ", [ziyaretId, ziyaretId]);

      var dbItem = res.first;
      int siparissayisi = dbItem==null ? 0: dbItem['siparis_sayisi'] as int;
      int tahsilatsayisi = dbItem==null ? 0: dbItem['tahsilat_sayisi'] as int;

      siparissayisi=siparissayisi==null ? 0:siparissayisi;

      if (siparissayisi>0 || tahsilatsayisi>0)
      {
        if (siparissayisi>0 && tahsilatsayisi>0)
        {
          final res2 = await db.rawQuery("Select * from ZiyaretSonlandirmaTipleri Where sira=5 And auto=1");
            List<ZiyaretSonlandirmaTipleri> list =
              res2.isNotEmpty ? res2.map((c) => ZiyaretSonlandirmaTipleri.fromJson(c)).toList() : [];
            return list;
        }
        else
        {
          if (siparissayisi>0)
          {
            final res2 = await db.rawQuery("Select * from ZiyaretSonlandirmaTipleri Where sira=1 And auto=1");
            List<ZiyaretSonlandirmaTipleri> list =
              res2.isNotEmpty ? res2.map((c) => ZiyaretSonlandirmaTipleri.fromJson(c)).toList() : [];

            return list;
          }
          else
          {
            final res2 = await db.rawQuery("Select * from ZiyaretSonlandirmaTipleri Where sira=7 And auto=1");
            List<ZiyaretSonlandirmaTipleri> list =
              res2.isNotEmpty ? res2.map((c) => ZiyaretSonlandirmaTipleri.fromJson(c)).toList() : [];

            return list;

          }
        }       

      }
      else
      {
        final res2 = await db.rawQuery("Select * from ZiyaretSonlandirmaTipleri Where IFNULL(auto,0)=0 Order By sira");
        List<ZiyaretSonlandirmaTipleri> list =
          res2.isNotEmpty ? res2.map((c) => ZiyaretSonlandirmaTipleri.fromJson(c)).toList() : [];

        return list;
      }      
    } catch (e) {
      print(e.toString());
      return null;
    }
    

  }

  Future<int> getZiyaretSonlandirmaTipiSayac(String ziyaretSonlandirmaTipi) async {
  final TahsilatController _controller = Get.find();

    final db = await database;
    final res = await db.rawQuery("Select r_sayac, zorunlu_aciklama from ZiyaretSonlandirmaTipleri Where tipi=?", [ziyaretSonlandirmaTipi]);

    var dbItem = res.first;
    int sayac = dbItem==null ? 0: dbItem['r_sayac'] as int;
    sayac=sayac==null ? 0:sayac;

    int zorunluaciklama = dbItem==null ? 0: dbItem['zorunlu_aciklama'] as int;
    zorunluaciklama=zorunluaciklama==null ? 0:zorunluaciklama;
    _controller.zorunluaciklama.value=zorunluaciklama;

    return sayac;

  }

  Future<int> updateAktarilanZiyaretler(List<Ziyaret> updateZiyaret) async {
    try {
      final db = await database;

      await Future.forEach(updateZiyaret, (Ziyaret ziyaret) async{
        await db.rawUpdate("Update Ziyaret Set aktarildi=1 Where id=?", [ziyaret.id]);
      });

      return 1;

    } catch (e) {
      print(e.toString());
      snackbar("Hata",'Ziyaret Tablosu güncellenemedi.' + e.toString().substring(0,100), Icons.error);
      return 0;
    }

  }

  insertBulkGunlukSiparis(List<GunlukSiparis> gunlukSiparisler) async {
    try {
      final db = await database;

      final Batch batch = db.batch();
      for (GunlukSiparis item in gunlukSiparisler) {
        batch.insert('GunlukSiparis', item.toJson());
      }      
      await batch.commit(noResult: true);
    } catch (e) {
      print(e.toString());
      snackbar("Hata",'GunlukSiparis Tablosuna insert edilemedi.' + e.toString().substring(0,100), Icons.person);
    }

  }

  


  
  


}
