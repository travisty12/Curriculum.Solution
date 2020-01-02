using System.Collections.Generic;
using System.Linq;
using System;
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
  public class LessonsController : Controller
  {
    private readonly CurriculumContext _db;
    private readonly UserManager<ApplicationUser> _userManager;

    public LessonsController(UserManager<ApplicationUser> userManager, CurriculumContext db)
    {
      _userManager = userManager;
      _db = db;
    }

    public ActionResult Index()
    {
      var query = Request.QueryString.ToString();
      List<Lesson> model = Lesson.GetAll(query).ToList();
      return View(model);
    }

    public ActionResult Create()
    {
      return View();
    }

    [Authorize]
    [HttpPost]
    public ActionResult Create(Lesson lesson)
    {
      Lesson.Send("lessons", lesson, "post");
      return RedirectToAction("Index");
    }

    public ActionResult Details(int id)
    {
      var query = Request.QueryString.ToString();
      Lesson thisLesson = Lesson.GetDetails(id, query);
      return View(thisLesson);
    }
    
    public ActionResult Edit(int id)
    {
      var query = Request.QueryString.ToString();
      Lesson thisLesson = Lesson.GetDetails(id, query);
      return View(thisLesson);
    }

    [Authorize]
    [HttpPost]
    public ActionResult Edit(Lesson lesson)
    {
      Lesson.Send($"lessons/{lesson.LessonId}", lesson, "put");
      return RedirectToAction("Details", "Lessons", new { id = lesson.LessonId });
    }

    public ActionResult AddTrack(int id)
    {
      Lesson thisLesson = Lesson.GetDetails(id, "");
      ViewBag.TrackId = new SelectList(_db.Tracks, "TrackId", "Name");
      return View(thisLesson);
    }

    [Authorize]
    [HttpPost]
    public ActionResult AddTrack(Lesson lesson, int TrackId)
    {
      LessonTrack lessonTrack = new LessonTrack { TrackId = TrackId, LessonId = lesson.LessonId };
      LessonTrack.Send("lessontracks", lessonTrack, "post");
      return RedirectToAction("Details", "Lessons", new {id = lesson.LessonId});
    }

    [Authorize]
    [HttpPost]
    public ActionResult DeleteTrack(int joinId)
    {
      LessonTrack joinEntry = LessonTrack.Get(joinId);
      int lessonId = joinEntry.LessonId;
      LessonTrack.Send($"lessontracks/{joinId}", joinEntry, "delete");
      return RedirectToAction("Details", "Lessons", new { id = lessonId });
    }

    public ActionResult Delete(int id)
    {
      var query = Request.QueryString.ToString();
      Lesson thisLesson = Lesson.GetDetails(id, query);
      return View(thisLesson);
    }

    [Authorize]
    [HttpPost, ActionName("Delete")]
    public ActionResult DeleteConfirmed(int id)
    {
      Lesson thisLesson = Lesson.GetDetails(id, "");
      Lesson.Send($"lessons/{id}", thisLesson, "delete");
      return RedirectToAction("Index");
    }
  }
}