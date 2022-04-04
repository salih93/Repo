using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Entities
{
    public class User
    {
        public int Id { get; set; }

        public string Email { get; set; }        

        public byte[] PasswordHash { get; set; }

        public byte[] PasswordSalt { get; set; }

        public int firma_id { get; set; }

        public Boolean pasif { get; set; } = false;

        public Boolean kontrol { get; set; } = false;
    }
}
