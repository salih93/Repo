import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:sdrmobil/Screens/Siparis/siparisler.dart';
import 'package:sdrmobil/Screens/Ziyaret/cari_hareket.dart';
import 'package:sdrmobil/Screens/Ziyaret/ziyaret_baslat.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/models/Satis/rut_listesi.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret.dart';
import 'package:sdrmobil/providers/db_provider.dart';

//maca yansıt
class ZiyaretGunleri extends StatelessWidget {  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Controller _controller = Get.find();    

    return FutureBuilder<List<YeniListe>>(              
      future:!_controller.isSearching.value ? _controller.dataDoldur():_controller.filterCari(_controller.carifilter.value),              
      builder: (BuildContext context, AsyncSnapshot<List<YeniListe>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            semanticChildCount: snapshot.data.length,                      
            itemBuilder: (context, index) {
              YeniListe item ;
              item = snapshot.data[index];

              return DataPopUp(item, size, context);

            },
          );
        } else if (snapshot.hasError) {
          return Text('Error');
        } else {
          //return Text('');
          return Center(child:CircularProgressIndicator(color: Color(0xff009068),),);
        }
      },                
    );

  }
}


class DataPopUp extends StatelessWidget {
  const DataPopUp(this.popup, this.size, this.context);

  final YeniListe popup;
  final Size size;
  final BuildContext context;

