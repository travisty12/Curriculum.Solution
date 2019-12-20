using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configurations;
using System.IO;

namespace Curriculum.Models
{
  public class CurriculumContextFactory : IDesignTimeDbContextFactory<CurriculumContext>
  {
    CurriculumContext IDesignTimeDbContextFactory<CurriculumContext>.CreateDbContext(string[] args)
    {
      IConfigurationRoot configuration = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json")
        .Build();
      
      var builder = new DbContextOptionsBuilder<CurriculumContext>();
      var connectionString = configuration.GetConnectionString("DefaultConnection");

      builder.UseMySql(connectionString);

      return new CurriculumContext(builder.Options);
    }
  }
}