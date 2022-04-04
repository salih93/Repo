using AutoMapper.Configuration;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Nancy.Json;
using SDRMobilApi.Entities;
using SDRMobilApi.Helpers;
using SDRMobilApi.SDREntities;
using SDRMobilApi.SDRModels;
using SDRMobilApi.SDRServices;
using SDRMobilApi.Services;
using System.Collections.Generic;

namespace SDRMobilApi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class SDRDataController : ControllerBase
    {

        private ISDRService sdrService;
        private IUserService userService;

        public SDRDataController(ISDRService _sdrService, IUserService _userService)
        {
            sdrService = _sdrService;
            userService = _userService;
        }

        //[AllowAnonymous]
        //[HttpPost("GetTanimlar")]
        //public IActionResult GetTanimlar([FromBody] SdrParametreModel model)
        //{            
        //    List<Tanimlar> _tanimlar=new List<Tanimlar>();
        //    _tanimlar= sdrService.GetTanimlar(model);

        //    return Ok(_tanimlar);
        //}


        [AllowAnonymous]
        [HttpPost("GetAllTanimlar")]
        public ValidationResponseList GetAllTanimlar([FromBody] SdrParametreModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            List<string> tanimlar = new List<string>();
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.GetAllTanimlar(model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }
                }
            }

            return vr;
        }

        [AllowAnonymous]
        [HttpPost("GetAllCariVeRut")]
        public ValidationResponseList GetAllCariVeRut([FromBody] SdrParametreModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };

            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.GetAllCariVeRut(model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }
                }
            }            

            return vr;
        }

        [AllowAnonymous]
        [HttpPost("GetAllSatislar")]
        public ValidationResponseList GetAllSatislar([FromBody] SdrParametreModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            if (model.token!=null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token==model.token)
                        vr = sdrService.GetAllSatislar(model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }
                }
                    
            }

            return vr;
        }

        [AllowAnonymous]
        [HttpPost("GetAllFiyatBSiparis")]
        public ValidationResponseList GetAllFiyatBSiparis([FromBody] SdrParametreModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.GetAllFiyatBSiparis(model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }
                }
            }
            return vr;
        }

        //[AllowAnonymous]
        //[HttpPost("GetCariKartlar")]
        //public IActionResult GetCariKartlar([FromBody] SdrParametreModel model)
        //{
        //    List<CariKart> _cariKartlar = new List<CariKart>();
        //    _cariKartlar = sdrService.GetCariKartlar(model);

        //    return Ok(_cariKartlar);
        //}

        //[AllowAnonymous]
        //[HttpPost("GetCariKartSubeler")]
        //public IActionResult GetCariKartSubeler([FromBody] SdrParametreModel model)
        //{
        //    List<CarKartSubeler> carKartSubelers = new List<CarKartSubeler>();
        //    carKartSubelers = sdrService.GetCariKartSubeler(model);

        //    return Ok(carKartSubelers);
        //}

        //[AllowAnonymous]
        //[HttpPost("GetRutTanimi")]
        //public IActionResult GetRutTanimi([FromBody] SdrParametreModel model)
        //{
            
        //    List<RutTanimi> rutTanimlari = new List<RutTanimi>();
        //    rutTanimlari = sdrService.GetRutTanimi(model);

            
        //    return Ok(rutTanimlari);
        //}

        //[AllowAnonymous]
        //[HttpPost("GetKasalar")]
        //public IActionResult GetKasalar([FromBody] SdrParametreModel model)
        //{

        //    List<Kasa> kasalar = new List<Kasa>();
        //    kasalar = sdrService.GetKasalar(model);


        //    return Ok(kasalar);
        //}

        //[AllowAnonymous]
        //[HttpPost("GetAylikSatis")]
        //public IActionResult GetAylikSatis([FromBody] SdrParametreModel model)
        //{

        //    List<AylikSatis> satislar = new List<AylikSatis>();
        //    satislar = sdrService.GetAylikSatis(model);

        //    return Ok(satislar);
        //}


        //[AllowAnonymous]
        //[HttpPost("GetCariHesapEkstresi")]
        //public IActionResult GetCariHesapEkstresi([FromBody] SdrParametreModel model)
        //{

        //    List<CariHesapEkstresi> ekstreler = new List<CariHesapEkstresi>();
        //    ekstreler = sdrService.GetCariHesapEkstresi(model);

        //    return Ok(ekstreler);
        //}

        //[AllowAnonymous]
        //[HttpPost("GetCariVadefarki")]
        //public IActionResult GetCariVadefarki([FromBody] SdrParametreModel model)
        //{

        //    List<CariVadeFarki> vadeFarklar = new List<CariVadeFarki>();
        //    vadeFarklar = sdrService.GetCariVadefarki(model);

        //    return Ok(vadeFarklar);
        //}

        //[AllowAnonymous]
        //[HttpPost("GetSatisTipleri")]
        //public IActionResult GetSatisTipleri([FromBody] SdrParametreModel model)
        //{

        //    List<SatisTipi> SatisTipleri = new List<SatisTipi>();
        //    SatisTipleri = sdrService.GetSatisTipleri(model);

        //    return Ok(SatisTipleri);
        //}

        //[AllowAnonymous]
        //[HttpPost("GetSatisFiyatlari")]
        //public IActionResult GetSatisFiyatlari([FromBody] SdrParametreModel model)
        //{

        //    List<Fiyat> fiyats = new List<Fiyat>();
        //    fiyats = sdrService.GetSatisFiyatlari(model);

        //    return Ok(fiyats);
        //}

        //[AllowAnonymous]
        //[HttpPost("GetZiyaretTipleri")]
        //public IActionResult GetZiyaretTipleri([FromBody] ZiyaretParametreModel model)
        //{

        //    List<ZiyaretTipleri> ziyarettipleri = new List<ZiyaretTipleri>();
        //    ziyarettipleri = sdrService.GetZiyaretTipleri(model);

        //    return Ok(ziyarettipleri);
        //}


        //[AllowAnonymous]
        //[HttpPost("GetZiyaretSonlandirmaTipleri")]
        //public IActionResult GetZiyaretSonlandirmaTipleri([FromBody] ZiyaretParametreModel model)
        //{
        //    List<ZiyaretSonlandirmaTipleri> ziyaretsonlandirmatipleri = new List<ZiyaretSonlandirmaTipleri>();
        //    ziyaretsonlandirmatipleri = sdrService.GetZiyaretSonlandirmaTipleri(model);

        //    return Ok(ziyaretsonlandirmatipleri);
        //}


        //[AllowAnonymous]


        //[HttpPost("GetMalzeme")]
        //public IActionResult GetMalzeme([FromBody] SdrParametreModel model)
        //{
        //    List<Malzeme> malzemeList = new List<Malzeme>();
        //    malzemeList = sdrService.GetMalzeme(model);

        //    return Ok(malzemeList);
        //}

        //[AllowAnonymous]
        //[HttpPost("GetMalzemeBirimCevrimi")]
        //public IActionResult GetMalzemeBirimCevrimi([FromBody] SdrParametreModel model)
        //{
        //    List<BirimCevrimi> birimList = new List<BirimCevrimi>();
        //    birimList = sdrService.GetMalzemeBirimCevrimi(model);

        //    return Ok(birimList);
        //}

        [AllowAnonymous]
        [HttpPost("SetTahsilat")]        
        public IActionResult SetTahsilat([FromBody] List<string> args)        
        {
            ValidationResponse vr = new ValidationResponse() { successful = true,information="", code="", result=""};

            var json_serializer = new JavaScriptSerializer();
            AktarimParameterModel model = json_serializer.Deserialize<AktarimParameterModel>(args[0]);           
            List<Tahsilat> tahsilatlar=new List<Tahsilat>();
            if (args[1]!=null)
            {
                tahsilatlar = json_serializer.Deserialize<List<Tahsilat>>(args[1]);
            }
            List<Ziyaret> ziyaretler = json_serializer.Deserialize<List<Ziyaret>>(args[2]);

            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.SetTahsilat(tahsilatlar, ziyaretler, model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }
                }
            }

            return Ok(vr);
        }

        [AllowAnonymous]
        [HttpPost("SetZiyaret")]
        public IActionResult SetZiyaret([FromBody] List<string> args)
        {
            ValidationResponse vr = new ValidationResponse() { successful = true, information = "", code = "", result = "" };

            var json_serializer = new JavaScriptSerializer();
            AktarimParameterModel model = json_serializer.Deserialize<AktarimParameterModel>(args[0]);

            List<Ziyaret> ziyaretler = json_serializer.Deserialize<List<Ziyaret>>(args[1]);
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.SetZiyaret(ziyaretler, model);
                }
            }

            return Ok(vr);
        }


        [AllowAnonymous]
        [HttpPost("GetKampanya")]
        public ValidationResponseList GetKampanya([FromBody] SdrParametreModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.GetKampanya(model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }
                }
            }            

            return vr;
        }

        [AllowAnonymous]
        [HttpPost("SetSiparis")]
        public IActionResult SetSiparis([FromBody] List<string> args)
        {
            ValidationResponse vr = new ValidationResponse() { successful = true, information = "", code = "", result = "" };

            var json_serializer = new JavaScriptSerializer();
            AktarimParameterModel model = json_serializer.Deserialize<AktarimParameterModel>(args[0]);

            List<Siparis> siparisler = new List<Siparis>();
            if (args[1] != null)
            {
                siparisler = json_serializer.Deserialize<List<Siparis>>(args[1]);
            }

            List<SiparisSatir> siparisSatir = new List<SiparisSatir>();
            if (args[2] != null)
            {
                siparisSatir = json_serializer.Deserialize<List<SiparisSatir>>(args[2]);
            }
            List<Ziyaret> ziyaretler = json_serializer.Deserialize<List<Ziyaret>>(args[3]);
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.SetSiparis(siparisler, siparisSatir, ziyaretler, model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }
                }
            }

            return Ok(vr);
        }

        [AllowAnonymous]
        [HttpPost("GetAcikHesapListesi")]
        public ValidationResponseList GetAcikHesapListesi([FromBody] SdrParametreModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.GetAcikHesapListesi(model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }

                }
            }            

            return vr;
        }

        [AllowAnonymous]
        [HttpPost("GetGunlukTahsilat")]
        public ValidationResponseList GetGunlukTahsilat([FromBody] SdrParametreModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.GetGunlukTahsilat(model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }

                }
            }            

            return vr;
        }

        [AllowAnonymous]
        [HttpPost("GetGunlukSiparis")]
        public ValidationResponseList GetGunlukSiparis([FromBody] SdrParametreModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.GetGunlukSiparis(model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }

                }
            }

            

            return vr;
        }


        [AllowAnonymous]
        [HttpPost("GetMusteriMalAnalizi")]
        public ValidationResponseList GetMusteriMalAnalizi([FromBody] ParameterMMAnaliziModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.GetMusteriMalAnalizi(model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }
                }
            }

            return vr;
        }
        


        [AllowAnonymous]
        [HttpPost("GetAllBekleyenSiparis")]
        public ValidationResponseList GetAllBekleyenSiparis([FromBody] SdrParametreModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = true, information = "", code = "", result = new List<string>() };
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                        vr = sdrService.GetAllBekleyenSiparis(model);
                    else
                    {
                        vr.successful = false;
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }

                }
            }
            

            return vr;
        }

        [AllowAnonymous]
        [HttpPost("GetStokFiyatListesi")]
        public ValidationResponseList GetStokFiyatListesi([FromBody] SdrParametreModel model)
        {
            ValidationResponseList vr = new ValidationResponseList() { successful = false, information = "", code = "", result = new List<string>() };
            if (model.token != null)
            {
                if (model.token != "")
                {
                    UsersProces userProses = userService.GetProses(model.email);
                    if (userProses.token == model.token)
                    {
                        vr = sdrService.GetStokFiyatListesi(model);
                    }
                    else
                    {
                        vr.information = "Kullanıcı oturum bilgilerine ulaşılamadı. Lütfen sistemden çıkıp tekrar giriniz.";
                    }
                        
                }
            }

            return vr;
        }


        



    }
}
