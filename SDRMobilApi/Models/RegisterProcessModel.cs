using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Models
{
    public class RegisterProcessModel
    {
        [Required]
        public string Email { get; set; }
        public int userid { get; set; }
        public string token { get; set; }
        public string versiyon_no { get; set; }

        public string IMEI { get; set; }
        public string deviceName { get; set; }
        public string productName { get; set; }
        public string deviceModel { get; set; }

    }
}
