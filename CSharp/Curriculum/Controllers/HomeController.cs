using Microsoft.AspNetCore.Mvc;
using Curriculum.Models;
using System.Collections.Generic;
using Curriculum.ViewModels;

namespace Curriculum.Controllers
{
  public class HomeController : Controller
  {
    public HomeController()
    {
    }

    [HttpGet("/")]
    public ActionResult Index()
    {
      var model = new Dictionary<string,object>() {
        {"Lessons", Lesson.GetAll("")},
        {"Tracks", Track.GetAll("")}
      };
      return View(model);
    }

  }
}