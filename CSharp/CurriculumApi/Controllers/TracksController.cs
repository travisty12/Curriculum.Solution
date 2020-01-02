using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using CurriculumApi.Models;

namespace CurriculumApi.Controllers
{
  [Route("api/[controller]")]
  [ApiController]
  public class TracksController : ControllerBase
  {
    private CurriculumApiContext _db;

    public TracksController(CurriculumApiContext db)
    {
      _db = db;
    }

    // GET api/tracks
    public ActionResult<IEnumerable<Track>> Get(string name)
    {
      var query = _db.Tracks.AsQueryable();

      if (name != null)
      {
        query = query.Where(entry => entry.Name == name);
      }
      
      return query.ToList();
    }

    // POST api/tracks
    [HttpPost]
    public void Post([FromBody] Track track)
    {
      _db.Tracks.Add(track);
      _db.SaveChanges();
    }

    // GET api/tracks/5
    [HttpGet("{id}")]
    public ActionResult<Track> Get(int id)
    {
      Track thisTrack = _db.Tracks
        .Include(track => track.Lessons)
        .ThenInclude(join => join.Lesson)
        .FirstOrDefault(track => track.TrackId == id);
      return thisTrack;
    }

    // PUT api/tracks/5
    [HttpPut("{id}")]
    public void Put(int id, [FromBody] Track track)
    {
      track.TrackId = id;
      _db.Entry(track).State = EntityState.Modified;
      _db.SaveChanges();
    }

    // [HttpPost]
    // public void AddLesson(Track track, int LessonId)
    // {
    //   if (LessonId != 0)
    //   {
    //     _db.LessonTrack.Add(new LessonTrack { TrackId = track.TrackId, LessonId = LessonId });
    //   }
    //   _db.SaveChanges();
    // }

    // [HttpPost]
    // public void DeleteLesson(int joinId)
    // {
    //   LessonTrack joinEntry = _db.LessonTrack.FirstOrDefault(entry => entry.LessonTrackId == joinId);
    //   _db.LessonTrack.Remove(joinEntry);
    //   _db.SaveChanges();
    // }

    [HttpDelete("{id}")]
    public void Delete(int id)
    {
      Track thisTrack = _db.Tracks.FirstOrDefault(track => track.TrackId == id);
      _db.Tracks.Remove(thisTrack);
      _db.SaveChanges();
    }
  }
}