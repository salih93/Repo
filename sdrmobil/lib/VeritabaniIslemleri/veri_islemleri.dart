import 'package:sdrmobil/VeritabaniIslemleri/raporlar_veri_islemleri.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/models/aktarim_durumu.dart';
import 'package:sdrmobil/providers/db_provider.dart';
import 'package:sdrmobil/providers/table_api_provider.dart';
import 'package:get/get.dart';
class VeriIslemleri {
  Future<bool> loadFromApi() async {
    final Controller _controller = Get.find();

    String url = _controller.firmaurl.value;
    String temsilci = _controller.temsilcikodu.value;
    String veritabani = _controller.veritabaniadi.value;
    _controller.hata.value = "";

    var tanimlarAPIProvider = TableApiProvider(url, temsilci, veritabani, null);
    if (await tanimlarAPIProvider.getTumTanimlar() == null) {
      print("Tanımlar alınırken hata oluştu");
      _controller.hata.value = "Tanımlar alınırken hata oluştu";
      return false;
    }

    var cariAPIProvider = TableApiProvider(url, temsilci, veritabani, null);
    if (await cariAPIProvider.getAllCariVeRut() == null) {
      print("Cariler alınırken hata oluştu");
      _controller.hata.value = "Cariler alınırken hata oluştu";
      return false;
    }
    await _controller.getAktarilmamisZiyaret();
    await _controller.getTanimlar();
    

    return true;

  }

  void loadFromRaporlar(int resimleriCek) async {
    final Controller _controller = Get.find();

    String url = _controller.firmaurl.value;
    String temsilci = _controller.temsilcikodu.value;
    String veritabani = _controller.veritabaniadi.value;
    _controller.hata.value = "";
    

    if (resimleriCek==1)
    {      
      var picture = TableApiProvider(url, temsilci, veritabani, null);
      picture.getMalzemePicture();
    }          

    if (resimleriCek==1)
    {                    
      RaporVeriIslemleri().loadFromApi();
    }

    AktarimDurumu newAktarim=AktarimDurumu(aktarimtarihi: DateTime.now());
    int res=await DBProvider.db.updateAktarimDurumu(newAktarim);
    if (res==0)
      await DBProvider.db.insertAktarimDurumu(newAktarim);


  }



}
