using SDRMobilApi.Data;
using SDRMobilApi.Entities;
using SDRMobilApi.Helpers;
using System;
using System.Linq;

namespace SDRMobilApi.Services
{
    public interface IFirmaservice
    {
        Firma GetById(int firma_Id);

        Firma GetByFirmaAdi(string firmaAdi);

        Firma Create(Firma firma);

        void Update(Firma firma);

        void Delete(int firma_Id);

    }

    public class Firmaservice : IFirmaservice
    {
        private DataContext _context;

        public Firmaservice(DataContext context)
        {
            _context = context;
        }

        public Firma Create(Firma firma)
        {
            if (String.IsNullOrWhiteSpace(firma.firma_adi))
            {
                throw new AppException("Firma Adı boş olamaz!");
            }
            if (String.IsNullOrWhiteSpace(firma.firma_url))
            {
                throw new AppException("Firma Web adresi boş olamaz!");
            }
            if (_context.Firmas.Any(x => x.firma_adi.ToUpper() == firma.firma_adi.ToUpper()))
            {
                throw new AppException("Firma Adı: " + firma.firma_adi + " zaten kullanılıyor. Başka bir firma adı giriniz.");
            }
            _context.Firmas.Add(firma);
            _context.SaveChanges();

            return firma;
        }

        public void Delete(int firma_Id)
        {
            var firma = _context.Firmas.Find(firma_Id);
            if (firma!=null)
            {
                _context.Firmas.Remove(firma);
                _context.SaveChanges();
            }
        }

        public Firma GetByFirmaAdi(string firmaAdi)
        {
            var firma = _context.Firmas.Where(x => x.firma_adi == firmaAdi).FirstOrDefault();
            return firma;
        }

        public Firma GetById(int firma_Id)
        {
            return _context.Firmas.Find(firma_Id);
        }

        public void Update(Firma firmaParam)
        {
            var firma= _context.Firmas.Find(firmaParam.firma_Id);
            if (firma == null)
                throw new AppException("Firma tanımı bulunamadı.");

            if (String.IsNullOrWhiteSpace(firmaParam.firma_adi))
            {
                throw new AppException("Firma Adı boş olamaz!");
            }

            if (String.IsNullOrWhiteSpace(firmaParam.firma_url))
            {
                throw new AppException("Firma Web adresi boş olamaz!");
            }

            firma.firma_adi = firmaParam.firma_adi;
            firma.firma_url = firmaParam.firma_url;

            _context.Firmas.Update(firma);
            _context.SaveChanges();

        }

        

    }
}
