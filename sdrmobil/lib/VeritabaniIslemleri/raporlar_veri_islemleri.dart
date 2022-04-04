
import 'package:get/get.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/providers/table_api_provider.dart';

class RaporVeriIslemleri {
  loadFromApi() {
    final Controller _controller = Get.find();

    String url = _controller.firmaurl.value;
    String temsilci = _controller.temsilcikodu.value;
    String veritabani = _controller.veritabaniadi.value;
    _controller.hata.value = "";

    var mmAnaliz = TableApiProvider(url, temsilci, veritabani, null);
    mmAnaliz.getMusteriMalAnalizi(); //rapor olduğu için takip etmeye gerek yok.

    var acikHesap = TableApiProvider(url, temsilci, veritabani, null);
    acikHesap.getAcikHesapListesi();


    var gunlukTahsilat = TableApiProvider(url, temsilci, veritabani, null);
    gunlukTahsilat.getGunlukTahsilat();

    var getAllBSiparis = TableApiProvider(url, temsilci, veritabani, null);
    getAllBSiparis.getAllBekleyenSiparis();

    var gunlukSiparis = TableApiProvider(url, temsilci, veritabani, null);
    gunlukSiparis.getGunlukSiparis();


    var stokFiyatListesi = TableApiProvider(url, temsilci, veritabani, null);
    stokFiyatListesi.getStokFiyatListesi();
        

  }

}
