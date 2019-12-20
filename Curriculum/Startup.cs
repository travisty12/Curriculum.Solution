using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configurations;
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

    public IConfigurationRoot Configuration { get; set; }

    public void ConfigureServices(IServiceCollection services)
    {
      services.AddMvc();

      services.AddEntityFrameworkMySql()
        .AddDbContext<CurriculumContext>(options => options
        .UseMySql(Configuration["ConnectionStrings:DefaultConnection"]));
      
      services.AddIdentity<ApplicationUser, IdentityRole>()
        .AddEntityFrameworkStores<CurriculumContext>()
        .AddDefaultTokenProviders();
      
      
    }

    
  }
}