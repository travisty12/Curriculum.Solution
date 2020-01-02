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
  public class LessonsController : ControllerBase
  {
    private CurriculumApiContext _db;

    public LessonsController(CurriculumApiContext db)
    {
      _db = db;
    }

    // GET api/lessons
    public ActionResult<IEnumerable<Lesson>> Get(string title, string content)
    {
      var query = _db.Lessons.AsQueryable();

      if (title != null)
      {
        query = query.Where(entry => entry.Title.Contains(title));
      }
      
      if (content != null)
      {
        query = query.Where(entry => entry.Content.Contains(content));
      }
      return query.ToList();
    }

    // POST api/lessons
    [HttpPost]
    public void Post([FromBody] Lesson lesson)
    {
      _db.Lessons.Add(lesson);
      _db.SaveChanges();
    }

    // GET api/lessons/5
    [HttpGet("{id}")]
    public ActionResult<Lesson> Get(int id)
    {
      Lesson thisLesson = _db.Lessons
        .Include(lesson => lesson.Tracks)
        .ThenInclude(join => join.Track)
        .FirstOrDefault(lesson => lesson.LessonId == id);
      return thisLesson;
    }

    // PUT api/lessons/5
    [HttpPut("{id}")]
    public void Put(int id, [FromBody] Lesson lesson)
    {
      lesson.LessonId = id;
      _db.Entry(lesson).State = EntityState.Modified;
      _db.SaveChanges();
    }

    [HttpDelete("{id}")]
    public void Delete(int id)
    {
      Lesson thisLesson = _db.Lessons.FirstOrDefault(lesson => lesson.LessonId == id);
      _db.Lessons.Remove(thisLesson);
      _db.SaveChanges();
    }
  }
}