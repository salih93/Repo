using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;
using SDRMobilApi.Data;
using SDRMobilApi.Helpers;
using SDRMobilApi.SDRServices;
using SDRMobilApi.Services;
using System;



namespace SDRMobilApi
{
    public class Startup
    {
        public IConfiguration Configuration { get; }

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }
        

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<DataContext>();                      

            services.AddCors();
            services.AddControllers();
            services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

            var appSettingsSection = Configuration.GetSection("AppSettings");
            services.Configure<AppSettings>(appSettingsSection);


            // configure DI for application services
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<IFirmaservice, Firmaservice>();
            services.AddScoped<IVeritabaniService, VeritabaniService>();
            services.AddScoped<ISDRService, SdrServices>();


            //services.AddScoped<IEmailSender, SmtpEmailSender>(i => new SmtpEmailSender(
            //         Configuration["EmailSender:Host"],
            //         Configuration.GetValue<int>("EmailSender:Port"),
            //         Configuration.GetValue<bool>("EmailSender:EnableSSl"),
            //         Configuration["EmailSender:UserName"],
            //         Configuration["EmailSender:Password"])
            //    );


            services.AddSwaggerGen();

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {   
            
            app.UseSwagger(c =>
            {
                c.SerializeAsV2 = true;
            });

            
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("./swagger/v1/swagger.json", "SDRMobilApi.Web.Api");                
                c.RoutePrefix = string.Empty;
            });
           


            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
