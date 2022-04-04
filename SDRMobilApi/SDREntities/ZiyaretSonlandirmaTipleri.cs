using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class ZiyaretSonlandirmaTipleri
    {
        public int r_sayac { get; set; }
        public string tipi { get; set; }
        public string aciklama { get; set; }
        public int sira { get; set; }
        public int sabit { get; set; }
        public int auto { get; set; }
        public int satisvar { get; set; }
        public int zorunlu_aciklama { get; set; }

    }
}
