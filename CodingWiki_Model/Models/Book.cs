using System;
using System.Collections.Generic;
using System.Text;

namespace CodingWiki_Model.Models
{
    public class Book
    {
        public int IdBook { get; set; }
        public string Title { get; set; }
        public string ISBN { get; set; }
        public double Price { get; set; }
    }
}
