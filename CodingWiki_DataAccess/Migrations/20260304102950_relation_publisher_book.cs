using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace CodingWiki_DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class relation_publisher_book : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Author_Id",
                table: "Books",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Publisher_Id",
                table: "Books",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Books",
                keyColumn: "BookId",
                keyValue: 1,
                columns: new[] { "Author_Id", "Publisher_Id" },
                values: new object[] { null, 1 });

            migrationBuilder.UpdateData(
                table: "Books",
                keyColumn: "BookId",
                keyValue: 2,
                columns: new[] { "Author_Id", "Publisher_Id" },
                values: new object[] { null, 2 });

            migrationBuilder.UpdateData(
                table: "Books",
                keyColumn: "BookId",
                keyValue: 3,
                columns: new[] { "Author_Id", "Publisher_Id" },
                values: new object[] { null, 3 });

            migrationBuilder.InsertData(
                table: "Publishers",
                columns: new[] { "Publisher_Id", "Location", "Name" },
                values: new object[,]
                {
                    { 1, null, "Addison-Wesley Professional" },
                    { 2, null, "Prentice Hall" },
                    { 3, null, "Addison-Wesley Professional" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Books_Author_Id",
                table: "Books",
                column: "Author_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Books_Publisher_Id",
                table: "Books",
                column: "Publisher_Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Books_Authors_Author_Id",
                table: "Books",
                column: "Author_Id",
                principalTable: "Authors",
                principalColumn: "Author_Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Books_Publishers_Publisher_Id",
                table: "Books",
                column: "Publisher_Id",
                principalTable: "Publishers",
                principalColumn: "Publisher_Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Books_Authors_Author_Id",
                table: "Books");

            migrationBuilder.DropForeignKey(
                name: "FK_Books_Publishers_Publisher_Id",
                table: "Books");

            migrationBuilder.DropIndex(
                name: "IX_Books_Author_Id",
                table: "Books");

            migrationBuilder.DropIndex(
                name: "IX_Books_Publisher_Id",
                table: "Books");

            migrationBuilder.DeleteData(
                table: "Publishers",
                keyColumn: "Publisher_Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Publishers",
                keyColumn: "Publisher_Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Publishers",
                keyColumn: "Publisher_Id",
                keyValue: 3);

            migrationBuilder.DropColumn(
                name: "Author_Id",
                table: "Books");

            migrationBuilder.DropColumn(
                name: "Publisher_Id",
                table: "Books");
        }
    }
}
