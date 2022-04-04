using SDRMobilApi.Data;
using SDRMobilApi.Entities;
using SDRMobilApi.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Services
{
    public interface IVeritabaniService
    {
        Veritabani GetById(int veritabani_Id);

        Veritabani GetByVeritabaniAdi(string veritabani_adi);

        Veritabani GetByUserId(int user_id);       

        Veritabani Create(Veritabani veritabani);

        void Update(Veritabani veritabaniParam);

        void Delete(int veritabani_Id);

        void DeleteAll(int user_id);
    }

    public class VeritabaniService : IVeritabaniService
    {
        private DataContext _context;

        public VeritabaniService(DataContext context)
        {
            _context = context;
        }

        public Veritabani Create(Veritabani veritabani)
        {
            if (String.IsNullOrWhiteSpace(veritabani.veritabani_adi))
            {
                throw new AppException("Veritabanı Adı boş olamaz!");
            }
            
            if (String.IsNullOrWhiteSpace(veritabani.temsilci_kodu))
            {
                throw new AppException("Temsilci kodu boş olamaz!");
            }

            if (String.IsNullOrWhiteSpace(veritabani.user_id.ToString()))
            {
                throw new AppException("User Id boş olamaz!");
            }

            _context.Veritabanis.Add(veritabani);
            _context.SaveChanges();

            return veritabani;

        }

        public void Delete(int veritabani_Id)
        {
            var veritabani = _context.Veritabanis.Find(veritabani_Id);
            if (veritabani != null)
            {
                _context.Veritabanis.Remove(veritabani);
                _context.SaveChanges();
            }

        }

        public void DeleteAll(int user_id)
        {
            var veritabanlari = _context.Veritabanis.Where(i => i.user_id == user_id).ToList();
            if (veritabanlari.Count()>0)
            {
                foreach (var item in veritabanlari)
                {
                    _context.Veritabanis.Remove(item);
                    _context.SaveChanges();
                }
            }
        }
        
        public Veritabani GetById(int veritabani_Id)
        {
            return _context.Veritabanis.Find(veritabani_Id);
        }
        public void Update(Veritabani veritabaniParam)
        {
            var veritabani = _context.Veritabanis.Find(veritabaniParam.veritabani_Id);
            if (veritabani == null)
                throw new AppException("Veritabanı tanımı bulunamadı.");

            if (String.IsNullOrWhiteSpace(veritabaniParam.veritabani_adi))
            {
                throw new AppException("Veritabanı Adı boş olamaz!");
            }

            if (String.IsNullOrWhiteSpace(veritabaniParam.temsilci_kodu))
            {
                throw new AppException("Temsilci kodu boş olamaz!");
            }

            if (String.IsNullOrWhiteSpace(veritabaniParam.user_id.ToString()))
            {
                throw new AppException("User Id boş olamaz!");
            }


            veritabani.veritabani_adi = veritabaniParam.veritabani_adi;
            veritabani.temsilci_kodu = veritabaniParam.temsilci_kodu;
            veritabani.user_id = veritabaniParam.user_id;
            veritabani.varsayilan = veritabaniParam.varsayilan;

            _context.Veritabanis.Update(veritabani);
            _context.SaveChanges();

        }

        public Veritabani GetByVeritabaniAdi(string veritabani_adi)
        {
            var veritabani = _context.Veritabanis.Where(x => x.veritabani_adi == veritabani_adi).FirstOrDefault();
            if (veritabani == null)
                throw new AppException("Veritabanı tanımı bulunamadı.");

            return veritabani;
        }

        public Veritabani GetByUserId(int user_id)
        {
            int _count=_context.Veritabanis.Where(i => (i.user_id == user_id && i.varsayilan == 1)).Count();
            Veritabani veritabani=null;
            if (_count==0)
            {
                veritabani = _context.Veritabanis.Where(i => (i.user_id == user_id)).FirstOrDefault();
            }
            else
            {
                veritabani= _context.Veritabanis.Where(i => (i.user_id == user_id && i.varsayilan==1)).FirstOrDefault();
            }
            
            if (veritabani == null)
                throw new AppException("Veritabanı tanımı bulunamadı.");

            return veritabani;
        }


    }
}
