import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdrmobil/Screens/Program/components/dash_board.dart';
import 'package:sdrmobil/models/Satis/satis_chart.dart';
import 'package:sdrmobil/models/tanimlar.dart';
import 'package:sdrmobil/providers/db_provider.dart';

class ProgramBody extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return futureBuilderSorgu();
  }
  futureBuilderSorgu() {   

  List<Tanimlar> tanimlar = <Tanimlar>[];
  List<SatisChart> satischart = <SatisChart>[];
  // List<Siparis> siparisler = <Siparis>[];
  // List<Tahsilat> tahsilatlar= <Tahsilat>[];

  String planlananZiyaret;
  String rutIcigidilen;
  String rutIcigidilmeyen;
  String rutDisigidilen;
  String imageUrl;
  String temsilcifotopath;
  String temsilciAdi;
  String firmaAdi;
  double gunlukSiparisTutar = 0;
  double gunlukFaturaTutar = 0;
  double gunlukTahsilatTutar = 0;
  Map<String, double> ziyaretOzetDataMap;  

    return FutureBuilder(
        future: Future.wait([
          dataDoldurTanimlar(),
          dataDoldurSatislar(),
          // getSiparisTumList(),
          // getAllTahsilat()
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            tanimlar = snapshot.data[0];
            satischart = snapshot.data[1];
            // siparisler= snapshot.data[2];
            // tahsilatlar= snapshot.data[3];

            planlananZiyaret = tanimlar
                .firstWhere((pz) =>
                    pz.groupname == "TemsilciHareketleri" &&
                    pz.key == "planlananZiyaret")
                .value
                .toString();

            rutIcigidilen = tanimlar
                .firstWhere((rig) =>
                    rig.groupname == "TemsilciHareketleri" &&
                    rig.key == "rutIcigidilen")
                .value
                .toString();

            rutIcigidilmeyen =
                (int.parse(planlananZiyaret) - int.parse(rutIcigidilen))
                    .toString();

            rutDisigidilen = tanimlar
                .firstWhere((rdg) =>
                    rdg.groupname == "TemsilciHareketleri" &&
                    rdg.key == "rutDisigidilen")
                .value
                .toString();
          
            ziyaretOzetDataMap = {
              "Planlanan:" + planlananZiyaret: double.parse(planlananZiyaret),
              "Gerçekleşen:" + rutIcigidilen: double.parse(rutIcigidilen),
              "Gerçekleşmeyen:" + rutIcigidilmeyen:
                  double.parse(rutIcigidilmeyen),
              "Rutdışı:" + rutDisigidilen: double.parse(rutDisigidilen),
            };

            imageUrl = "";

            temsilcifotopath = tanimlar
                .firstWhere((tfp) =>
                    tfp.groupname == "Temsilci" &&
                    tfp.key == "temsilci_foto_path")
                .value
                .toString();

            imageUrl = tanimlar
                    .firstWhere((iurl) =>
                        iurl.groupname == "Genel" &&
                        iurl.key == "android_resim_base_url")
                    .value
                    .toString() +
                "Temsilciler/";

            if (temsilcifotopath != "" && temsilcifotopath != null) {
              imageUrl = imageUrl + temsilcifotopath;
            } else {
              imageUrl = "";
            }

            temsilciAdi = tanimlar
                .firstWhere((temdi) =>
                    temdi.groupname == "Temsilci" &&
                    temdi.key == "temsilci_adi")
                .value
                .toString();

            firmaAdi = tanimlar
                .firstWhere((frmadi) =>
                    frmadi.groupname == "Firma" && frmadi.key == "firmaunvani")
                .value
                .toString();

            gunlukSiparisTutar = 0;
            satischart
                .forEach((sip) => gunlukSiparisTutar += sip.gunlukSiparisTutar);
            // siparisler
            //     .forEach((sip) => gunlukSiparisTutar += sip.toplamtutar);

            gunlukFaturaTutar = 0;
            satischart
                .forEach((fat) => gunlukFaturaTutar += fat.gunlukFaturaTutar);


            gunlukTahsilatTutar = 0;
            satischart.forEach(
                (tah) => gunlukTahsilatTutar += tah.gunlukTahsilatTutar);

            // tahsilatlar.forEach(
            //     (tah) => gunlukTahsilatTutar += tah.fiyat);
                

          return DashBoard(context: context,firmaAdi: firmaAdi,gunlukFaturaTutar: gunlukFaturaTutar,
            gunlukSiparisTutar: gunlukSiparisTutar, gunlukTahsilatTutar:gunlukTahsilatTutar, imageUrl: imageUrl,
            satischart: satischart,temsilciAdi: temsilciAdi,ziyaretOzetDataMap: ziyaretOzetDataMap,
            );
          } 
          else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(color: Color(0xff009068)));
          else if (snapshot.hasError)
            return Text("ERROR: ${snapshot.error}");
          else
            return Center(
              child: CircularProgressIndicator(color: Color(0xff009068),),
            );
        });
  }

}


Future dataDoldurTanimlar() async {
  return await DBProvider.db.getAllTanimlar();
}

Future dataDoldurSatislar() async {
  return await DBProvider.db.getChartSatis();
}

Future getSiparisTumList() async {
  return await DBProvider.db.getSiparisTumList();
}

Future getAllTahsilat() async {
  return await DBProvider.db.getAllTahsilat();
}


class PieData {
  PieData(this.xData, this.yData);
  final String xData;
  final double yData;
}