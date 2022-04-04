import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/Screens/Program/program.dart';
import 'package:sdrmobil/Screens/Login/login_screen.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/VeritabaniIslemleri/veri_islemleri.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret.dart';
import 'package:sdrmobil/models/aktarim_durumu.dart';
import 'package:sdrmobil/providers/db_provider.dart';
import 'package:flutter/services.dart';

void signIn(String email, String pass, BuildContext context) async {
    final Controller _controller = Get.find();         
    
    var url = Uri.parse("http://sdrmobil.acilimsoft.com/Merkez/user/authenticate");
    //url = Uri.parse("http://192.168.1.51:5001/user/Authenticate");

    Map<String, String> headers = {"Content-type": "application/json"};
    
    String imei;
    String deviceName;
    String productName;
    String deviceModel;
    
      
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
          imei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
          deviceName = build.model;
          deviceModel =build.androidId;
          productName = build.product.toString();
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
          imei = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
          deviceName = data.name;
          productName = data.systemVersion;
          deviceModel = data.identifierForVendor;
      }            
    } on PlatformException {
      print('Failed to get platform version');
    }

    var data = {};
    data["email"] = email.trimRight();
    data["password"] = pass;
    data["versiyon_no"]=kUygulamaVersiyonu;
    data["IMEI"]=imei;
    data["deviceName"]=deviceName;
    data["productName"]=productName;
    data["deviceModel"]=deviceModel;
    
    String _data = json.encode(data);
    _controller.token.value="";
    
    _controller.startProgress();

    _controller.menuGoruntule.value=0;
    _controller.pass.value="";
    _controller.email.value="";

    if (_controller.boxStorage.value.read('beniHatirla')==0)
    {
      _controller.boxStorage.value.write("beniHatirla", 0);      
      _controller.boxStorage.value.write("password", "");      
      _controller.passwordController.text="";
    }
    
    var response = await post(url, 
      headers: headers,
       body: _data);

    

    if (response.statusCode == 200) {
      // ignore: avoid_init_to_null
      var jsonResponse = null; 
      _controller.pass.value=pass;
      _controller.email.value=email;

      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {        
                    
          var token=jsonResponse['token'].toString();
          _controller.token.value= token;
          _controller.menuGoruntule.value=0;          
          _controller.userid.value=jsonResponse['id'].toString();                    
          _controller.firmaid.value=jsonResponse['firma_id'].toString();
          _controller.firmaadi.value=jsonResponse['firma_adi'].toString();
          _controller.firmaurl.value=jsonResponse['firma_url'].toString();
          _controller.veritabaniadi.value=jsonResponse['veritabani_adi'].toString();
          _controller.temsilcikodu.value=jsonResponse['temsilci_kodu'].toString();

          var versiyonNo=_controller.boxStorage.value.read("versiyon_no").toString();
          versiyonNo = versiyonNo==null ? "" : versiyonNo;
          var kullaniciAdi=_controller.boxStorage.value.read("email").toString();
          kullaniciAdi= kullaniciAdi==null ? "" : kullaniciAdi;

          if ((kullaniciAdi.trim()!=email.trim() && kullaniciAdi!="") || versiyonNo!=kUygulamaVersiyonu)
          {
            _controller.deleteDatabase.value=1;
            _controller.update();
          }
          
          bool bAktar=true;          
          AktarimDurumu aktarimDurumu;
          aktarimDurumu=await DBProvider.db.getAktarimDurumu();
          if (aktarimDurumu!=null)
          {
            if (aktarimDurumu.aktarimtarihi!=null)
            {
              if (DateFormat('yyyy-MM-dd').format(aktarimDurumu.aktarimtarihi)==DateFormat('yyyy-MM-dd').format(DateTime.now())
              && (_controller.deleteDatabase.value==null || _controller.deleteDatabase.value==0))
              {
                bAktar=false;
              }
            }
          }
                   
          if (bAktar || _controller.veritabaniSilindi.value==1)
          {           
            await VeriIslemleri().loadFromApi();            
          }
          else 
          {
            await _controller.getTanimlar();
          }

          if (_controller.tanimList.length>0)
          {
            _controller.temsilciadi.value=
            _controller.tanimList.firstWhere((element) => element.key=="temsilci_adi").value.toString();
          }
                   

          if (_controller.hata.value!="")
          {
            _controller.firmaid.value="";
            _controller.firmaadi.value="";
            _controller.firmaurl.value="";
            _controller.veritabaniadi.value="";
            _controller.temsilcikodu.value="";

            
            _controller.stopProgress(context);
            Get.to(()=>LoginScreen());

            snackbar("Hata", _controller.hata.value, Icons.person);

            _controller.hata.value="";
            return;
          }

          _controller.boxStorage.value.write("versiyon_no", kUygulamaVersiyonu);

          if(_controller.getBeniHatirla())
          {
            _controller.boxStorage.value.write("beniHatirla", 1);              
            _controller.boxStorage.value.write("email", email.trimRight());
            _controller.boxStorage.value.write("password", pass);            
          }
          else
          {
            _controller.boxStorage.value.write("beniHatirla", 0);              
            _controller.boxStorage.value.write("email", email.trimRight()); //kullanıcının değiştiğini anlamak için.
            _controller.boxStorage.value.write("password", "");            
          }

          Ziyaret ziyaret=await DBProvider.db.getActivateZiyaretId();
          int ziyaretId=(ziyaret==null) ? 0:ziyaret.id;          
          _controller.setZiyaretId(ziyaretId);
          
          await _controller.getAktarilmamisZiyaret();              
          _controller.stopProgress(context);
          Get.to(()=>ProgramPage());

        if (bAktar || _controller.veritabaniSilindi.value==1)
        {           
          _controller.veritabaniSilindi.value=0;
          VeriIslemleri().loadFromRaporlar(1);            
        }
                
      }
    } 
    else 
    {
      
      _controller.stopProgress(context);
      
      Get.to(()=>LoginScreen());

      if(response.reasonPhrase!="Not Found")
      {
        var jsonResponse;
        jsonResponse = json.decode(response.body);

        snackbar("Hata",
                jsonResponse['message'],
                Icons.person);      }
      else
      {
        snackbar("Hata",
                url.toString() + " adresine ulaşılamadı. Lütfen sistem yöneticinizle görüşün.",
                Icons.person);
      }

  
    }
  }
  