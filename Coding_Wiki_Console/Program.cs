using CodingWiki_DataAccess.Data;
using CodingWiki_Model.Models;
using Microsoft.EntityFrameworkCore;

//AddBook();
//GetAllBooks();
GetBook();
void GetAllBooks()
{
    using var context = new ApplicationDbContext();
    var books = context.Books.ToList();
    foreach (var book in books)
    {
        Console.WriteLine(book.Title+" - "+book.ISBN);
    }
};

void GetBook()
{
    using var context = new ApplicationDbContext();
    var input = "4";
    var book = context.Books.Where(u=>EF.Functions.Like(u.ISBN,$"%{input}")).First();
    //foreach (var book in books)
    //{
        Console.WriteLine(book.Title + " - " + book.ISBN);
    //}
}
void AddBook()
{
    List<Book> books = new List<Book>
    {
        new Book {Title = "C# 14.0 in a Nutshell",ISBN = "978-1492097578",Price = 49.99m,Publisher_Id=1},
        new Book {Title = "Pro ASP.NET Core 7",ISBN = "978-1484279568",Price = 59.99m,Publisher_Id=1},
        new Book {Title = "Entity Framework Core in Action",ISBN = "978-1617294561",Price = 39.99m,Publisher_Id=3},
        new Book {Title = "Clean Code: A Handbook of Agile Software Craftsmanship",ISBN = "978-0132350884",Price = 29.99m,Publisher_Id=2},
    };
    using var context = new ApplicationDbContext();
    context.Books.AddRange(books);
    context.SaveChanges();
}