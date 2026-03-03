using System;
using System.Collections.Generic;
using System.Text;

namespace CodingWiki_Model.Models
{
    public class Book
    {
        public int BookId { get; set; }
        public string Title { get; set; }
        public string ISBN { get; set; }
        public decimal Price { get; set; }
    }
}
