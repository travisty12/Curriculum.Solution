using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Curriculum.Models
{
  public class CurriculumContext : IdentityDbContext<ApplicationUser>
  {
    public virtual DbSet<Track> Tracks { get; set; }
    public DbSet<Lesson> Lessons { get; set; }
    public DbSet<LessonTrack> LessonTrack { get; set; }

    public CurriculumContext(DbContextOptions options) : base(options)
    {
      
    }
  }
}