using CodingWiki_DataAccess.Data;
using CodingWiki_Model.Models;
using Microsoft.AspNetCore.Mvc;

namespace CodingWiki_Web.Controllers
{
    public class PublisherController : Controller
    {
        private readonly ApplicationDbContext _db;

        public PublisherController(ApplicationDbContext db)
        {
            _db = db;
        }
        public IActionResult Index()
        {
            List<Publisher> publishers = _db.Publishers.ToList();
            return View(publishers);
        }

        public IActionResult Upsert(int? id)
        {
            Publisher publisher = new Publisher();
            if (id == null || id == 0)
            {
                return View(publisher);
            }
            else
            {
                publisher = _db.Publishers.Find(id);
                if (publisher == null)
                {
                    return NotFound();
                }
                return View(publisher);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Upsert(Publisher publisher)
        {
            if (ModelState.IsValid)
            {
                if (publisher.Publisher_Id == 0)
                {
                    await _db.Publishers.AddAsync(publisher);
                }
                else
                {
                    _db.Publishers.Update(publisher);
                }
                await _db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(publisher);
        }

        public async Task<IActionResult> Delete(int id)
        {
            Publisher publisher = _db.Publishers.Find(id);
            if (publisher == null)
            {
                return NotFound();
            }
            _db.Publishers.Remove(publisher);
            await _db.SaveChangesAsync();
            return RedirectToAction("Index");
        }
    }
}
