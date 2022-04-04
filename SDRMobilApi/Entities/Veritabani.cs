using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Entities
{
    public class Veritabani
    {
        [Key]
        public int veritabani_Id { get; set; }

        [Required]
        public string veritabani_adi { get; set; }

        public string temsilci_kodu { get; set; }

        public int user_id { get; set; }

        public int? varsayilan { get; set; }
        
    }
}
