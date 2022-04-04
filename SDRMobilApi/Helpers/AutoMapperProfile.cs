using AutoMapper;
using SDRMobilApi.Entities;
using SDRMobilApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Helpers
{
    public class AutoMapperProfile:Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<User, UserModel>();
            CreateMap<RegisterModel, User>();
            CreateMap<UpdateModel, User>();
            CreateMap<FirmaModel, Firma>();
            CreateMap<VeritabaniModel, Veritabani>();
            
        }
    }
}
