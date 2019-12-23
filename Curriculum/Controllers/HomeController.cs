using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Curriculum.Models;
using Curriculum.ViewModels;

namespace ToDoList.Controllers
{
  public class HomeController : Controller
  {
    private readonly CurriculumContext _db;
    private readonly UserManager<ApplicationUser> _userManager;

    public HomeController(UserManager<ApplicationUser> userManager, CurriculumContext db)
    {
      _userManager = userManager;
      _db = db;
    }

    [HttpGet("/")]
    public ActionResult Index()
    {
      var model = new LessonsAndTracks {Lessons = _db.Lessons.ToList(), Tracks = _db.Tracks.ToList()};
      return View(model);
    }

  }
}