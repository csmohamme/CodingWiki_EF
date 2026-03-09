using CodingWiki_DataAccess.Data;
using CodingWiki_Model.Models;
using Microsoft.AspNetCore.Mvc;

namespace CodingWiki_Web.Controllers
{
    public class AuthorController : Controller
    {
        private readonly ApplicationDbContext _db;

        public AuthorController(ApplicationDbContext db)
        {
            _db = db;
        }
        public IActionResult Index()
        {
            List<Author> authors = _db.Authors.ToList();
            return View(authors);
        }

        public IActionResult Upsert(int? id)
        {
            Author author = new Author();
            if (id == null)
            {
                return View(author);
            }
            author = _db.Authors.Find(id);
            if (author == null)
            {
                return NotFound();
            }
            return View(author);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Upsert(Author author)
        {
            if (ModelState.IsValid)
            {
                if (author.Author_Id == 0)
                {
                    await _db.Authors.AddAsync(author);
                }
                else
                {
                    _db.Authors.Update(author);
                }

                await _db.SaveChangesAsync();
            }
            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> Delete(int id)
        {
            Author author = _db.Authors.Find(id);
            if (author == null)
            {
                return NotFound();
            }
            _db.Authors.Remove(author);
            await _db.SaveChangesAsync();
            return RedirectToAction(nameof(Index));

        }
    }
}
