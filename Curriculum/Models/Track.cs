using System.Collections.Generic;

namespace Curriculum.Models
{
  public class Track
  {
    public Track()
    {
      this.Lessons = new HashSet<LessonTrack>();
    }

    public int TrackId { get; set; }
    public string Name { get; set; }
    public virtual ApplicationUser User { get; set; }

    public virtual ICollection<LessonTrack> Lessons { get; }
  }
}