using CodingWiki_Model.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace CodingWiki_DataAccess.Data
{
    public class ApplicationDbContext : DbContext
    {
        public DbSet<Book> Books { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Author> Authors { get; set; }
        public DbSet<Publisher> Publishers { get; set; }
        public DbSet<SubCategory> SubCategories { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            options.UseSqlServer("Server=CT-ICT004-LAP\\SQLEXPRESS;Database=CodingWiki_DB;Trusted_Connection=True;TrustServerCertificate=True;");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
             modelBuilder.Entity<Book>().Property(u=>u.Price).HasPrecision(10, 2);
            modelBuilder.Entity<Book>().HasData(
                new Book
                {
                    BookId = 1,
                    Title = "The Pragmatic Programmer",
                    ISBN = "978-0201616224",
                    Price = 42.99m,
                },
                new Book
                {
                    BookId = 2,
                    Title = "Clean Code: A Handbook of Agile Software Craftsmanship",
                    ISBN = "978-0132350884",
                    Price = 37.99m,
                },
                new Book
                {
                    BookId = 3,
                    Title = "Design Patterns: Elements of Reusable Object-Oriented Software",
                    ISBN = "978-0201633610",
                    Price = 54.99m,
                }
            );
        }
    }
}
