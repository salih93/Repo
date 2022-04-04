using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class BirimCevrimi
    {
        public int r_sayac { get; set; }
        public int birim_rsayac { get; set; }
        public string birimden { get; set; }
        public string birime { get; set; }
        public decimal bolunen { get; set; }
        public decimal bolen { get; set; }
        public string malzeme_kodu { get; set; }
    }
}
