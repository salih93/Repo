using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Models
{
    public class AuthenticateModel
    {
        [Required]
        public string Email { get; set; }
        [Required]
        public string Password { get; set; }
        public string versiyon_no { get; set; }

        public string IMEI { get; set; }
        public string deviceName { get; set; }
        public string productName { get; set; }
        public string deviceModel { get; set; }


    }
}
