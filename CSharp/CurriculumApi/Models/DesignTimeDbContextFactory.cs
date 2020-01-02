using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using System.IO;

namespace CurriculumApi.Models
{
  public class CurriculumApiContextFactory : IDesignTimeDbContextFactory<CurriculumApiContext>
  {
    CurriculumApiContext IDesignTimeDbContextFactory<CurriculumApiContext>.CreateDbContext(string[] args)
    {
      IConfigurationRoot configuration = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json")
        .Build();
      
      var builder = new DbContextOptionsBuilder<CurriculumApiContext>();
      var connectionString = configuration.GetConnectionString("DefaultConnection");

      builder.UseMySql(connectionString);

      return new CurriculumApiContext(builder.Options);
    }
  }
}