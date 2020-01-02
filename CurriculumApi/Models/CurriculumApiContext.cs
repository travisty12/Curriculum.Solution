using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace CurriculumApi.Models
{
  public class CurriculumApiContext : IdentityDbContext<ApplicationUser>
  {
    public virtual DbSet<Track> Tracks { get; set; }
    public DbSet<Lesson> Lessons { get; set; }
    public DbSet<LessonTrack> LessonTrack { get; set; }

    public CurriculumApiContext(DbContextOptions options) : base(options)
    {
      
    }
  }
}