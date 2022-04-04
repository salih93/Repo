using Microsoft.Extensions.Configuration;
using Microsoft.EntityFrameworkCore;
using SDRMobilApi.Entities;
using SDRMobilApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi.Data
{
    public class DataContext : DbContext
    {
        public readonly IConfiguration Configuration;        

        public string _connectionString;

       
        public DataContext(IConfiguration configuration)
        {
            Configuration = configuration;
        }        

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            // connect to sql server database
            options.UseSqlServer(Configuration.GetConnectionString("Merkez"));
           _connectionString = Configuration.GetConnectionString("Merkez");            
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Firma> Firmas { get; set; }        
        public DbSet<Veritabani> Veritabanis { get; set; }
        public DbSet<UsersProces> UsersProcess { get; set; }




    }
}
