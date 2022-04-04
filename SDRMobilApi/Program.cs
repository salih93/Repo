using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace SDRMobilApi
{

    public class Program
    {
        //private readonly IConfiguration _configuration;


        public static void Main(string[] args)
        {
            BuildWebHost(args).Run();
            //CreateHostBuilder(args).Build().Run();
        }

        public static IWebHost BuildWebHost(string[] args) =>
           Microsoft.AspNetCore.WebHost.CreateDefaultBuilder(args)
            .ConfigureAppConfiguration(ConfigConfiguration)
            .UseStartup<Startup>()
            .Build();

        static void ConfigConfiguration(WebHostBuilderContext ctx, IConfigurationBuilder config)
        {
            config.SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                .AddJsonFile($"config.{ctx.HostingEnvironment.EnvironmentName}.json", optional: true);

        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureHostConfiguration(configHost => {
                    configHost.SetBasePath(Directory.GetCurrentDirectory());
                    configHost.AddJsonFile("appsettings.json", optional: true);
                    configHost.AddEnvironmentVariables(prefix: "applicationUrl");
                    configHost.AddCommandLine(args);
                })
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });

    }
    /*
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }

    */

}
