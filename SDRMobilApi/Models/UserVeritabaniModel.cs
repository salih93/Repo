using SDRMobilApi.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Models
{
    public class UserVeritabaniModel
    {
        public int user_id { get; set; }

        public string Email { get; set; }
        
        public string Password { get; set; }

        public Boolean pasif { get; set; } = false;

        public int firma_id { get; set; }       

        public string temsilci_kodu { get; set; }

        public List<VeritabaniModel> Veritabanlari { get; set; }

    }


}
