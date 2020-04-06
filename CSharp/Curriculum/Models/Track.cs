using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

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
    // public virtual ApplicationUser User { get; set; }

    public virtual ICollection<LessonTrack> Lessons { get; }

    public static List<Track> GetAll(string query)
    {
      string route = $"tracks{query}";
      var apiCallTask = ApiHelper.Get(route);
      var result = apiCallTask.Result;

      JArray jsonResponse = JsonConvert.DeserializeObject<JArray>(result);
      List<Track> trackList = JsonConvert.DeserializeObject<List<Track>>(jsonResponse.ToString());

      return trackList;
    }

    public static Track GetDetails(int id, string query)
    {
      string route = $"tracks/{id}{query}";
      var apiCallTask = ApiHelper.Get(route);
      var result = apiCallTask.Result;

      JObject jsonResponse = JsonConvert.DeserializeObject<JObject>(result);
      Track track = JsonConvert.DeserializeObject<Track>(jsonResponse.ToString());

      return track;
    }

    public static void Send(string route, Track track, string method)
    {
      string jsonTrack = JsonConvert.SerializeObject(track);
      var apiCallTask = ApiHelper.Send(route, jsonTrack, method);
    }
  }
}