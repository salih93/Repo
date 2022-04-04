using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class GunlukSiparis
    {
        public string malzeme_kodu { get; set; }
        public string malzeme_adi { get; set; }
        public string baz_birim { get; set; }
        public string depo_no { get; set; }
        public string depo_adi { get; set; }
        public decimal miktar { get; set; }
        public decimal satir_tutari { get; set; }
        public string grup_adi1 { get; set; }
        public string grup_adi2 { get; set; }
        public string grup_adi3 { get; set; }

    }
}
