IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260303103337_add_Book_Tbl'
)
BEGIN
    CREATE TABLE [Books] (
        [BookId] int NOT NULL IDENTITY,
        [Title] nvarchar(max) NOT NULL,
        [ISBN] nvarchar(max) NOT NULL,
        [Price] float NOT NULL,
        CONSTRAINT [PK_Books] PRIMARY KEY ([BookId])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260303103337_add_Book_Tbl'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260303103337_add_Book_Tbl', N'10.0.3');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260303104838_change_Price_dataType_Book_Tbl'
)
BEGIN
    DECLARE @var nvarchar(max);
    SELECT @var = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Books]') AND [c].[name] = N'Price');
    IF @var IS NOT NULL EXEC(N'ALTER TABLE [Books] DROP CONSTRAINT ' + @var + ';');
    ALTER TABLE [Books] ALTER COLUMN [Price] decimal(18,2) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260303104838_change_Price_dataType_Book_Tbl'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260303104838_change_Price_dataType_Book_Tbl', N'10.0.3');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260303115042_add_Genre_Tbl'
)
BEGIN
    CREATE TABLE [Genres] (
        [GenreId] int NOT NULL IDENTITY,
        [GenreName] nvarchar(max) NULL,
        [Display] int NOT NULL,
        CONSTRAINT [PK_Genres] PRIMARY KEY ([GenreId])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260303115042_add_Genre_Tbl'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260303115042_add_Genre_Tbl', N'10.0.3');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260303124131_add_data_to_book_Tbl'
)
BEGIN
    ALTER TABLE [Books] ADD [Author] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260303124131_add_data_to_book_Tbl'
)
BEGIN
    ALTER TABLE [Books] ADD [PublicationDate] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260303124131_add_data_to_book_Tbl'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BookId', N'Author', N'ISBN', N'Price', N'PublicationDate', N'Title') AND [object_id] = OBJECT_ID(N'[Books]'))
        SET IDENTITY_INSERT [Books] ON;
    EXEC(N'INSERT INTO [Books] ([BookId], [Author], [ISBN], [Price], [PublicationDate], [Title])
    VALUES (1, N''Andrew Hunt and David Thomas'', N''978-0201616224'', 42.99, ''2015-10-30T00:00:00.0000000'', N''The Pragmatic Programmer''),
    (2, N''Robert C. Martin'', N''978-0132350884'', 37.99, ''2008-08-11T00:00:00.0000000'', N''Clean Code: A Handbook of Agile Software Craftsmanship''),
    (3, N''Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides'', N''978-0201633610'', 54.99, ''1994-10-31T00:00:00.0000000'', N''Design Patterns: Elements of Reusable Object-Oriented Software'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BookId', N'Author', N'ISBN', N'Price', N'PublicationDate', N'Title') AND [object_id] = OBJECT_ID(N'[Books]'))
        SET IDENTITY_INSERT [Books] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260303124131_add_data_to_book_Tbl'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260303124131_add_data_to_book_Tbl', N'10.0.3');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304081838_readd_columns_to_book_and_category'
)
BEGIN
    DROP TABLE [Genres];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304081838_readd_columns_to_book_and_category'
)
BEGIN
    DECLARE @var1 nvarchar(max);
    SELECT @var1 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Books]') AND [c].[name] = N'Author');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Books] DROP CONSTRAINT ' + @var1 + ';');
    ALTER TABLE [Books] DROP COLUMN [Author];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304081838_readd_columns_to_book_and_category'
)
BEGIN
    DECLARE @var2 nvarchar(max);
    SELECT @var2 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Books]') AND [c].[name] = N'PublicationDate');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Books] DROP CONSTRAINT ' + @var2 + ';');
    ALTER TABLE [Books] DROP COLUMN [PublicationDate];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304081838_readd_columns_to_book_and_category'
)
BEGIN
    DECLARE @var3 nvarchar(max);
    SELECT @var3 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Books]') AND [c].[name] = N'Title');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Books] DROP CONSTRAINT ' + @var3 + ';');
    ALTER TABLE [Books] ALTER COLUMN [Title] nvarchar(255) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304081838_readd_columns_to_book_and_category'
)
BEGIN
    DECLARE @var4 nvarchar(max);
    SELECT @var4 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Books]') AND [c].[name] = N'Price');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Books] DROP CONSTRAINT ' + @var4 + ';');
    ALTER TABLE [Books] ALTER COLUMN [Price] decimal(10,2) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304081838_readd_columns_to_book_and_category'
)
BEGIN
    DECLARE @var5 nvarchar(max);
    SELECT @var5 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Books]') AND [c].[name] = N'ISBN');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Books] DROP CONSTRAINT ' + @var5 + ';');
    ALTER TABLE [Books] ALTER COLUMN [ISBN] nvarchar(20) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304081838_readd_columns_to_book_and_category'
)
BEGIN
    CREATE TABLE [Categories] (
        [CategoryId] int NOT NULL IDENTITY,
        [CategoryName] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Categories] PRIMARY KEY ([CategoryId])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304081838_readd_columns_to_book_and_category'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260304081838_readd_columns_to_book_and_category', N'10.0.3');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304084238_add_author_publisher_subCategory_tbl'
)
BEGIN
    CREATE TABLE [Authors] (
        [Author_Id] int NOT NULL IDENTITY,
        [FirstName] nvarchar(50) NOT NULL,
        [LastName] nvarchar(max) NULL,
        [BirthDate] date NOT NULL,
        [Location] nvarchar(max) NULL,
        CONSTRAINT [PK_Authors] PRIMARY KEY ([Author_Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304084238_add_author_publisher_subCategory_tbl'
)
BEGIN
    CREATE TABLE [Publishers] (
        [Publisher_Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Location] nvarchar(max) NULL,
        CONSTRAINT [PK_Publishers] PRIMARY KEY ([Publisher_Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304084238_add_author_publisher_subCategory_tbl'
)
BEGIN
    CREATE TABLE [SubCategories] (
        [SubCategory_Id] int NOT NULL IDENTITY,
        [Name] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_SubCategories] PRIMARY KEY ([SubCategory_Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304084238_add_author_publisher_subCategory_tbl'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260304084238_add_author_publisher_subCategory_tbl', N'10.0.3');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304090441_add_bookDetail_tbl'
)
BEGIN
    ALTER TABLE [Books] ADD [BookDetailId] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304090441_add_bookDetail_tbl'
)
BEGIN
    CREATE TABLE [BookDetails] (
        [BookDetailId] int NOT NULL IDENTITY,
        [NumberOfChapters] int NOT NULL,
        [NumberOfPages] int NOT NULL,
        [Weight] float NOT NULL,
        CONSTRAINT [PK_BookDetails] PRIMARY KEY ([BookDetailId])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304090441_add_bookDetail_tbl'
)
BEGIN
    EXEC(N'UPDATE [Books] SET [BookDetailId] = 0
    WHERE [BookId] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304090441_add_bookDetail_tbl'
)
BEGIN
    EXEC(N'UPDATE [Books] SET [BookDetailId] = 0
    WHERE [BookId] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304090441_add_bookDetail_tbl'
)
BEGIN
    EXEC(N'UPDATE [Books] SET [BookDetailId] = 0
    WHERE [BookId] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260304090441_add_bookDetail_tbl'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260304090441_add_bookDetail_tbl', N'10.0.3');
END;

COMMIT;
GO