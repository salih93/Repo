using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class Kasa
    {
        [Key]
        public string kod { get; set; }
        public string sorumlu { get; set; }
        public int kredi_karti_kasasi { get; set; }
    }
}
