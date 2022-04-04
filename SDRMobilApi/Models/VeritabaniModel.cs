using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Models
{
    public class VeritabaniModel
    {
        
        public int veritabani_Id { get; set; }
        
        public string veritabani_adi { get; set; }

        public int? varsayilan { get; set; }
    }
}
