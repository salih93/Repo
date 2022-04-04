using AutoMapper.Configuration;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SDRMobilApi.Data;
using SDRMobilApi.Entities;
using SDRMobilApi.Helpers;
using SDRMobilApi.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Services
{
    public interface IUserService
    {
        User Authenticate(string email, string password);
        
        User GetById(int id);

        User GetByEmail(string Email);

        User Create(User user, string password);

        Boolean Update(User user, string password = null);        

        Boolean Delete(int id);

        Boolean MailGonder(string email, string subject, string body);

        Boolean SifremiUnuttum(string email);

        Boolean CreateProses(RegisterProcessModel model);

        Boolean DeleteProses(int id);

        Boolean UpdateProses(UsersProces proses);

        int GetProsesId(string email);
        UsersProces GetProses(string email);
    }

    public class UserService : IUserService
    {
        private readonly DataContext _context;
        private string _connectionString;

        public UserService(DataContext context)
        {
            _context = context;
            _connectionString = context._connectionString;
        }
                

        public User Authenticate(string email, string password)
        {

            
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
                return null;

            var user = _context.Users.SingleOrDefault(x => x.Email == email);
            

            // check if email exists
            if (user == null)
                return null;

            // check if password is correct
            if (!VerifyPasswordHash(password, user.PasswordHash, user.PasswordSalt))
                return null;

            // authentication successful
            return user;
        }

        public User Create(User user, string password)
        {
            if(String.IsNullOrWhiteSpace(password))
            {
                throw new AppException("Şifre girilmelidir!");
            }
            if (_context.Users.Count()>0)
            {
                if (_context.Users.Any(x => x.Email.ToUpper() == user.Email.ToUpper()))
                {
                    throw new AppException("Email \"" + user.Email + "\" zaten kullanılıyor. Başka bir email adresi giriniz.");
                }
            }

            

            byte[] passwordHash, passwordSalt;
            CreatePasswordHash(password, out passwordHash, out passwordSalt);

            user.PasswordHash = passwordHash;
            user.PasswordSalt = passwordSalt;

            if (string.IsNullOrWhiteSpace(user.pasif.ToString()))
            {
                user.pasif = false;
            }

            try
            {
                _context.Users.Add(user);
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw new AppException(ex.Message);

            }            

            return user;
        }

        

        public Boolean Update(User userParam, string password = null)
        {
            var user = _context.Users.Find(userParam.Id);

            if (user == null)
                throw new AppException("User bulunamadı.");

            if (!string.IsNullOrWhiteSpace(userParam.Email) && userParam.Email != user.Email)
            {
                // throw error if the new email is already taken
                if (_context.Users.Any(x => x.Email == userParam.Email))
                    throw new AppException("Email " + userParam.Email + " kullanılıyor.");

                user.Email = userParam.Email;
            }           

            // update password if provided
            if (!string.IsNullOrWhiteSpace(password))
            {
                byte[] passwordHash, passwordSalt;
                CreatePasswordHash(password, out passwordHash, out passwordSalt);

                user.PasswordHash = passwordHash;
                user.PasswordSalt = passwordSalt;
            }
            if (string.IsNullOrWhiteSpace(userParam.pasif.ToString()))
            {
                userParam.pasif = false;
            }
            user.pasif = userParam.pasif;

            try
            {
                _context.Users.Update(user);
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw new AppException(ex.Message);                
            }

            return true;
        }

        public Boolean Delete(int id)
        {
            var user = _context.Users.Find(id);
            if (user != null)
            {
                try
                {
                    _context.Users.Remove(user);
                    _context.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw new AppException(ex.Message);
                }                
            }

            return true;
        }

        public User GetByEmail(string Email)
        {
            return _context.Users.Where(x => x.Email == Email).FirstOrDefault();
        }

        public User GetById(int id)
        {
            return _context.Users.Find(id);
        }

        private static void CreatePasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            if (password == null) throw new ArgumentNullException("password");
            if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "password");

            using (var hmac = new System.Security.Cryptography.HMACSHA512())
            {
                passwordSalt = hmac.Key;
                passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            }
        }

        private static bool VerifyPasswordHash(string password, byte[] storedHash, byte[] storedSalt)
        {
            if (password == null) throw new ArgumentNullException("password");
            if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "password");
            if (storedHash.Length != 64) throw new ArgumentException("Invalid length of password hash (64 bytes expected).", "passwordHash");
            if (storedSalt.Length != 128) throw new ArgumentException("Invalid length of password salt (128 bytes expected).", "passwordHash");

            using (var hmac = new System.Security.Cryptography.HMACSHA512(storedSalt))
            {
                var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                for (int i = 0; i < computedHash.Length; i++)
                {
                    if (computedHash[i] != storedHash[i]) return false;
                }
            }

            return true;
        }

        public Boolean MailGonder(string email, string subject, string body)
        {
            _connectionString = _context._connectionString;

            using (SqlConnection sqlConnection = new SqlConnection(_connectionString))
            {
                
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(String.Format("exec sp_send_mail '{0}','{1}','{2}'", email, subject, body), sqlConnection);
                DataTable dataTable = new DataTable();

                sqlDataAdapter.Fill(dataTable);
                foreach (DataRow item in dataTable.Rows)
                {
                    if  (item["mesaj"].ToString().IndexOf("Error")>0)
                    {
                        throw new AppException(item["mesaj"].ToString());
                    }
                }
            }

            return true;


        }

        public Boolean SifremiUnuttum(string email)
        {
            var _user = _context.Users.Where(x => x.Email == email).FirstOrDefault();
            if (_user==null)
            {
                throw new AppException($"Sistemde kayıtlı {email} hesabı bulanamadı");               
            }

            _connectionString = _context._connectionString;                        

            using (SqlConnection sqlConnection = new SqlConnection(_connectionString))
            {
                
                var password = "";
                try
                {
                    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter("Select password=dbo.ufn_GeneratePassword(8)", sqlConnection);
                    DataTable dataTable = new DataTable();
                    sqlDataAdapter.Fill(dataTable);

                    password=dataTable.Rows[0]["password"].ToString();
                    if (string.IsNullOrWhiteSpace(password))
                    {
                        throw new AppException("Password alınamadı.");
                    }

                    if (Update(_user, password))
                    {
                        MailGonder(_user.Email, "SDR Mobil Hesabınız",
                            $"SDR Mobil: {_user.Email} hesabınızın şifresi:{password} olarak değiştirilmiştir. ");
                    }
                    return true;
                }
                catch (Exception ex)
                {
                    throw new AppException(ex.Message);                    
                }               
                finally
                {
                    if(sqlConnection.State == ConnectionState.Open)
                        sqlConnection.Close();
                }
            }
            
            
        }

        public bool CreateProses(RegisterProcessModel model)
        {
            UsersProces proces = new UsersProces();
            proces.email = model.Email;
            proces.token = model.token;
            proces.userid = model.userid;
            proces.versiyon_no = model.versiyon_no;
            proces.IMEI = model.IMEI;
            proces.deviceModel = model.deviceModel;
            proces.deviceName = model.deviceName;
            proces.productName = model.productName;

            try
            {
                _context.UsersProcess.Add(proces);
                _context.SaveChanges();                
            }
            catch (Exception ex)
            {
                throw new AppException(ex.Message);                
            }

            return true;
        }

        public int GetProsesId(string email)
        {
            int id = 0;
            id=_context.UsersProcess.Where((element) => element.email==email).Max(a => a.id);

            return id;
        }

        public UsersProces GetProses(string email)
        {
            int prosesId = GetProsesId(email);
            if (prosesId>0)
            {
                UsersProces proses = _context.UsersProcess.Where((element) => element.id == prosesId).FirstOrDefault();
                if (proses != null)
                { return proses; }
                else
                { return null; }
            }
            else
                return null;
        }

        public Boolean DeleteProses(int id)
        {
            var proses = _context.UsersProcess.Find(id);
            if (proses != null)
            {
                try
                {
                    _context.UsersProcess.Remove(proses);
                    _context.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw new AppException(ex.Message);
                }
            }

            return true;
        }

        public Boolean UpdateProses(UsersProces proses)
        {
            
            if (proses != null)
            {
                try
                {
                    _context.UsersProcess.Update(proses);
                    _context.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw new AppException(ex.Message);
                }
            }
            return true;
        
        }



    }
}
