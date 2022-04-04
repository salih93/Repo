using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using SDRMobilApi.EmailServices;
using SDRMobilApi.Entities;
using SDRMobilApi.Helpers;
using SDRMobilApi.Models;
using SDRMobilApi.Services;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace SDRMobilApi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private IUserService _userService;
        private IFirmaservice _Firmaservice;
        private IVeritabaniService _veritabaniservice;
        //private IEmailSender _emailSender;

        private IMapper _mapper;
        private readonly AppSettings _appSettings;

        public UserController(
           IUserService userService,
           IMapper mapper,
           IOptions<AppSettings> appSettings,
           IFirmaservice Firmaservice,
           IVeritabaniService veritabaniservice
           /*,IEmailSender emailSender*/
           )
        {
            _userService = userService;
            _mapper = mapper;
            _appSettings = appSettings.Value;
            _Firmaservice = Firmaservice;
            _veritabaniservice = veritabaniservice;
            //_emailSender = emailSender;
        }

        // GET: api/<UserController>
        [AllowAnonymous]
        [HttpGet("GetAll")]
        public IActionResult GetAll(string Email)
        {
            //Console.WriteLine("Salih ACAR");
            return BadRequest(new { message = "Mesaj gönderimi başarılı" });
        }

        [AllowAnonymous]
        [HttpGet("GetUserByEmail/{Email}")]
        public IActionResult GetUserByEmail(string Email)
        {
            var user = _userService.GetByEmail(Email);
            if (user == null)
                return BadRequest(new { message = "Mail Adresi " + Email + " sistemde bulunamadı." });

            var model = _mapper.Map<UserModel>(user);
            return Ok(model);
        }

        [AllowAnonymous]
        [HttpPost("FirmaGuncelle")]
        public IActionResult FirmaGuncelle([FromBody] FirmaModel model)
        {            
            var firma = _mapper.Map<Firma>(model);

            try
            {
                if (model.firma_Id == 0 || string.IsNullOrWhiteSpace(model.firma_Id.ToString()))
                {
                    _Firmaservice.Create(firma);
                }
                else
                {
                    _Firmaservice.Update(firma);
                }

                //nesne_olustur Result = new nesne_olustur() { message = "", id = firma.firma_Id };
                //string jsonString = JsonSerializer.Serialize(Result);
                //resultXml=Converter.GenerateXmlResponse(jsonString);

                return Ok(new { message = "", id = firma.firma_Id.ToString()});
                //return Result;
            }
            catch (AppException ex)
            {
                return BadRequest(new { message = ex.Message, id = "0" });                
            }
            
        }

        [AllowAnonymous]
        [HttpPost("VeritabaniUserGuncelle")]
        public IActionResult VeritabaniUserGuncelle([FromBody] UserVeritabaniModel model)
        {
            int user_id = 0;
            string _email = "";
            string _passwword = "";
            Veritabani veritabani = null;
            User user = null;
            

            try
            {

                if (string.IsNullOrWhiteSpace(model.Email.ToString()))
                {
                    return BadRequest(new { message = "Email bilgisi boş olamaz!", id = "0" });
                }

                if (model.user_id == 0)
                {
                    if (string.IsNullOrWhiteSpace(model.Password.ToString()))
                    {
                        return BadRequest(new { message = "Şifre bilgisi boş olamaz!", id = "0" });
                    }
                }

                if (string.IsNullOrWhiteSpace(model.firma_id.ToString()))
                {
                    return BadRequest(new { message = "Firma Id bilgisi boş olamaz!", id = "0" });
                }
                if (string.IsNullOrWhiteSpace(model.temsilci_kodu.ToString()))
                {
                    return BadRequest(new { message = "Temsilci kodu bilgisi boş olamaz!", id = "0" });
                }

                if (user_id == 0)
                {
                    var firma = _Firmaservice.GetById(model.firma_id);
                    if (firma == null)
                    {
                        return BadRequest(new { message = "Firma Id sistemde bulunamadı!", id = "0" });
                    }

                    if (model.user_id > 0)
                        user = _userService.GetById(model.user_id);

                    if (user == null)
                    {
                        user = new User();
                        user.Email = model.Email;
                        user.pasif = model.pasif;
                        user.firma_id = model.firma_id;
                        user = _userService.Create(user, model.Password);
                        user_id = user.Id;
                        model.user_id = user.Id;
                        _email = user.Email;
                        _passwword = model.Password;

                        if (!string.IsNullOrWhiteSpace(_email) && !string.IsNullOrWhiteSpace(_passwword))
                        {
                            _userService.MailGonder(_email, "SDR Mobil Hesabınız",
                                $"SDR Mobil: {_email} hesabınızın şifresi:{_passwword} olarak güncellenmiştir. ");
                        }

                    }
                    else
                    {
                        user.Email = model.Email;
                        user.pasif = model.pasif;
                        user.firma_id = model.firma_id;

                        _userService.Update(user, model.Password);
                        user_id = model.user_id;
                        _email = model.Email;
                    }
                    _veritabaniservice.DeleteAll(user_id);
                }

                foreach (VeritabaniModel item in model.Veritabanlari)
                {
                    
                    if (string.IsNullOrWhiteSpace(item.veritabani_adi.ToString()))
                    {
                        return BadRequest(new { message = "Veritabanı adı bilgisi boş olamaz!", id = "0" });
                    }                   

                    if (user_id>0)
                    {
                        veritabani = new Veritabani()
                        {
                            veritabani_adi = item.veritabani_adi,                            
                            varsayilan=item.varsayilan,
                            user_id = model.user_id,
                            temsilci_kodu = model.temsilci_kodu
                        };

                        _veritabaniservice.Create(veritabani);
                    }
                }
                

            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message, id = "0" });
            }

            return Ok(new
            {
                message = "",
                id = user_id.ToString()                
            });

        }

        [AllowAnonymous]
        [HttpPost("passGuncelle")]
        public IActionResult passGuncelle([FromBody] UpdateModel model)
        {
            
            if (string.IsNullOrWhiteSpace(model.Email))
                return BadRequest(new { message = "Email adresi boş olamaz.", id = "0" });

            if (string.IsNullOrWhiteSpace(model.Password))
                return BadRequest(new { message = "Şifre boş olamaz.", id = "0" });

            // map model to entity and set id
            var usercontrol = _userService.GetById(model.Id);
            if (usercontrol==null)
            {
                return BadRequest(new { message = model.Id.ToString() + " user id sistemde bulunamdı.", id = "0" });
            }                       

            if (!string.IsNullOrWhiteSpace(model.Id.ToString()))
            {
                if (usercontrol.Id != model.Id)
                {                    
                    var useremail = _userService.GetByEmail(model.Email);
                    if (useremail != null)
                        return BadRequest(new { message = model.Email.ToString() + " email adresi başka bir kullanıcı tarafından kullanılmaktadır.", id = "0" });
                }
            }

            var user = _mapper.Map<User>(model);
            user.Id = model.Id;
            try
            {
                // update user 
                if (_userService.Update(user, model.Password))
                {
                    _userService.MailGonder(user.Email, "SDR Mobil Hesabınız",
                        $"SDR Mobil: {user.Email} hesabınızın şifresi:{model.Password} olarak değiştirilmiştir. ");                   
                }

                return Ok(new { message = "Şifre başarılı bir şekilde güncellendi.", id = model.Id.ToString()});
            }
            catch (AppException ex)
            {
                // return error message if there was an exception
                return BadRequest(new { message = ex.Message, id = "0" });
            }

        }

        [AllowAnonymous]
        [HttpPost("SifremiUnuttum")]
        public IActionResult SifremiUnuttum([FromBody] UserModel model)
        {
            var _user = _userService.GetByEmail(model.Email);
            if (_user == null)
            {
                return BadRequest(new { message = "Mail Adresi " + model.Email + " sistemde bulunamadı.", id=0});
            }

            if (!_userService.SifremiUnuttum(model.Email))
            {                
                return BadRequest(new { message = $"Şifre {model.Email} hesabınıza gönderilemedi.", id = "0" });
            }
            return Ok(new { message = $"Şifre {model.Email} hesabınıza gönderildi.", id = model.Id.ToString() });
            
        }


        [AllowAnonymous]
        [HttpPost("authenticate")]
        public IActionResult Authenticate([FromBody] AuthenticateModel model)
        {
            
            var user= _userService.Authenticate(model.Email, model.Password);
            if (user == null)
                return BadRequest(new { message = "Email veya Şifre Yanlış.", id = "0" });

            if (user.pasif==true)
                return BadRequest(new { message = "Bu kullanıcı aktif değil.", id = "0" });

            if (user.kontrol == false)
                return BadRequest(new { message = "Yetkisiz kullanıcı", id = "0" });

            var tokenHandler = new JwtSecurityTokenHandler();

            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new System.Security.Claims.Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Id.ToString())
                }),
                //new Claim(ClaimTypes.Name, user.Id.ToString())
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);
            var firma = _Firmaservice.GetById(user.firma_id);
            var veritabani = _veritabaniservice.GetByUserId(user.Id);

            RegisterProcessModel prosesmodel = new RegisterProcessModel();
            prosesmodel.Email = model.Email;
            prosesmodel.userid = user.Id;
            prosesmodel.token = tokenString;
            prosesmodel.versiyon_no = model.versiyon_no;
            prosesmodel.IMEI = model.IMEI;
            prosesmodel.deviceModel = model.deviceModel;
            prosesmodel.deviceName = model.deviceName;
            prosesmodel.productName = model.productName;

            try
            {            
                _userService.CreateProses(prosesmodel);                
            }

            catch (AppException ex)
            {
                // return error message if there was an exception
                return BadRequest(new { message = ex.Message, id = "0" });
            }


            return Ok(new
            {
                Id = user.Id,               
                Email = user.Email,                
                Token = tokenString,
                firma_id=user.firma_id,
                firma_adi=firma.firma_adi,
                firma_url=firma.firma_url,
                veritabani_adi = veritabani.veritabani_adi,
                temsilci_kodu=veritabani.temsilci_kodu
            });

        }

        [AllowAnonymous]
        [HttpPost("register")]
        public IActionResult Register([FromBody] RegisterModel model)
        {
            // map model to entity
            var user = _mapper.Map<User>(model);

            try
            {
                // create user
                _userService.Create(user, model.Password);
                return Ok();
            }
            catch (AppException ex)
            {
                // return error message if there was an exception
                return BadRequest(new { message = ex.Message, id = "0" });
            }
        }

                   


        [HttpGet("GetById/{id}")]
        public IActionResult GetById(int id)
        {
            var user = _userService.GetById(id);

            var model = _mapper.Map<UserModel>(user);

            return Ok(model);
        }



        [AllowAnonymous]
        [HttpPost("Update")]
        public IActionResult Update([FromBody] UpdateModel model)
        {
            // map model to entity and set id
            var user = _mapper.Map<User>(model);
            user.Id = model.Id;

            try
            {
                // update user 
                _userService.Update(user, model.Password);
                return Ok();
            }
            catch (AppException ex)
            {
                // return error message if there was an exception
                return BadRequest(new { message = ex.Message, id = "0" });
            }
        }

        // DELETE api/<UserController>/5

        [AllowAnonymous]
        [HttpDelete("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            _userService.Delete(id);
            return Ok();
        }

    }
}
