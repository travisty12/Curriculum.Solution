using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Curriculum.Models;

namespace Curriculum.Controllers
{
  public class TracksController : Controller
  {
    // private readonly CurriculumContext _db;
    // private readonly UserManager<ApplicationUser> _userManager;

    // public TracksController(UserManager<ApplicationUser> userManager, CurriculumContext db)
    // {
    //   _userManager = userManager;
    //   _db = db;
    // }

    public ActionResult Index()
    {
      var query = Request.QueryString.ToString();
      List<Track> model = Track.GetAll(query).ToList();
      // List<Track> model = _db.Tracks.ToList();
      return View(model);
    }

    public ActionResult Create()
    {
      return View();
    }

    // [Authorize]
    [HttpPost]
    public ActionResult Create(Track track)
    {
      Track.Send("tracks", track, "post");
      return RedirectToAction("Index");
    }

    public ActionResult Details(int id)
    {
      var query = Request.QueryString.ToString();
      Track thisTrack = Track.GetDetails(id, query);
      return View(thisTrack);
    }
    
    public ActionResult Edit(int id)
    {
      var query = Request.QueryString.ToString();
      Track thisTrack = Track.GetDetails(id, query);
      return View(thisTrack);
    }

    // [Authorize]
    [HttpPost]
    public ActionResult Edit(Track track)
    {
      Track.Send($"tracks/{track.TrackId}", track, "put");
      return RedirectToAction("Details", "Tracks", new { id = track.TrackId });
    }

    public ActionResult AddLesson(int id)
    {
      Track thisTrack = Track.GetDetails(id, "");
      List<Lesson> lessons = Lesson.GetAll("").ToList();
      ViewBag.LessonId = new SelectList(lessons, "LessonId", "Title");
      return View(thisTrack);
    }

    // [Authorize]
    [HttpPost]
    public ActionResult AddLesson(Track track, int LessonId)
    {
      LessonTrack lessonTrack = new LessonTrack { TrackId = track.TrackId, LessonId = LessonId };
      LessonTrack.Send("lessontracks", lessonTrack, "post");
      return RedirectToAction("Details", "Tracks", new { id = track.TrackId });
    }

    // [Authorize]
    [HttpPost]
    public ActionResult DeleteLesson(int joinId)
    {
      LessonTrack joinEntry = LessonTrack.Get(joinId);
      int trackId = joinEntry.TrackId;
      LessonTrack.Send($"lessontracks/{joinId}", joinEntry, "delete");
      return RedirectToAction("Details", "Tracks", new { id = trackId });
    }

    public ActionResult Delete(int id)
    {
      Track thisTrack = Track.GetDetails(id, "");
      return View(thisTrack);
    }

    // [Authorize]
    [HttpPost, ActionName("Delete")]
    public ActionResult DeleteConfirmed(int id)
    {
      Track thisTrack = Track.GetDetails(id, "");
      Track.Send($"tracks/{id}", thisTrack, "delete");
      return RedirectToAction("Index");
    }
  }
}