using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDREntities
{
    public class RutTanimi
    {
        public string kod { get; set; }
        public string gun { get; set; }
        public int aktif { get; set; }
        public int gun_sira { get; set; }
        public int rut_sira_no { get; set; }
        public int aktifnoktasayisi { get; set; }
        public int pasifnoktasayisi { get; set; }
        public int rutSayac { get; set; }
        public int rutDetaySayac { get; set; }
        public int bugun { get; set; }
    }
}
