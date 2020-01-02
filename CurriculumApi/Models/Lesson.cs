using System.Collections.Generic;

namespace CurriculumApi.Models
{
  public class Lesson
  {
    public Lesson()
    {
      this.Tracks = new HashSet<LessonTrack>();
    }

    public int LessonId { get; set; }
    public string Title { get; set; }
    public string Content { get; set; }

    public virtual ICollection<LessonTrack> Tracks { get; }
  }
}