using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Curriculum.Models
{
  public class LessonTrack
  {
    public int LessonTrackId { get; set; }
    public int LessonId { get; set; }
    public int TrackId { get; set; }
    public Lesson Lesson { get; set; }
    public Track Track { get; set; }

    public static LessonTrack Get(int id) 
    {
      string route = $"lessontracks/{id}";
      var apiCallTask = ApiHelper.Get(route);
      var result = apiCallTask.Result;

      JObject jsonResponse = JsonConvert.DeserializeObject<JObject>(result);
      LessonTrack lessonTrack = JsonConvert.DeserializeObject<LessonTrack>(jsonResponse.ToString());

      return lessonTrack;
    }
    public static void Send(string route, LessonTrack lessonTrack, string method)
    {
      string jsonJoin = JsonConvert.SerializeObject(lessonTrack);
      var apiCallTask = ApiHelper.Send(route, jsonJoin, method);
    }
  }
}