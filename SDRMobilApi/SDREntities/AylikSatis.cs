using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class AylikSatis
    {
        [Key]
        public int Id { get; set; }
        public string ay_str { get; set; }
        public string malzeme_kodu { get; set; }
        public string malzeme_adi { get; set; }
        public string birim { get; set; }
        public string dist_stok_kodu { get; set; }
        public string malzeme_sinifi_adi { get; set; }
        public string malzeme_sinifi_id { get; set; }
        public string path { get; set; }
        public int ay { get; set; }
        public decimal ciro { get; set; }
        public decimal miktar { get; set; }
    }

}
