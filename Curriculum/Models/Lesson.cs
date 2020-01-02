using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Curriculum.Models
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
    public virtual ApplicationUser User { get; set; }

    public virtual ICollection<LessonTrack> Tracks { get; }

    public static List<Lesson> GetAll(string query)
    {
      string route = $"lessons{query}";
      var apiCallTask = ApiHelper.Get(route);
      var result = apiCallTask.Result;

      JArray jsonResponse = JsonConvert.DeserializeObject<JArray>(result);
      List<Lesson> lessonList = JsonConvert.DeserializeObject<List<Lesson>>(jsonResponse.ToString());

      return lessonList;
    }

    public static Lesson GetDetails(int id, string query)
    {
      string route = $"lessons/{id}{query}";
      var apiCallTask = ApiHelper.Get(route);
      var result = apiCallTask.Result;

      JObject jsonResponse = JsonConvert.DeserializeObject<JObject>(result);
      Lesson lesson = JsonConvert.DeserializeObject<Lesson>(jsonResponse.ToString());

      return lesson;
    }

    public static void Send(string route, Lesson lesson, string method)
    {
      string jsonLesson = JsonConvert.SerializeObject(lesson);
      var apiCallTask = ApiHelper.Send(route, jsonLesson, method);
    }

  }
}