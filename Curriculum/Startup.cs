using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Curriculum.Models;

namespace Curriculum
{
  public class Startup
  {
    public Startup(IHostingEnvironment env)
    {
      var builder = new ConfigurationBuilder()
        .SetBasePath(env.ContentRootPath)
        .AddJsonFile("appsettings.json");
      Configuration = builder.Build();
    }

    readonly string MyAllowSpecificOrigins = "_MyAllowSpecificOrigins";

    public IConfigurationRoot Configuration { get; set; }

    public void ConfigureServices(IServiceCollection services)
    {
      services.AddCors(opt =>
      {
        opt.AddPolicy(MyAllowSpecificOrigins,
        builder =>
        {
          builder.WithOrigins("http://localhost:9000",
                              "http://localhost:8080");
        });
      });
      services.AddMvc();

      services.AddEntityFrameworkMySql()
        .AddDbContext<CurriculumContext>(options => options
        .UseMySql(Configuration["ConnectionStrings:DefaultConnection"]));
      
      services.AddIdentity<ApplicationUser, IdentityRole>()
        .AddEntityFrameworkStores<CurriculumContext>()
        .AddDefaultTokenProviders();
      
      services.Configure<IdentityOptions>(options => 
      {
        options.Password.RequireDigit = false;
        options.Password.RequiredLength = 0;
        options.Password.RequireLowercase = false;
        options.Password.RequireNonAlphanumeric = false;
        options.Password.RequireUppercase = false;
        options.Password.RequiredUniqueChars = 0;
      });
    }

    public void Configure(IApplicationBuilder app)
    {
      app.UseDeveloperExceptionPage();

      app.UseStaticFiles();

      app.UseAuthentication();
      app.UseCors(MyAllowSpecificOrigins);
      app.UseMvc(routes =>
      {
        routes.MapRoute(
          name: "default",
          template: "{controller=Home}/{action=Index}/{id?}");
      });
      
      app.Run(async (context) =>
      {
        await context.Response.WriteAsync("Aw shucks, something went wrong!");
      });
    }
    
  }
}