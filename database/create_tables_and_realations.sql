create table Countries
(
	CountryID int identity(1 , 1) primary key,
	CountryName varchar(255)
)

create table Users
(
	UserId int identity(1 , 1) primary key,
	Username varchar(255) not null,
	Email varchar(255),
	passwordHash varchar(255)not null,
	[status] varchar(20) not null,
	AddressLine1 varchar(255),
	AddressLine2 varchar(255),
	city varchar(50) not null,
	[state] varchar(50),
	postalCode varchar(70),
	CountryID int ,
	CreatedAt date default getdate(),
	constraint FK_Users_Contries foreign key(CountryID) references Countries(CountryID),
	constraint ch_Users_status check([status] in ('Active' , 'Terminated' , 'Inactive'))
)

create table categories
(
	CategoryID int identity(1 , 1) primary key,
	CategoryName varchar(255) not null ,
	[description] varchar(255)
)

CREATE TABLE Items (
    ItemID INT IDENTITY(1,1) PRIMARY KEY,
    SellerID INT NOT NULL,
    CategoryID INT NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    [Description] NVARCHAR(MAX),
    StartingPrice DECIMAL(10, 2) NOT NULL CHECK (StartingPrice >= 0),
    CurrentPrice DECIMAL(10, 2) NOT NULL CHECK (CurrentPrice >= 0),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    ImageURL NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Items_Users FOREIGN KEY (SellerID) REFERENCES Users(UserID),
    CONSTRAINT FK_Items_categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Bids (
    BidID INT IDENTITY(1,1) PRIMARY KEY,
    ItemID INT NOT NULL,
    UserID INT NOT NULL,
    BidAmount DECIMAL(10, 2) NOT NULL CHECK (BidAmount > 0),
    BidTime DATETIME NOT NULL,
    CONSTRAINT FK_Bids_Items FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    CONSTRAINT FK_Bids_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    BuyerID INT NOT NULL,
    ItemID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2) NOT NULL CHECK (TotalAmount >= 0),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (BuyerID) REFERENCES Users(UserID),
    CONSTRAINT FK_Orders_Items FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

CREATE TABLE Notifications (
    NotificationID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    [Message] NVARCHAR(MAX) NOT NULL,
    IsRead BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Notifications_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


