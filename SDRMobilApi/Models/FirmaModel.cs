﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Models
{
    public class FirmaModel
    {
        public int firma_Id { get; set; }

        [Required]
        public string firma_adi { get; set; }

        [Required]
        public string firma_url { get; set; }

    }
}
