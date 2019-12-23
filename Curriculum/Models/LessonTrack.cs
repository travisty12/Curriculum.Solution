namespace Curriculum.Models
{
  public class LessonTrack
  {
    public int LessonTrackId { get; set; }
    public int LessonId { get; set; }
    public int TrackId { get; set; }
    public Lesson Lesson { get; set; }
    public Track Track { get; set; }
  }
}