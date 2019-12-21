using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Curriculum.Models;

namespace Curriculum.Controllers
{
  public class TracksController : Controller
  {
    private readonly CurriculumContext _db;
    private readonly UserManager<ApplicationUser> _userManager;

    public TracksController(UserManager<ApplicationUser> userManager, CurriculumContext db)
    {
      _userManager = userManager;
      _db = db;
    }

    public ActionResult Index()
    {
      List<Track> model = _db.Tracks.ToList();
      return View(model);
    }

    public ActionResult Create()
    {
      return View();
    }

    [Authorize]
    [HttpPost]
    public ActionResult Create(Track track)
    {
      _db.Tracks.Add(track);
      _db.SaveChanges();
      return RedirectToAction("Index");
    }

    public ActionResult Details(int id)
    {
      Track thisTrack = _db.Tracks
        .Include(track => track.Lessons)
        .ThenInclude(join => join.Lesson)
        .FirstOrDefault(track => track.TrackId == id);
      return View(thisTrack);
    }
    
    public ActionResult Edit(int id)
    {
      Track thisTrack = _db.Tracks.FirstOrDefault(track => track.TrackId == id);
      return View(thisTrack);
    }

    [Authorize]
    [HttpPost]
    public ActionResult Edit(Track track)
    {
      _db.Entry(track).State = EntityState.Modified;
      _db.SaveChanges();
      return RedirectToAction("Index");
    }

    public ActionResult AddLesson(int id)
    {
      Lesson thisTrack = _db.Tracks.FirstOrDefault(track => track.TrackId == id);
      ViewBag.LessonId = new SelectList(_db.Lessons, "LessonId", "Name");
      return View(thisTrack);
    }

    [Authorize]
    [HttpPost]
    public ActionResult AddLesson(Track track, int LessonId)
    {
      if (LessonId != 0)
      {
        _db.TrackLesson.Add(new TrackLesson { TrackId = track.TrackId, LessonId = LessonId });
      }
      _db.SaveChanges();
      return RedirectToAction("Index");
    }

    [Authorize]
    [HttpPost]
    public ActionResult DeleteLesson(int joinId)
    {
      TrackLesson joinEntry = _db.TrackLesson.FirstOrDefault(entry => entry.TrackLessonId == joinId);
      _db.TrackLesson.Remove(joinEntry);
      _db.SaveChanges();
      return RedirectToAction("Index");
    }

    public ActionResult Delete(int id)
    {
      Track thisTrack = _db.Tracks.FirstOrDefault(track => track.TrackId == id);
      return View(thisTrack);
    }

    [Authorize]
    [HttpPost, ActionName("Delete")]
    public ActionResult DeleteConfirmed(int id)
    {
      Track thisTrack = _db.Tracks.FirstOrDefault(track => track.TrackId == id);
      _db.Tracks.Remove(thisTrack);
      _db.SaveChanges();
      return RedirectToAction("Index");
    }
  }
}