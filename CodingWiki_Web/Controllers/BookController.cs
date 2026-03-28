using CodingWiki_DataAccess.Data;
using CodingWiki_Model.Models;
using CodingWiki_Model.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace CodingWiki_Web.Controllers
{
    public class BookController : Controller
    {
        private readonly ApplicationDbContext _db;

        public BookController(ApplicationDbContext db)
        {
            _db = db;
        }
        public IActionResult Index()
        {
            List<Book> bookList = _db.Books.ToList();
            return View(bookList);
        }

        public IActionResult Upsert(int? id)
        {
            BookVM bookVM = new BookVM();
            bookVM.PublisherList = _db.Publishers.Select(p => new SelectListItem
            {
                Text = p.Name,
                Value = p.Publisher_Id.ToString()
            });

            if (id == null || id == 0)
            {
                return View(bookVM);
            }
            bookVM.Book = _db.Books.Find(id);
            return View(bookVM);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Upsert(BookVM bookVM)
        {
            if (bookVM.Book.BookId == 0)
            {
                await _db.Books.AddAsync(bookVM.Book);
            }
            else
            {
                _db.Books.Update(bookVM.Book);
            }
            await _db.SaveChangesAsync();
            return RedirectToAction("Index");
            bookVM.PublisherList = _db.Publishers.Select(p => new SelectListItem
            {
                Text = p.Name,
                Value = p.Publisher_Id.ToString()
            });
            return View(bookVM);
        }

        public async Task<IActionResult> delete(int id)
        {
            Book book = _db.Books.Find(id);
            if (book == null)
            {
                return NotFound();
            }
            _db.Books.Remove(book);
            await _db.SaveChangesAsync();
            return RedirectToAction("Index");
        }
    }
}
