using SDRMobilApi.SDREntities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.SDRModels
{
    public class TahsilatModel
    {
        public AktarimParameterModel model { get; set; }
        public List<Tahsilat> tahsilatlar { get; set; }
        public List<Ziyaret> Ziyaretler { get; set; }
        

    }
}
