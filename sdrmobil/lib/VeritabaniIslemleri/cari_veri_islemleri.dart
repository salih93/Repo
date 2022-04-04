import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/providers/db_provider.dart';
import 'package:sdrmobil/providers/table_api_provider.dart';
import 'package:get/get.dart';

class CariVeriIslemleri {
  Future<bool> loadFromApiCari() async {
    Controller _controller = Get.find();

       

    String url = _controller.firmaurl.value;
    String temsilci = _controller.temsilcikodu.value;
    String veritabani = _controller.veritabaniadi.value;
    String carikod = _controller.carikod.value;
    _controller.hata.value = "";

    await DBProvider.db.deleteFrom("Delete from CariHesapEkstresi Where cari_kodu='$carikod'");
    await DBProvider.db.deleteFrom("Delete from CariAylikSatis Where cari_kodu='$carikod'");
    await DBProvider.db.deleteFrom("Delete from CariVadeFarki Where cari_kodu='$carikod'");
    await DBProvider.db.deleteFrom("Delete from SatisFiyatlari Where kod='$carikod'");
    await DBProvider.db.deleteFrom("Delete from BekleyenSiparis Where musteri_no='$carikod'");

    // await DBProvider.db.deleteTable("CariHesapEkstresi");
    // await DBProvider.db.deleteTable("CariAylikSatis");
    //await DBProvider.db.deleteTable("CariVadeFarki");
    //await DBProvider.db.deleteTable("SatisFiyatlari");    
    //await DBProvider.db.deleteTable("BekleyenSiparis"); 
    
    var ayliksatisPro = TableApiProvider(url, temsilci, veritabani, carikod);
    if (await ayliksatisPro.getAllSatislar() == null) {
      print("Aylik listesi alınırken hata oluştu");
      _controller.hata.value = "Aylik listesi alınırken hata oluştu";
      return false;
    }

    var satisFiyatlari = TableApiProvider(url, temsilci, veritabani, carikod);
    if (await satisFiyatlari.getAllFiyatBSiparis() == null) {
      print("Fiyat ve Bekleyen Sipariş Bilgisi Alınamadı.");
      _controller.hata.value = "Fiyat ve Bekleyen Sipariş Bilgisi Alınamadı";
      return false;
    }


    var kampanya = TableApiProvider(url, temsilci, veritabani, carikod);
    if (await kampanya.getKampanya() == null) {
      print("Kampanyalar alınırken hata oluştu");
      _controller.hata.value = "Kampanyalar alınırken hata oluştu";
      return false;
    }


    
    return true;

  }
}