  Widget _buildTiles(
    YeniListe root, Key key) 
  {
    if (root.children.isEmpty) return ListTile(title: Text(root.gun, style: TextStyle(fontSize: size.height * kZiyaretGunleriOranBaslik),),
      );

    return Card(
      child: ExpansionTile(
        //initiallyExpanded: true,
        key: PageStorageKey<YeniListe>(root),
        title: Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Text(
                  root.gun,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: size.height * kZiyaretGunleriOranBaslik),
                )),
            Expanded(
                flex: 1,
                child: Text(
                  root.noktasayisi.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: size.height * kZiyaretGunleriOranBaslik),
                )),
          ],
        ),

        children: _detayListBuilderListWidget(root, context),
      ),
    );
  }

   _detayListBuilderListWidget(YeniListe d, BuildContext context) {    
    List<Widget> columnContent = [];
    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);

    Color aktifmusterirengi = Colors.black;
    
    final Controller _controller = Get.find();
  
    
    var slideController = SlidableController();

    d.children.forEach((element) {
      element.aktif == 1
          ? aktifmusterirengi = Colors.blue
          : aktifmusterirengi = Colors.orange;

      columnContent.add(
        InkWell(
          onTap: (){
            if (slideController?.activeState == null)
            {
              if (Slidable.of(context)!=null)  
                Slidable.of(context).open(actionType: SlideActionType.secondary);
            }                
            else
            {
              if (Slidable.of(context)!=null)
                Slidable.of(context).close();
            }            
          },
          
          child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          controller: slideController,
          actionExtentRatio: 0.25,
          closeOnScroll: true,
          child: ListTile(
            //tileColor: element.ziyaretSayisi>0 ? Color(0xff009068):Colors.white,            
            onTap: () {
              if (slideController?.activeState == null)
              {
                if (Slidable.of(context)!=null)  
                  Slidable.of(context).open(actionType: SlideActionType.secondary);
              }                
              else
              {
                if (Slidable.of(context)!=null)
                  Slidable.of(context).close();
              }                
            },

            title: Container(
              child: Text(
                element.unvan,
                style: TextStyle(
                    color: aktifmusterirengi, fontWeight: FontWeight.bold,
                    fontSize: size.height * kZiyaretGunleriOran,
                  ),
                textAlign: TextAlign.left,
              ),
            ),
            trailing: element.ziyaretSayisi>0 && element.gunsira==0 ? 
              Icon(Icons.check_outlined, color:Color(0xff009068)):SizedBox(height: size.height * 0.001,),
            

            subtitle: Wrap(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Sipariş",style: TextStyle(
                            fontSize: size.height * kZiyaretGunleriOran, fontWeight: FontWeight.bold),
                          ),

                          Text(mFormat.format(element.gunlukSiparisTutar) + ' '+format.currencySymbol,style: TextStyle(
                            fontSize: size.height * kZiyaretGunleriOran, color: Colors.blue),
                          ),
                        ],                        
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Fatura",style: TextStyle(
                            fontSize: size.height * kZiyaretGunleriOran, fontWeight: FontWeight.bold),
                          ),

                          Text(mFormat.format(element.gunlukFaturaTutar) + ' '+format.currencySymbol,style: TextStyle(
                            fontSize: size.height * kZiyaretGunleriOran, color: Colors.blue),
                          ),
                        ],                        
                      ),

                      // child: Text(
                      //     "Fatura:  " + element.gunlukFaturaTutar.toString()),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Tahsilat",style: TextStyle(
                            fontSize: size.height * kZiyaretGunleriOran, fontWeight: FontWeight.bold),
                          ),

                          Text(mFormat.format(element.gunlukTahsilatTutar) + ' '+format.currencySymbol,style: TextStyle(
                            fontSize: size.height * kZiyaretGunleriOran, color: Colors.blue),
                          ),
                        ],                        
                      ),

                      // child: Text("Tahsilat:  " +
                      //     element.gunlukTahsilatTutar.toString()),
                    ),
                  ],
                ),

              ],
            ),
          ),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              child: TextButton(
                child: Text(
                  "Müşteri Kartı",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black,
                      fontSize: size.height * kZiyaretGunleriOran),
                ),
                onPressed: () async{
                 if (!await uzaktanProses(element, 0))
                  {
                    return;
                  }
                  
                },
              ),
              color: Colors.grey,
            ),

            Visibility(
              visible: _controller.telefonSiparis.value==1,
              child: Container(
                alignment: Alignment.center,
                child: TextButton(
                  child: Text(
                    "Uzaktan Sipariş",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black, fontSize: size.height * kZiyaretGunleriOran),
                  ),
                  
                  onPressed: () async {
                    
                    if (!await uzaktanProses(element, 1))
                    {
                      return;
                    }
                    
                  },
                ),
                color: Colors.blue,
              ),
            ),

          ],

          secondaryActions: <Widget>[
             
            Container(
              alignment: Alignment.center,
              child: TextButton(
                child: Text(
                  "Yol Tarifi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black, fontSize: size.height * kZiyaretGunleriOran),
                ),
                onPressed: () {
                  element.enlem.isEmpty || element.boylam.isEmpty
                      ? snackbar("Hata", "Enlem yada boylam bilgisi alınamadı.",
                          Icons.error)
                      : openMapsSheet(context, double.parse(element.enlem),
                          double.parse(element.boylam), element.unvan);
                },
              ),
              color: Colors.grey,
            ),

            Container(
              alignment: Alignment.center,
              child: TextButton(
                child: Text(
                  "Ziyaret Başlat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black, fontSize: size.height * kZiyaretGunleriOran),
                ),
                
                onPressed: () {
                  if(_controller.ziyaretId.value>0)
                  {
                    snackbar("uyarı", "Önce aktif ziyaretinizi sonlandırmalısınız.", Icons.error);
                    return;
                  }

                  if (element.kod.isEmpty)
                  {
                    snackbar("Hata", "cari kod alınamadı.", Icons.error);
                    return;
                  }
                  if (_controller.rutaGore.value==1)
                  {
                    if (d.bugun!=1)
                    {
                      snackbar("Uyarı", "Sadece rut içi ziyaret yapabilirsiniz.", Icons.error);
                      return;
                    }                    
                  }

                  _controller.faturatoplam.value=element.gunlukFaturaTutar;
                  _controller.siparistoplam.value=element.gunlukSiparisTutar;
                  _controller.tahsilattoplam.value=element.gunlukTahsilatTutar;
                  _controller.rutdetaysayac.value=element.rutDetaySayac;
                  DateTime date = DateTime.now();                  
                  _controller.rutdetaygun.value=element.gunsira + date.weekday;

                  _controller.carikod.value=element.kod.toString();
                  _controller.mesafe.value="";
                  _controller.rut.value=element;
                  if (element.enlem!=null && element.enlem!="")
                    _controller.enlem.value=double.parse(element.enlem);
                  else
                    _controller.enlem.value=0.0;

                  if (element.boylam!=null && element.boylam!="")  
                    _controller.boylam.value=double.parse(element.boylam);
                  else
                    _controller.boylam.value=0.0;
                  _controller.update();

                  Get.to(()=>ZiyaretBaslat());                  
                },
              ),
              color: Colors.blue,
            ),
          
          ],
        ),
        ),
      );
    });

    return columnContent;
  }

  Future<bool> uzaktanProses(RutListesi element, int uzaktanSiparis) async
  {
    final Controller _controller = Get.find();

    if (element.kod.isEmpty)
    {
      snackbar("Hata", "cari kod alınamadı.", Icons.error);
      return false;
    }
    
    if(_controller.ziyaretId.value>0)
    {
      Ziyaret ziyaret=await DBProvider.db.getZiyaretId(_controller.ziyaretId.value);
      if (ziyaret.carikodu.toLowerCase()==element.kod.toLowerCase())
      {
        if (uzaktanSiparis==1)
          snackbar("Hata", "Bu müşteri için ziyaret başlatılmış. Uzaktan sipariş başlatılamaz.", Icons.error);
        else
          snackbar("Hata", "Bu müşteri için ziyaret başlatılmış. Müşteri kartına ziyaretten gidebilirsiniz.", Icons.error);
          
        return false;
      }
    }

    

    _controller.uzaksiparis.value=uzaktanSiparis;                  
    _controller.musteriKarti.value=(uzaktanSiparis==0 ? 1:0);
    _controller.faturatoplam.value=element.gunlukFaturaTutar;
    _controller.siparistoplam.value=element.gunlukSiparisTutar;
    _controller.tahsilattoplam.value=element.gunlukTahsilatTutar;
    _controller.rutdetaysayac.value=element.rutDetaySayac;
    DateTime date = DateTime.now();                  
    _controller.rutdetaygun.value=element.gunsira + date.weekday;

    _controller.carikod.value=element.kod.toString();
    _controller.mesafe.value="";
    _controller.rut.value=element;
    if (element.enlem!=null && element.enlem!="")
      _controller.enlem.value=double.parse(element.enlem);
    else
      _controller.enlem.value=0.0;

    if (element.boylam!=null && element.boylam!="")  
      _controller.boylam.value=double.parse(element.boylam);
    else
    _controller.boylam.value=0.0;
    _controller.update();

    if (uzaktanSiparis==0)
    {
      Get.to(()=> CariHareket());
    }
    else
    {
      await _controller.bekleyenSiparisGruplu();
      Get.to(()=>Siparisler());
    }

    _controller.startProgress();
    if (await _controller.girisIslemleri(_controller.carikod.value)!=true)
    {
      _controller.stopProgress(context);
      snackbar("Hata", _controller.hata.value.toString(), Icons.error);
      return false;
    }
    _controller.stopProgress(context);    
    return true;
    
  }

  openMapsSheet(contextim, double enlem, double boylam, String unvan) async {
    try {
      final coords = Coords(enlem, boylam);
      final title = unvan;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: contextim,
        builder: (BuildContext contexts) {
          return GestureDetector(
            onTap: () =>
                Navigator.of(contexts).pop(), // closing showModalBottomSheet
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Wrap(
                    children: <Widget>[
                      for (var map in availableMaps)
                        ListTile(
                          onTap: () {
                            map.showMarker(
                              zoom: 100,
                              coords: coords,
                              title: title,
                            );
                            Navigator.of(contexts).pop(); //modal kapatmak için
                          },
                          title: Text(map.mapName),                          
                          leading: SvgPicture.asset(
                            map.icon,
                            height: 30.0,
                            width: 30.0,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(popup, key);
  }
  
}
