using Microsoft.AspNetCore.Mvc;
using Curriculum.Models;
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
      var model = new LessonsAndTracks {Lessons = Lesson.GetAll(""), Tracks = Track.GetAll("")};
      return View(model);
    }

  }
}