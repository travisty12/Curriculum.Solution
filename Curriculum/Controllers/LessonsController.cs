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
      List<Lesson> model = _db.Lessons.ToList();
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
      _db.Lessons.Add(lesson);
      _db.SaveChanges();
      return RedirectToAction("Index");
    }

    public ActionResult Details(int id)
    {
      Lesson thisLesson = _db.Lessons
        .Include(lesson => lesson.Lessons)
        .ThenInclude(join => join.Lesson)
        .FirstOrDefault(lesson => lesson.LessonId == id);
      return View(thisLesson);
    }
    
    public ActionResult Edit(int id)
    {
      Lesson thisLesson = _db.Lessons.FirstOrDefault(lesson => lesson.LessonId == id);
      return View(thisLesson);
    }

    [Authorize]
    [HttpPost]
    public ActionResult Edit(Lesson lesson)
    {
      _db.Entry(lesson).State = EntityState.Modified;
      _db.SaveChanges();
      return RedirectToAction("Index");
    }

    public ActionResult Delete(int id)
    {
      Lesson thisLesson = _db.Lessons.FirstOrDefault(lesson => lesson.LessonId == id);
      return View(thisLesson);
    }

    [Authorize]
    [HttpPost, ActionName("Delete")]
    public ActionResult DeleteConfirmed(int id)
    {
      Lesson thisLesson = _db.Lessons.FirstOrDefault(lesson => lesson.LessonId == id);
      _db.Lessons.Remove(thisLesson);
      _db.SaveChanges();
      return RedirectToAction("Index");
    }
  }
}