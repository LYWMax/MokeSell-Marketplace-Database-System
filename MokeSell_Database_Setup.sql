
/* MokeSell Database SetUp				
   MokeSell_Setup.sql					*/

/*** Delete database if it exists ***/
USE master
IF EXISTS(select * from sys.databases where name='MokeSell_Setup')
DROP DATABASE MokeSell_Setup;
GO

Create Database MokeSell_Setup; --Creates Database, titled 'MokeSell_Setup'
GO

use MokeSell_Setup;
GO

/*** Delete tables (if they exist) before creating ***/

/* Table: dbo.Review */
if exists (select * from sysobjects 
	where id = object_id('dbo.Review') and sysstat & 0xf = 3) 
	drop table dbo.Review;
GO

/* Table: dbo.Offer */
if exists (select * from sysobjects
	where id = object_id('dbo.Offer') and sysstat & 0xf = 3)
	drop table dbo.Offer;
GO

/* Table: dbo.ChatMsg */
if exists (select * from sysobjects
	where id = object_id('dbo.ChatMsg') and sysstat & 0xf = 3)
	drop table dbo.ChatMsg;
GO

/* Table: dbo.Chat */
if exists (select * from sysobjects
	where id = object_id('dbo.Chat') and sysstat & 0xf = 3)
	drop table dbo.Chat;
GO

/* Table: dbo.Likes */
if exists (select * from sysobjects
	where id = object_id('dbo.Likes') and sysstat & 0xf = 3)
	drop table dbo.Likes;
GO

/* Table: dbo.BumpOrder */
if exists (select * from sysobjects
	where id = object_id('dbo.BumpOrder') and sysstat & 0xf = 3)
	drop table dbo.BumpOrder;
GO

/* Table: dbo.ListingPhoto */
if exists (select * from sysobjects
	where id = object_id('dbo.ListingPhoto') and sysstat & 0xf = 3)
	drop table dbo.ListingPhoto;
GO

/* Table: dbo.Listing */
if exists (select * from sysobjects
	where id = object_id('dbo.Listing') and sysstat & 0xf = 3)
	drop table dbo.Listing;
GO

/* Table: dbo.Seller */
if exists (select * from sysobjects
	where id = object_id('dbo.Seller') and sysstat & 0xf = 3)
	drop table dbo.Seller;
GO

/* Table: dbo.Buyer */
if exists (select * from sysobjects
	where id = object_id('dbo.Buyer') and sysstat & 0xf = 3)
	drop table dbo.Buyer;
GO

/* Table: dbo.Feedback */
if exists (select * from sysobjects
	where id = object_id('dbo.Feedback') and sysstat & 0xf = 3)
	drop table dbo.Feedback;
GO

/* Table: dbo.Win */
if exists (select * from sysobjects
	where id = object_id('dbo.Win') and sysstat & 0xf = 3)
	drop table dbo.Win;
GO

/* Drop foreign key constraint in dbo.Staff to dbo.Team */
if exists (select * from sysobjects 
  where id = object_id('dbo.Staff') and sysstat & 0xf = 3)
  ALTER TABLE dbo.Staff
  DROP CONSTRAINT FK_Staff_TeamID;
GO

/* Table: dbo.Team */
if exists (select * from sysobjects
	where id = object_id('dbo.Team') and sysstat & 0xf = 3)
	drop table dbo.Team;
GO

/* Table: dbo.Staff */
if exists (select * from sysobjects
	where id = object_id('dbo.Staff') and sysstat & 0xf = 3)
	drop table dbo.Staff;
GO

/* Table: dbo.FeedbkCat */
if exists (select * from sysobjects
	where id = object_id('dbo.FeedbkCat') and sysstat & 0xf = 3)
	drop table dbo.FeedbkCat;
GO

/* Table: dbo.Follower */
if exists (select * from sysobjects
	where id = object_id('dbo.Follower') and sysstat & 0xf = 3)
	drop table dbo.Follower;
GO

/* Table: dbo.Member */
if exists (select * from sysobjects
	where id = object_id('dbo.Member') and sysstat & 0xf = 3)
	drop table dbo.Member;
GO

/* Table: dbo.SubCategory */
if exists (select * from sysobjects
	where id = object_id('dbo.SubCategory') and sysstat & 0xf = 3)
	drop table dbo.SubCategory;
GO

/* Table: Category */
if exists (select * from sysobjects
	where id = object_id('dbo.Category') and sysstat & 0xf = 3)
	drop table dbo.Category;
GO

/* Table: dbo.Bump */
if exists (select * from sysobjects
	where id = object_id('dbo.Bump') and sysstat & 0xf = 3)
	drop table dbo.Bump;
GO

/* Table: dbo.Award */
if exists (select * from sysobjects
	where id = object_id('dbo.Award') and sysstat & 0xf = 3)
	drop table dbo.Award;
GO


/*** Create tables ***/

/* Table: dbo.Award */
--S/N: 01-> Award(AwardID, AwardName, AwardAmt)--
CREATE TABLE dbo.Award
(
	AwardID			tinyint,        --Primary Key
	AwardName		varchar(50)		NOT NULL,
	AwardAmt		smallmoney		NOT NULL	Check(AwardAmt >= 0),
	CONSTRAINT PK_Award PRIMARY KEY (AwardID)
);
GO

/* Table: dbo.Bump */
--S/N: 02 -> Bump(BumpID, BumpDesc, BumpPrice) --
CREATE TABLE dbo.Bump
(
	BumpID			tinyint,		--Primary Key
	BumpDesc		varchar(150)	NOT NULL,
	BumpPrice		smallmoney		NOT NULL	Check(BumpPrice >= 0),
	CONSTRAINT PK_Bump PRIMARY KEY (BumpID)
);
GO

/* Table: dbo.Category */
--S/N: 05 -> Category(CatID, CatDesc) --
CREATE TABLE dbo.Category
(
	CatID			tinyint,		--Primary Key
	CatDesc			varchar(150)	NOT NULL,
	CONSTRAINT PK_Category PRIMARY KEY (CatID)
);
GO

/* Table: dbo.SubCategory */
--S/N: 19 -> SubCategory(SubCatID, SubCatDesc, <CatID>) --
CREATE TABLE dbo.SubCategory
(
	SubCatID		tinyint,		--Primary Key
	SubCatDesc		varchar(150)	NOT NULL,
	CatID			tinyint			NOT NULL,  --Foreign Key
	CONSTRAINT PK_SubCategory PRIMARY KEY (SubCatID),
	CONSTRAINT FK_SubCategory_CatID FOREIGN KEY (CatID) REFERENCES dbo.Category(CatID)
);
GO

/* Table: dbo.Member */
--S/N: 14 -> Member(MemberID, MemberName, MemberDOB, MemberEmail, MemberMobile, MemberDateJoined, City) --
CREATE TABLE dbo.Member
(
	MemberID		smallint,		--Primary Key
	MemberName		varchar(50)		NOT NULL,
	MemberDOB		smalldatetime	NOT NULL	Check(MemberDOB < GETDATE()),
	MemberEmail		varchar(50)		NOT NULL,
	MemberMobile	char(10)		NOT NULL,
	MemberDateJoined smalldatetime	NOT NULL	DEFAULT(GETDATE())
												Check(MemberDateJoined <= GETDATE()),
	City			varchar(50)		NOT NULL,
	CONSTRAINT PK_Member PRIMARY KEY (MemberID)
);
GO

/* Table: dbo.Follower */
--S/N: 10 -> Follower(<MemberID>, <FollowerID>, DateStarted) --
CREATE TABLE dbo.Follower
(
	MemberID		smallint,	--PK & FK -> Cannot be null
	FollowerID		smallint,	--PK & FK -> Cannot be null
	DateStarted		smalldatetime	NOT NULL	DEFAULT(GETDATE())
												Check(DateStarted <= GETDATE()),
	CONSTRAINT PK_Follower PRIMARY KEY (MemberID, FollowerID),
	CONSTRAINT FK_Follower_MemberID FOREIGN KEY (MemberID) REFERENCES dbo.Member(MemberID),
	CONSTRAINT FK_Follower_DateStarted FOREIGN KEY (FollowerID) REFERENCES dbo.Member(MemberID)
);
GO

/* Table: dbo.FeedbkCat */
--S/N: 09 -> FeedbkCat(FbkCatID, FbkCatDesc) --
CREATE TABLE dbo.FeedbkCat
(
	FbkCatID		tinyint,		--Primary Key
	FbkCatDesc		varchar(150)	NOT NULL,
	CONSTRAINT PK_FeedbkCat PRIMARY KEY (FbkCatID)
);
GO

/* Table: dbo.Staff */
--S/N: 18 -> Staff(StaffID, StaffName, StaffMobile, StaffDateJoined, <TeamID>) --
CREATE TABLE dbo.Staff
(
	StaffID			tinyint,		--Primary Key
	StaffName		varchar(50)		NOT NULL,
	StaffMobile		char(10)		NOT NULL,
	StaffDateJoined	smalldatetime	NOT NULL	DEFAULT(GETDATE())
												Check(StaffDateJoined <= GETDATE()),
	TeamID			tinyint			NOT NULL, --Foreign Key
	CONSTRAINT PK_Staff PRIMARY KEY (StaffID)
); -- Add TeamID (Foreign Key) after creating Team Table 
GO

/* Table: dbo.Team */ 
--S/N: 20 -> Team(TeamID, TeamName, <TeamLeaderID>) --
CREATE TABLE dbo.Team
(
	TeamID			tinyint,		--Primary Key
	TeamName		varchar(50)		NOT NULL,
	TeamLeaderID	tinyint,		--Foreign Key, can be null
	CONSTRAINT PK_Team PRIMARY KEY (TeamID),
	CONSTRAINT FK_Team_TeamLeaderID FOREIGN KEY (TeamLeaderID) REFERENCES dbo.Staff(StaffID)
);
GO

/* Add foreign key constraint to dbo.Staff */
ALTER TABLE dbo.Staff
	ADD CONSTRAINT FK_Staff_TeamID FOREIGN KEY (TeamID) REFERENCES dbo.Team(TeamID);
GO

/* Table: dbo.Win */
--S/N: 21 -> Win(<AwardID>, <TeamID>, DateAwarded) --
CREATE TABLE dbo.Win
(
	AwardID			tinyint,		--PK & FK -> cannot be null
	TeamID			tinyint,		--PK & FK -> cannot be null
	DateAwarded		smalldatetime	NOT NULL	Check(DateAwarded <= GETDATE()), --PK
	CONSTRAINT PK_WIn PRIMARY KEY (AwardID, TeamID, DateAwarded),
	CONSTRAINT FK_Win_AwardID FOREIGN KEY (AwardID) REFERENCES dbo.Award(AwardID),
	CONSTRAINT FK_Win_TeamID FOREIGN KEY (TeamID) REFERENCES dbo.Team(TeamID)
);
GO

/* Table: dbo.Feedback */
--S/N: 08 -> Feedback(FbkID, FbkDesc, FbkDateTime, FbkStatus, SatisfactionRank, <FbkCatID>, <ByMemberID>, <OnMemberID>, <StaffID>) --
CREATE TABLE dbo.Feedback
(
	FbkID			smallint,		--Primary Key
	FbkDesc			varchar(255)	NOT NULL,
	FbkDateTime		smalldatetime	NOT NULL	Check(FbkDateTime <= GETDATE()),
	FbkStatus		varchar(50)		NOT NULL,
	SatisfactionRank tinyint		NOT NULL	Check(SatisfactionRank BETWEEN 1 and 5),
	FbkCatID		tinyint			NOT NULL, --Foreign Key, not null
	ByMemberID		smallint 		NOT NULL,--Foreign Key, not null
	OnMemberID		smallint,		--Foreign Key, can be null
	StaffID			tinyint, --Foreign Key, can be null -> Feedback not yet assigned to a staff.
	CONSTRAINT PK_Feedback PRIMARY KEY (FbkID),
	CONSTRAINT FK_Feedback_FbkCatID FOREIGN KEY (FbkCatID) REFERENCES dbo.FeedbkCat(FbkCatID),
	CONSTRAINT FK_Feedback_ByMemberID FOREIGN KEY (ByMemberID) REFERENCES dbo.Member(MemberID),
	CONSTRAINT FK_Feedback_OnMemberID FOREIGN KEY (OnMemberID) REFERENCES dbo.Member(MemberID),
	CONSTRAINT FK_Feedback_StaffID FOREIGN KEY (StaffID) REFERENCES dbo.Staff(StaffID)
);
GO


/* Table: dbo.Buyer */
--S/N: 04 -> Buyer(<BuyerID>) --
CREATE TABLE dbo.Buyer
(
	BuyerID			smallint,		--PK & FK
	CONSTRAINT PK_Buyer PRIMARY KEY (BuyerID),
	CONSTRAINT FK_Buyer_BuyerID FOREIGN KEY (BuyerID) REFERENCES dbo.Member(MemberID)
);
GO

/* Table: dbo.Seller */
--S/N: 17 -> Seller(<SellerID>) --
CREATE TABLE dbo.Seller
(
	SellerID		smallint,		--PK & FK
	CONSTRAINT PK_Seller PRIMARY KEY (SellerID),
	CONSTRAINT FK_Seller_SellerID FOREIGN KEY (SellerID) REFERENCES dbo.Member(MemberID)
);
GO

/* Table: dbo.Listing */ 
--S/N: 12 -> Listing(ListingID, ListDesc, ListDateTime, ListPrice, ListStatus, <SellerID>, <SubCatID>) --
CREATE TABLE dbo.Listing
(
	ListingID		smallint,		--Primary Key
	ListDesc		varchar(255)	NOT NULL,
	ListDateTime	smalldatetime	NOT NULL	DEFAULT(GETDATE())
												Check(ListDateTime <= GETDATE()),
	ListPrice		smallmoney		NOT NULL	Check(ListPrice >= 0),
	ListStatus		varchar(10)		NOT NULL	Check(ListStatus in ('Available', 'Sold', 'Inactive')),
	SellerID		smallint		NOT NULL, --Foreign Key, not null
	SubCatID		tinyint			NOT NULL, --Foreign Key, not null
	CONSTRAINT PK_Listing PRIMARY KEY (ListingID),
	CONSTRAINT FK_Listing_SellerID FOREIGN KEY (SellerID) REFERENCES dbo.Seller(SellerID),
	CONSTRAINT FK_Listing_SubCatID FOREIGN KEY (SubCatID) REFERENCES dbo.SubCategory(SubCatID)
);
GO

/* Table: dbo.ListingPhoto */ 
--S/N: 13 -> ListingPhoto(<ListingID>, Photo) --
CREATE TABLE dbo.ListingPhoto
(
	ListingID		smallint,		--PK & FK
	Photo			varchar(10),	--PK
	CONSTRAINT PK_ListingPhoto PRIMARY KEY (ListingID, Photo),
	CONSTRAINT FK_ListingPhoto_ListingID FOREIGN KEY (ListingID) REFERENCES dbo.Listing(ListingID)
);
GO

/* Table: dbo.BumpOrder */ 
--S/N: 03 -> BumpOrder(BumpOrderID, PurchaseDate, <SellerID>, <BumpID>, <ListingID>) --
CREATE TABLE dbo.BumpOrder
(
	BumpOrderID		smallint,		--Primary Key
	PurchaseDate	smalldatetime	NOT NULL	DEFAULT(GETDATE())
												Check(PurchaseDate <= GETDATE()),
	SellerID		smallint		NOT NULL, --Foreign Key, not null
	BumpID			tinyint			NOT NULL, --Foreign Key, not null
	ListingID		smallint		NOT NULL, --Foreign Key, not null
	CONSTRAINT PK_BumpOrder PRIMARY KEY (BumpOrderID),
	CONSTRAINT FK_BumpOrder_SellerID FOREIGN KEY (SellerID) REFERENCES dbo.Seller(SellerID),
	CONSTRAINT FK_BumpOrder_BumpID FOREIGN KEY (BumpID) REFERENCES dbo.Bump(BumpID),
	CONSTRAINT FK_BumpOrder_ListingID FOREIGN KEY (ListingID) REFERENCES dbo.Listing(ListingID)
);
GO

/* Table: dbo.Likes */
--S/N: 11 -> Likes(<BuyerID>, <ListingID>, DateLiked) --
CREATE TABLE dbo.Likes
(
	BuyerID			smallint,		--PK & FK
	ListingID		smallint,		--PK & FK
	DateLiked		smalldatetime	NOT NULL	DEFAULT(GETDATE())
												Check(DateLiked <= GETDATE()),
	CONSTRAINT PK_Likes PRIMARY KEY (BuyerID, ListingID),
	CONSTRAINT FK_Likes_BuyerID FOREIGN KEY (BuyerID) REFERENCES dbo.Buyer(BuyerID),
	CONSTRAINT FK_Likes_ListingID FOREIGN KEY (ListingID) REFERENCES dbo.Listing(ListingID)
);
GO

/* Table: dbo.Chat */
--S/N: 06 -> Chat(ChatID, <BuyerID>, <ListingID>) --
CREATE TABLE dbo.Chat
(
	ChatID			smallint,		--Primary Key
	BuyerID			smallint		NOT NULL, --Foreign Key, not null
	ListingID		smallint		NOT NULL, --Foreign Key, not null
	CONSTRAINT PK_Chat PRIMARY KEY (ChatID),
	CONSTRAINT FK_Chat_BuyerID FOREIGN KEY (BuyerID) REFERENCES dbo.Buyer(BuyerID),
	CONSTRAINT FK_Chat_ListingID FOREIGN KEY (ListingID) REFERENCES dbo.Listing(ListingID)
);
GO

/* Table: dbo.ChatMsg */
--S/N: 07 -> ChatMsg(<ChatID>, MsgSN, MsgDateTime, Originator, Msg) --
CREATE TABLE dbo.ChatMsg
(
	ChatID			smallint,		--PK & FK
	MsgSN			tinyint			Check(MsgSN > 0), --PK
	MsgDateTime		smalldatetime	NOT NULL	Check(MsgDateTime <= GETDATE()),
	Originator		char(1)			NOT NULL	Check(Originator in ('S', 'B')),
	Msg				varchar(255)	NOT NULL,
	CONSTRAINT PK_ChatMsg PRIMARY KEY (ChatID, MsgSN),
	CONSTRAINT FK_ChatMsg_ChatID FOREIGN KEY (ChatID) REFERENCES dbo.Chat(ChatID)
);
GO

/* Table: dbo.Offer */
--S/N: 15 -> Offer(OffferID, <BuyerID>, <ListingID>, OfferPrice, OfferStatus, OfferDate) --
CREATE TABLE dbo.Offer
(
	OfferID			smallint,		--Primary Key
	BuyerID			smallint		NOT NULL, --Foreign Key, not null
	ListingID		smallint		NOT NULL, --Foreign Key, not null
	OfferPrice		smallmoney		NOT NULL	Check(OfferPrice >= 0), 
	OfferStatus		varchar(10)		NOT NULL	Check(OfferStatus in ('Submitted', 'Pending', 'Accepted', 'Rejected', 'Completed')),
	OfferDate		smalldatetime	NOT NULL	Check(OfferDate <= GETDATE()),
	CONSTRAINT PK_Offer PRIMARY KEY (OfferID),
	CONSTRAINT FK_Offer_BuyerID FOREIGN KEY (BuyerID) REFERENCES dbo.Buyer(BuyerID),
	CONSTRAINT FK_Offer_ListingID FOREIGN KEY (ListingID) REFERENCES dbo.Listing(ListingID)
);
GO

/* Table: dbo.Review */
--S/N: 16 -> Review(ReviewID, <OfferID>, MemberType, ReviewDate, ItemRank, DeliveryRank, CommunicationRank, Comment) --
CREATE TABLE dbo.Review
(
	ReviewID		smallint,		--Primary Key
	OfferID			smallint		NOT NULL, --Foreign Key, not null
	MemberType		char(1)			NOT NULL	Check(MemberType in ('S', 'B')),
	ReviewDate		smalldatetime	NOT NULL	Check(ReviewDate <= GETDATE()),
	ItemRank		tinyint			NOT NULL	Check(ItemRank BETWEEN 1 and 5),
	DeliveryRank	tinyint			NOT NULL	Check(DeliveryRank BETWEEN 1 and 5),
	CommunicationRank tinyint		NOT NULL	Check(CommunicationRank BETWEEN 1 and 5),
	Comment			varchar(255), -- can be null
	CONSTRAINT PK_Review PRIMARY KEY (ReviewID),
	CONSTRAINT FK_Review_OfferID FOREIGN KEY (OfferID) REFERENCES dbo.Offer(OfferID)
);
GO


/* Insert rows */

/* Table: dbo.Award */
--S/N: 01-> Award(AwardID, AwardName, AwardAmt)--
INSERT INTO Award VALUES
(1, 'Best Development Team', 1000.00),    -- Team 1: Development Team
(2, 'Outstanding Sales Performance', 1200.00), -- Team 2: Sales Team
(3, 'Excellence in Marketing', 950.00),   -- Team 3: Marketing Team
(4, 'Best Customer Support', 1100.00),   -- Team 4: Support Team
(5, 'Operational Efficiency Award', 1050.00), -- Team 5: Operations Team
(6, 'Innovation in Development', 850.00), -- Additional award for Team 1
(7, 'Top Sales Growth', 1300.00),        -- Additional award for Team 2
(8, 'Creative Campaign Award', 750.00),  -- Additional award for Team 3
(9, 'Outstanding Teamwork', 900.00),     -- Cross-team recognition
(10, 'Employee Choice Award', 700.00);   -- Cross-team recognition

/* Table: dbo.Team */ 
--S/N: 20 -> Team(TeamID, TeamName, <TeamLeaderID>) --
INSERT INTO Team(TeamID, TeamName, TeamLeaderID) VALUES 
(1, 'Development Team', NULL),
(2, 'Sales Team', NULL),
(3, 'Marketing Team', NULL),
(4, 'Support Team', NULL),
(5, 'Operations Team', NULL);

/* Table: dbo.Staff */
--S/N: 18 -> Staff(StaffID, StaffName, StaffMobile, StaffDateJoined, <TeamID>) --
INSERT INTO Staff (StaffID, StaffName, StaffMobile, StaffDateJoined, TeamID) VALUES 
(1, 'John Tan', '91234567', '2022-01-15', 1),    --Team Leader ID
(2, 'Emma Lee', '92345678', '2023-03-12', 1),
(3, 'Lucas Ng', '93456789', '2022-06-08', 1),
(4, 'Sophia Chua', '94567890', '2021-11-25', 1),
(5, 'Benjamin Teo', '95678901', '2022-08-19', 1),

(6, 'Grace Lim', '96789012', '2023-05-04', 2),   --Team Leader ID
(7, 'Ethan Wong', '97890123', '2022-12-01', 2),
(8, 'Olivia Koh', '98901234', '2021-10-10', 2),
(9, 'Chloe Chan', '90012345', '2022-09-18', 2),
(10, 'Daniel Ho', '90123456', '2023-07-20', 2),

(11, 'Hannah Goh', '91234567', '2023-02-15', 3), --Team Leader ID
(12, 'Ryan Lee', '92345678', '2021-12-08', 3),
(13, 'Ella Ng', '93456789', '2022-03-10', 3),
(14, 'Mia Tan', '94567890', '2023-04-30', 3),
(15, 'Noah Teo', '95678901', '2022-06-22', 3),

(16, 'Amelia Lim', '96789012', '2021-11-17', 4), --Team Leader ID
(17, 'Liam Ng', '97890123', '2022-02-05', 4),
(18, 'Charlotte Wong', '98901234', '2023-03-19', 4),
(19, 'Harper Koh', '90012345', '2022-08-11', 4),
(20, 'Zoe Chan', '90123456', '2023-09-12', 4),

(21, 'Isaac Ho', '91234567', '2022-04-14', 5),   --Team Leader ID
(22, 'Scarlett Goh', '92345678', '2021-07-28', 5),
(23, 'Elijah Lee', '93456789', '2022-10-01', 5),
(24, 'Mason Ng', '94567890', '2023-05-25', 5),
(25, 'Lily Tan', '95678901', '2023-08-03', 5);

/* Selecting Team Leaders */
UPDATE Team
	SET TeamLeaderID = 1
	where TeamID = 1;

UPDATE Team
	SET TeamLeaderID = 6
	where TeamID = 2;

UPDATE Team
	SET TeamLeaderID = 11
	where TeamID = 3;

UPDATE Team
	SET TeamLeaderID = 16
	where TeamID = 4;

UPDATE Team
	SET TeamLeaderID = 21
	where TeamID = 5;


/* Table: dbo.Win */
--S/N: 21 -> Win(<AwardID>, <TeamID>, DateAwarded) --
INSERT INTO Win(AwardID, TeamID, DateAwarded) VALUES
(1, 1, '2024-01-10 12:00:00'), 
(2, 2, '2024-01-10 14:30:00'), 
(3, 3, '2024-01-10 10:00:00'), 
(4, 4, '2024-01-10 11:45:00'), 
(5, 5, '2024-01-10 09:30:00'), 
(6, 1, '2024-01-10 13:20:00'), 
(7, 2, '2024-01-10 15:10:00'), 
(8, 3, '2024-01-10 16:40:00'),
(9, 3, '2024-01-10 17:00:00'),
(10, 3,'2024-01-10 17:40:00');

/* Table: dbo.FeedbkCat */
--S/N: 09 -> FeedbkCat(FbkCatID, FbkCatDesc) --
INSERT INTO FeedbkCat(FbkCatID, FbkCatDesc) VALUES
(1, 'Positive Seller Experience'),
(2, 'Negative Seller Experience'),
(3, 'Listing Accuracy'),
(4, 'Delivery Issues'),
(5, 'Customer Support Quality'),
(6, 'Platform Usability'),
(7, 'Payment Process Feedback'),
(8, 'Promotions and Discounts'),
(9, 'Refund or Exchange Issues'),
(10, 'Account Security'),
(11, 'Buyer-Seller Communication'),
(12, 'Order Fulfillment'),
(13, 'Shipping Speed'),
(14, 'Product Quality Concerns'),
(15, 'Suggestions for Improvement');

/* Table: dbo.Member */
--S/N: 14 -> Member(MemberID, MemberName, MemberDOB, MemberEmail, MemberMobile, MemberDateJoined, City) --
INSERT INTO Member(MemberID, MemberName, MemberDOB, MemberEmail, MemberMobile, MemberDateJoined, City) VALUES
(1, 'Alice Tan', '1990-05-14', 'alice.tan@example.com', '91234567', '2024-12-15', 'Singapore'),
(2, 'John Lim', '1985-03-22', 'john.lim@example.com', '92345678', '2024-12-14', 'Singapore'),
(3, 'Sophia Lee', '1992-12-05', 'sophia.lee@example.com', '93456789', '2024-12-13', 'Kuala Lumpur'),
(4, 'Benjamin Ng', '1995-07-19', 'benjamin.ng@example.com', '94567890', '2024-12-12', 'Johor Bahru'),
(5, 'Grace Tan', '1988-01-30', 'grace.tan@example.com', '95678901', '2024-12-11', 'Bangkok'),
(6, 'Ethan Wong', '1994-08-17', 'ethan.wong@example.com', '96789012', '2024-12-10', 'Hong Kong'),
(7, 'Emma Teo', '1993-11-21', 'emma.teo@example.com', '97890123', '2024-12-09', 'Singapore'),
(8, 'Lucas Chua', '1987-09-09', 'lucas.chua@example.com', '98901234', '2024-12-08', 'Jakarta'),
(9, 'Olivia Koh', '1996-06-12', 'olivia.koh@example.com', '90123456', '2024-12-07', 'Bangkok'),
(10, 'Daniel Goh', '1991-04-28', 'daniel.goh@example.com', '91234568', '2024-12-06', 'Kuala Lumpur'),
(11, 'Chloe Chan', '1989-02-15', 'chloe.chan@example.com', '92345679', '2024-12-05', 'Singapore'),
(12, 'Liam Tan', '1997-03-03', 'liam.tan@example.com', '93456780', '2024-12-04', 'Jakarta'),
(13, 'Ella Ng', '1998-10-10', 'ella.ng@example.com', '94567891', '2024-12-03', 'Hong Kong'),
(14, 'Ryan Ho', '1986-01-24', 'ryan.ho@example.com', '95678902', '2024-12-02', 'Singapore'),
(15, 'Mia Lee', '1990-11-18', 'mia.lee@example.com', '96789013', '2024-12-01', 'Johor Bahru'),
(16, 'Noah Lim', '1993-07-02', 'noah.lim@example.com', '97890124', '2024-11-30', 'Bangkok'),
(17, 'Ava Koh', '1988-05-06', 'ava.koh@example.com', '98901235', '2024-11-29', 'Kuala Lumpur'),
(18, 'James Tan', '1994-12-25', 'james.tan@example.com', '90123457', '2024-11-28', 'Singapore'),
(19, 'Isabella Teo', '1996-08-08', 'isabella.teo@example.com', '91234569', '2024-11-27', 'Hong Kong'),
(20, 'Alexander Wong', '1991-03-12', 'alexander.wong@example.com', '92345670', '2024-11-26', 'Jakarta'),
(21, 'Emily Goh', '1985-04-17', 'emily.goh@example.com', '93456781', '2024-11-25', 'Singapore'),
(22, 'Matthew Chua', '1995-09-01', 'matthew.chua@example.com', '94567892', '2024-11-24', 'Johor Bahru'),
(23, 'Harper Lee', '1993-02-28', 'harper.lee@example.com', '95678903', '2024-11-23', 'Kuala Lumpur'),
(24, 'Nathan Ng', '1998-01-11', 'nathan.ng@example.com', '96789014', '2024-11-22', 'Bangkok'),
(25, 'Amelia Ho', '1992-06-30', 'amelia.ho@example.com', '97890125', '2024-11-21', 'Hong Kong'),
(26, 'Zoe Lim', '1990-09-14', 'zoe.lim@example.com', '98901236', '2024-11-20', 'Singapore'),
(27, 'Elijah Tan', '1994-07-23', 'elijah.tan@example.com', '90123458', '2024-11-19', 'Jakarta'),
(28, 'Charlotte Koh', '1987-12-07', 'charlotte.koh@example.com', '91234570', '2024-11-18', 'Bangkok'),
(29, 'David Teo', '1991-10-19', 'david.teo@example.com', '92345671', '2024-11-17', 'Johor Bahru'),
(30, 'Hannah Chua', '1989-11-27', 'hannah.chua@example.com', '93456782', '2024-11-16', 'Kuala Lumpur');

/* Table: dbo.Follower */
--S/N: 10 -> Follower(<MemberID>, <FollowerID>, DateStarted) --
INSERT INTO Follower(MemberID, FollowerID, DateStarted) VALUES
(1, 2, '2024-01-15 10:00:00'),  -- John Lim follows Alice Tan
(3, 1, '2024-01-16 12:30:00'),  -- Alice Tan follows Sophia Lee
(4, 5, '2024-01-17 09:45:00'),  -- Grace Tan follows Benjamin Ng
(6, 7, '2024-01-18 15:20:00'),  -- Emma Teo follows Ethan Wong
(8, 9, '2024-01-19 17:10:00'),  -- Olivia Koh follows Lucas Chua
(10, 11, '2024-01-20 11:15:00'), -- Chloe Chan follows Daniel Goh
(12, 14, '2024-01-21 16:50:00'), -- Ryan Ho follows Liam Tan
(15, 16, '2024-01-22 14:10:00'), -- Noah Lim follows Mia Lee
(17, 18, '2024-01-23 13:25:00'), -- James Tan follows Ava Koh
(19, 20, '2024-01-24 12:40:00'), -- Alexander Wong follows Isabella Teo
(21, 22, '2024-01-25 09:30:00'), -- Matthew Chua follows Emily Goh
(23, 24, '2024-01-26 08:50:00'); -- Nathan Ng follows Harper Lee

/* Table: dbo.Feedback */
--S/N: 08 -> Feedback(FbkID, FbkDesc, FbkDateTime, FbkStatus, SatisfactionRank, <FbkCatID>, <ByMemberID>, <OnMemberID>, <StaffID>) --
INSERT INTO Feedback(FbkID, FbkDesc, FbkDateTime, FbkStatus, SatisfactionRank,FbkCatID, ByMemberID, OnMemberID, StaffID) VALUES
(1, 'Great experience with the seller!', '2024-01-20 14:30:00', 'Resolved', 5, 1, 1, 2, 1), 
(2, 'Delivery was delayed by a week.', '2024-01-18 10:15:00', 'Pending', 2, 3, 4, NULL, 6), 
(3, 'Refund took too long to process.', '2024-01-17 16:45:00', 'Investigating', 3, 5, 9, NULL, 11), 
(4, 'Product quality was below expectations.', '2024-01-16 12:00:00', 'Pending', 1, 7, 14, 8, NULL), 
(5, 'Encountered a technical glitch on the platform.', '2024-01-15 08:30:00', 'Resolved', 4, 10, 15, NULL, 21),
(6, 'Seller took too long to respond.', '2024-01-21 09:30:00', 'Pending', 2, 2, 6, 7, NULL),  
(7, 'Item description did not match the actual product.', '2024-01-22 11:15:00', 'Resolved', 3, 3, 8, 3, 1),  
(8, 'Product arrived with missing parts.', '2024-01-23 13:00:00', 'Investigating', 1, 14, 9, 5, 6),  
(9, 'Smooth transaction and excellent communication.', '2024-01-24 15:45:00', 'Resolved', 5, 1, 10, 12, NULL),  
(10, 'Customer support was unhelpful.', '2024-01-25 17:20:00', 'Investigating', 2, 5, 11, NULL, 11),  
(11, 'Delivery was quicker than expected.', '2024-01-26 10:05:00', 'Resolved', 5, 13, 12, 6, 21),  
(12, 'Website usability could be improved.', '2024-01-27 12:40:00', 'Pending', 3, 6, 13, NULL, NULL),  
(13, 'Fair pricing, would purchase again.', '2024-01-28 14:10:00', 'Resolved', 4, 15, 14, 9, 16),  
(14, 'Product quality was below expectations.', '2024-01-29 16:30:00', 'Investigating', 1, 14, 15, 11, 5),  
(15, 'Payment process was confusing.', '2024-01-30 18:50:00', 'Pending', 2, 7, 7, 10, NULL);

/* Table: dbo.Buyer */
--S/N: 04 -> Buyer(<BuyerID>) --
INSERT INTO Buyer(BuyerID) VALUES
(1),  -- Alice Tan
(2),  -- John Lim
(3),  -- Sophia Lee
(4),  -- Benjamin Ng
(5),  -- Grace Tan
(6),  -- Ethan Wong
(7),  -- Emma Teo
(8),  -- Lucas Chua
(9),  -- Olivia Koh
(10), -- Daniel Goh
(11), -- Chloe Chan
(12), -- Liam Tan
(13), -- Ella Ng
(14), -- Ryan Ho
(15); -- Mia Lee

/* Table: dbo.Seller */
--S/N: 17 -> Seller(<SellerID>) --
INSERT INTO Seller(SellerID) VALUES
(16), -- Noah Lim 
(17), -- Ava Koh 
(18), -- James Tan
(19), -- Isabella Teo 
(20), -- Alexander Wong 
(21), -- Emily Goh
(22), -- Matthew Chua 
(23), -- Harper Lee 
(24), -- Nathan Ng 
(25), -- Amelia Ho 
(26), -- Zoe Lim 
(27), -- Elijah Tan 
(28), -- Charlotte Koh
(29), -- David Teo 
(30); -- Hannah Chua

/* Table: dbo.Bump */
--S/N: 02 -> Bump(BumpID, BumpDesc, BumpPrice) --
INSERT INTO dbo.Bump (BumpID, BumpDesc, BumpPrice) VALUES
(1, 'Instant Bump (Single Push)', 5.00),       -- One-time promotion
(2, '1-Day Bump', 10.00),                     -- 24-hour visibility boost
(3, '3-Day Daily Bump', 25.00),               -- Bump once daily for 3 days
(4, '7-Day Daily Bump', 50.00),               -- Bump once daily for 7 days
(5, 'Weekend Bump (Fri-Sun)', 15.00),         -- Promotes listing over the weekend
(6, 'Prime Time Bump (6 PM - 9 PM)', 20.00),  -- Highlight during peak hours
(7, 'Highlight Bump (Top of Category)', 30.00),-- Features listing at category top
(8, 'Urgent Sale Bump', 40.00),               -- For listings marked "Urgent Sale"
(9, 'Featured Listing Bump', 45.00),          -- Showcase in the "Featured" section
(10, 'Extended Visibility Bump (30 Days)', 60.00); -- Extends listing visibility by 30 days

/* Table: dbo.Category */
--S/N: 05 -> Category(CatID, CatDesc) --
INSERT INTO Category(CatID, CatDesc) VALUES
(1, 'Furniture'), 
(2, 'Vehicles'),
(3, 'Books and Stationery'), 
(4, 'Toys'), 
(5, 'Beauty Products'),
(6, 'Sports Equipment'), 
(7, 'Groceries'),
(8, 'Real Estate'), 
(9, 'Art and Crafts'); 


/* Table: dbo.SubCategory */
--S/N: 19 -> SubCategory(SubCatID, SubCatDesc, <CatID>) --
INSERT INTO SubCategory(SubCatID, SubCatDesc, CatID) VALUES
(1, 'Bedding', 1),
(2, 'Cookware', 1),
(3, 'Fiction', 3),
(4, 'Non-Fiction', 3),
(5, 'Comics', 3),
(6, 'Action Figures', 4),
(7, 'Puzzles', 4),
(8, 'Board Games', 4),
(9, 'Running Gear', 6),
(10, 'Camping Equipment', 6),
(11, 'Car Accessories', 2),
(12, 'Motorcycle Gear', 2),
(13, 'Houses', 8),
(14, 'Apartments', 8),
(15, 'Freelance Services', 9),
(16, 'Consulting Services', 9),
(17, 'Snacks', 7),
(18, 'Beverages', 7),
(19, 'Skincare', 5),
(20, 'Makeup', 5);

/* Table: dbo.Listing */ 
--S/N: 12 -> Listing(ListingID, ListDesc, ListDateTime, ListPrice, ListStatus, <SellerID>, <SubCatID>) --
INSERT INTO Listing(ListingID, ListDesc, ListDateTime, ListPrice, ListStatus, SellerID, SubCatID) VALUES
(1, 'Brand new queen-sized bedding set', '2024-01-15 10:00:00', 120.00, 'Available', 16, 1), -- SellerID 1, Bedding
(2, 'Non-stick cookware set', '2024-01-16 15:30:00', 75.50, 'Inactive', 17, 2), -- SellerID 2, Cookware
(3, 'Fantasy fiction novel collection', '2024-01-17 09:45:00', 40.00, 'Sold', 18, 3), -- SellerID 3, Fiction
(4, 'Self-help non-fiction books', '2024-01-18 13:20:00', 25.00, 'Available', 19, 4), -- SellerID 4, Non-Fiction
(5, 'Marvel comics set', '2024-01-19 14:00:00', 30.00, 'Available', 20, 5), -- SellerID 5, Comics
(6, 'Rare action figures collection', '2024-01-20 11:15:00', 150.00, 'Sold', 21, 6), -- SellerID 6, Action Figures
(7, '1000-piece puzzles', '2024-01-21 16:50:00', 20.00, 'Available', 22, 7), -- SellerID 7, Puzzles
(8, 'Premium running gear set', '2024-01-22 10:25:00', 85.00, 'Available', 23, 9), -- SellerID 8, Running Gear
(9, 'All-season car accessories kit', '2024-01-23 12:40:00', 200.00, 'Sold', 24, 11), -- SellerID 9, Car Accessories
(10, 'Apartment for rent in downtown', '2024-01-24 17:10:00', 1200.00, 'Available', 25, 14), -- SellerID 10, Apartments
(11, 'Portable camping equipment', '2024-01-25 09:30:00', 150.00, 'Inactive', 26, 10), -- SellerID 11, Camping Equipment
(12, 'Organic skincare products', '2024-01-26 08:50:00', 50.00, 'Available', 27, 19), -- SellerID 12, Skincare
(13, 'Makeup gift set', '2024-01-27 15:10:00', 60.00, 'Sold', 28, 20), -- SellerID 13, Makeup
(14, 'Board game collection', '2024-01-28 14:20:00', 45.00, 'Available', 29, 8), -- SellerID 14, Board Games
(15, 'Healthy snacks bundle', '2024-01-29 13:45:00', 25.00, 'Inactive', 30, 17), -- SellerID 15, Snacks
(16, 'Leather office chair', '2024-01-30 10:30:00', 180.00, 'Available', 16, 1), -- SellerID 16, Bedding
(17, 'Stainless steel knife set', '2024-01-31 15:00:00', 90.00, 'Available', 17, 2), -- SellerID 17, Cookware
(18, 'Sci-fi book bundle', '2024-02-01 14:10:00', 55.00, 'Sold', 18, 3), -- SellerID 18, Fiction
(19, 'Biography of world leaders', '2024-02-02 16:25:00', 35.00, 'Available', 19, 4), -- SellerID 19, Non-Fiction
(20, 'Vintage comic book collection', '2024-02-03 13:45:00', 200.00, 'Available', 20, 5), -- SellerID 20, Comics
(21, 'Limited edition superhero figurines', '2024-02-04 11:00:00', 500.00, 'Sold', 21, 6), -- SellerID 21, Action Figures
(22, '500-piece jigsaw puzzle set', '2024-02-05 17:30:00', 30.00, 'Available', 22, 7), -- SellerID 22, Puzzles
(23, 'Chess and checkers board set', '2024-02-06 12:10:00', 40.00, 'Inactive', 23, 8), -- SellerID 23, Board Games
(24, 'Professional running shoes', '2024-02-07 10:50:00', 120.00, 'Sold', 24, 9), -- SellerID 24, Running Gear
(25, 'Waterproof camping tent', '2024-02-08 14:35:00', 250.00, 'Available', 25, 10), -- SellerID 25, Camping Equipment
(26, 'High-performance car tires set', '2024-02-09 16:00:00', 600.00, 'Available', 26, 11), -- SellerID 26, Car Accessories
(27, 'Vintage motorcycle helmet', '2024-02-10 11:40:00', 90.00, 'Inactive', 27, 12), -- SellerID 27, Motorcycle Gear
(28, 'Luxury apartment for sale', '2024-02-11 09:20:00', 210000.00, 'Available', 28, 14), -- SellerID 28, Apartments
(29, 'Freelance graphic design services', '2024-02-12 15:30:00', 50.00, 'Available', 29, 15), -- SellerID 29, Freelance Services
(30, 'Organic fruit juice selection', '2024-02-13 13:00:00', 25.00, 'Inactive', 30, 18); -- SellerID 30, Beverages

/* Table: dbo.ListingPhoto */ 
--S/N: 13 -> ListingPhoto(<ListingID>, Photo) --
INSERT INTO ListingPhoto(ListingID, Photo) VALUES
(1, 'Photo1'), (1, 'Photo2'), (1, 'Photo3'),
(2, 'Photo1'), (2, 'Photo2'),
(3, 'Photo1'), (3, 'Photo2'), (3, 'Photo3'),
(4, 'Photo1'),
(5, 'Photo1'), (5, 'Photo2'),
(6, 'Photo1'),
(7, 'Photo1'), (7, 'Photo2'), (7, 'Photo3'),
(8, 'Photo1'),
(9, 'Photo1'), (9, 'Photo2'),
(10, 'Photo1'), (10, 'Photo2'), (10, 'Photo3'),
(11, 'Photo1'),
(12, 'Photo1'),
(13, 'Photo1'),
(14, 'Photo1'),
(15, 'Photo1'), (15, 'Photo2'),
(16, 'Photo1'),
(17, 'Photo1'),
(18, 'Photo1'),
(19, 'Photo1'), (19, 'Photo2'), (19, 'Photo3'),
(20, 'Photo1'),
(21, 'Photo1'),
(22, 'Photo1'), (22, 'Photo2'),
(23, 'Photo1'),
(24, 'Photo1'), (24, 'Photo2'), (24, 'Photo3'),
(25, 'Photo1'), (25, 'Photo2'),
(26, 'Photo1'), (26, 'Photo2'), (26, 'Photo3'),
(27, 'Photo1'),
(28, 'Photo1'),
(29, 'Photo1'),
(30, 'Photo1'), (30, 'Photo2');


/* Table: dbo.BumpOrder */ 
--S/N: 03 -> BumpOrder(BumpOrderID, PurchaseDate, <SellerID>, <BumpID>, <ListingID>) --
INSERT INTO BumpOrder(BumpOrderID, PurchaseDate, SellerID, BumpID, ListingID) VALUES
(1, '2024-02-01 10:00:00', 16, 1, 1),  -- Noah Lim promotes bedding set  
(2, '2024-02-02 15:30:00', 17, 5, 2),  -- Ava Koh boosts cookware listing for 7 days  
(3, '2024-02-03 12:45:00', 18, 3, 3),  -- James Tan increases visibility for novel collection  
(4, '2024-02-04 14:20:00', 19, 8, 4),  -- Isabella Teo expands audience for self-help books  
(5, '2024-02-05 16:50:00', 20, 2, 5),  -- Alexander Wong highlights Marvel comics set  
(6, '2024-02-06 09:30:00', 21, 10, 6), -- Emily Goh purchases top-tier promotion for action figures  
(7, '2024-02-07 11:15:00', 22, 4, 7),  -- Matthew Chua features puzzles on homepage  
(8, '2024-02-08 08:50:00', 23, 6, 8),  -- Harper Lee highlights running gear with a premium tag  
(9, '2024-02-09 17:10:00', 24, 9, 9), -- Nathan Ng promotes car accessories on social media  
(10, '2024-02-10 13:45:00', 25, 4, 10); -- Amelia Ho spotlights apartment rental in category  

/* Table: dbo.Likes */
--S/N: 11 -> Likes(<BuyerID>, <ListingID>, DateLiked) --
INSERT INTO Likes(BuyerID, ListingID, DateLiked) VALUES
(1, 5, '2024-02-01 10:00:00'),  -- Alice Tan likes the Marvel comics set
(2, 3, '2024-02-02 11:30:00'),  -- John Lim likes the fantasy fiction novel collection
(3, 7, '2024-02-03 14:15:00'),  -- Sophia Lee likes the 1000-piece puzzles
(4, 2, '2024-02-04 09:45:00'),  -- Benjamin Ng likes the non-stick cookware set
(5, 10, '2024-02-05 12:10:00'), -- Grace Tan likes the apartment for rent
(6, 8, '2024-02-06 15:20:00'),  -- Ethan Wong likes the premium running gear set
(7, 14, '2024-02-07 17:50:00'), -- Emma Teo likes the board game collection
(8, 1, '2024-02-08 08:30:00'),  -- Lucas Chua likes the queen-sized bedding set
(9, 12, '2024-02-09 13:40:00'), -- Olivia Koh likes the organic skincare products
(10, 6, '2024-02-10 16:00:00'), -- Daniel Goh likes the rare action figures collection
(11, 4, '2024-02-11 10:15:00'), -- Chloe Chan likes the self-help non-fiction books
(12, 15, '2024-02-12 14:25:00'); -- Liam Tan likes the healthy snacks bundle

/* Table: dbo.Offer */
--S/N: 15 -> Offer(OffferID, <BuyerID>, <ListingID>, OfferPrice, OfferStatus, OfferDate) --
INSERT INTO Offer(OfferID, BuyerID, ListingID, OfferPrice, OfferStatus, OfferDate) VALUES
(1, 1, 5, 25.00, 'Submitted', '2024-02-01 10:00:00'),  
(2, 2, 3, 35.00, 'Pending', '2024-02-02 11:30:00'),  
(3, 3, 7, 18.00, 'Accepted', '2024-02-03 14:15:00'),  
(4, 4, 2, 70.00, 'Rejected', '2024-02-04 09:45:00'),  
(5, 5, 10, 1100.00, 'Pending', '2024-02-05 12:10:00'),  
(6, 6, 8, 80.00, 'Submitted', '2024-02-06 15:20:00'),  
(7, 7, 14, 40.00, 'Accepted', '2024-02-07 17:50:00'),  
(8, 8, 1, 115.00, 'Rejected', '2024-02-08 08:30:00'),  
(9, 9, 12, 45.00, 'Completed', '2024-02-09 13:40:00'),  
(10, 10, 6, 145.00, 'Pending', '2024-02-10 16:00:00'),  
(11, 11, 4, 22.00, 'Submitted', '2024-02-11 10:15:00'),  
(12, 12, 15, 22.00, 'Accepted', '2024-02-12 14:25:00'),  
(13, 1, 9, 180.00, 'Rejected', '2024-02-13 15:10:00'),  
(14, 2, 13, 55.00, 'Submitted', '2024-02-14 09:45:00'),  
(15, 3, 5, 28.00, 'Accepted', '2024-02-15 14:00:00'),  
(16, 4, 7, 15.00, 'Rejected', '2024-02-16 17:15:00'),  
(17, 5, 14, 42.00, 'Pending', '2024-02-17 11:30:00'),  
(18, 6, 2, 72.50, 'Accepted', '2024-02-18 10:05:00'),  
(19, 7, 11, 140.00, 'Rejected', '2024-02-19 08:20:00'),  
(20, 8, 10, 1150.00, 'Completed', '2024-02-20 13:40:00');

INSERT INTO Offer(OfferID, BuyerID, ListingID, OfferPrice, OfferStatus, OfferDate) VALUES
(21, 9, 3, 38.00, 'Submitted', '2024-02-21 12:25:00'),  
(22, 10, 12, 49.00, 'Pending', '2024-02-22 09:50:00'),  
(23, 11, 8, 82.00, 'Rejected', '2024-02-23 15:35:00'),  
(24, 12, 1, 118.00, 'Accepted', '2024-02-24 14:10:00'),  
(25, 13, 5, 26.00, 'Pending', '2024-02-25 16:20:00'),  
(26, 14, 6, 142.00, 'Rejected', '2024-02-26 11:10:00'),  
(27, 15, 9, 195.00, 'Completed', '2024-02-27 17:30:00'),  
(28, 1, 4, 23.00, 'Submitted', '2024-02-28 10:45:00'),  
(29, 2, 15, 24.00, 'Pending', '2024-02-29 12:00:00'),  
(30, 3, 13, 58.00, 'Accepted', '2024-03-01 13:15:00'),  
(31, 4, 11, 135.00, 'Rejected', '2024-03-02 08:30:00'),  
(32, 5, 8, 81.00, 'Submitted', '2024-03-03 16:45:00'),  
(33, 6, 2, 74.00, 'Completed', '2024-03-04 14:50:00'),  
(34, 7, 9, 185.00, 'Rejected', '2024-03-05 09:25:00'),  
(35, 8, 10, 1190.00, 'Accepted', '2024-03-06 11:40:00'),  
(36, 9, 7, 19.00, 'Submitted', '2024-03-07 14:55:00'),  
(37, 10, 5, 29.00, 'Pending', '2024-03-08 12:20:00'),  
(38, 11, 3, 37.00, 'Accepted', '2024-03-09 09:15:00'),  
(39, 12, 12, 52.00, 'Completed', '2024-03-10 08:40:00'),  
(40, 13, 14, 43.00, 'Rejected', '2024-03-11 10:00:00');

/* Table: dbo.Review */
--S/N: 16 -> Review(ReviewID, <OfferID>, MemberType, ReviewDate, ItemRank, DeliveryRank, CommunicationRank, Comment) --
INSERT INTO Review(ReviewID, OfferID, MemberType, ReviewDate, ItemRank, DeliveryRank, CommunicationRank, Comment) VALUES
(1, 9, 'B', '2024-03-12 10:00:00', 5, 5, 5, 'Great product, fast delivery, and excellent communication.'),
(2, 12, 'B', '2024-03-12 11:30:00', 4, 4, 4, 'Satisfied with the product, but delivery took a while.'),
(3, 20, 'S', '2024-03-12 14:15:00', 5, 5, 5, 'Buyer was quick to respond and complete the purchase.'),
(4, 27, 'B', '2024-03-12 09:45:00', 3, 3, 2, 'Item quality was not as expected.'),
(5, 33, 'S', '2024-03-12 12:10:00', 5, 4, 5, 'Buyer was easy to communicate with.'),
(6, 35, 'B', '2024-03-12 15:20:00', 4, 5, 5, 'Item was well-packaged and arrived quickly.'),
(7, 9, 'S', '2024-03-13 17:50:00', 5, 5, 5, 'Smooth transaction, would sell to this buyer again.'),
(8, 12, 'S', '2024-03-13 08:30:00', 4, 4, 4, 'Buyer was polite but took time to complete the purchase.'),
(9, 20, 'B', '2024-03-13 13:40:00', 5, 5, 5, 'Amazing experience with the seller!'),
(10, 27, 'S', '2024-03-13 16:00:00', 2, 3, 3, 'Buyer was hard to communicate with.'),
(11, 33, 'B', '2024-03-14 10:15:00', 5, 5, 5, 'Highly recommend this seller!'),
(12, 35, 'S', '2024-03-14 14:25:00', 4, 4, 4, 'Transaction went smoothly.'),
(13, 9, 'B', '2024-03-14 15:10:00', 5, 5, 5, 'Great quality product!'),
(14, 12, 'B', '2024-03-14 09:45:00', 4, 4, 3, 'Item was okay, but communication could be better.'),
(15, 20, 'S', '2024-03-15 14:00:00', 5, 5, 5, 'Buyer was easy to work with.'),
(16, 27, 'B', '2024-03-15 17:15:00', 3, 2, 2, 'Item arrived late and was not as described.'),
(17, 33, 'S', '2024-03-15 11:30:00', 5, 5, 5, 'Fantastic buyer, no issues.'),
(18, 35, 'B', '2024-03-16 10:05:00', 5, 4, 4, 'Quick and easy transaction.'),
(19, 9, 'S', '2024-03-16 08:20:00', 5, 5, 5, 'Great buyer, hope to do business again!'),
(20, 12, 'S', '2024-03-16 13:40:00', 4, 4, 4, 'Smooth transaction but slightly delayed payment.');

/* Table: dbo.Chat */
--S/N: 06 -> Chat(ChatID, <BuyerID>, <ListingID>) --
INSERT INTO Chat(ChatID, BuyerID, ListingID) VALUES
(1, 1, 5),   -- Alice Tan inquiring about Marvel comics set
(2, 2, 3),   -- John Lim inquiring about fantasy fiction novel collection
(3, 3, 7),   -- Sophia Lee inquiring about 1000-piece puzzles
(4, 4, 2),   -- Benjamin Ng inquiring about non-stick cookware set
(5, 5, 10),  -- Grace Tan inquiring about apartment for rent
(6, 6, 8),   -- Ethan Wong inquiring about premium running gear set
(7, 7, 14),  -- Emma Teo inquiring about board game collection
(8, 8, 1),   -- Lucas Chua inquiring about queen-sized bedding set
(9, 9, 12),  -- Olivia Koh inquiring about organic skincare products
(10, 10, 6), -- Daniel Goh inquiring about rare action figures collection
(11, 11, 4), -- Chloe Chan inquiring about self-help non-fiction books
(12, 12, 9), -- Liam Tan inquiring about all-season car accessories kit
(13, 13, 15), -- Ella Ng inquiring about healthy snacks bundle
(14, 14, 11), -- Ryan Ho inquiring about portable camping equipment
(15, 15, 13), -- Mia Lee inquiring about makeup gift set
(16, 1, 14),  -- Alice Tan inquiring about board game collection
(17, 2, 8),   -- John Lim inquiring about premium running gear set
(18, 3, 12),  -- Sophia Lee inquiring about organic skincare products
(19, 4, 5),   -- Benjamin Ng inquiring about Marvel comics set
(20, 5, 2),   -- Grace Tan inquiring about non-stick cookware set
(21, 6, 7),   -- Ethan Wong inquiring about 1000-piece puzzles
(22, 7, 10),  -- Emma Teo inquiring about apartment for rent
(23, 8, 3),   -- Lucas Chua inquiring about fantasy fiction novel collection
(24, 9, 1),   -- Olivia Koh inquiring about queen-sized bedding set
(25, 10, 15); -- Daniel Goh inquiring about healthy snacks bundle

/* Table: dbo.ChatMsg */
--S/N: 07 -> ChatMsg(<ChatID>, MsgSN, MsgDateTime, Originator, Msg) --
INSERT INTO ChatMsg(ChatID, MsgSN, MsgDateTime, Originator, Msg) VALUES
(1, 1, '2024-01-30 10:00:00', 'B', 'Hi, is the Marvel comics set still available?'),
(1, 2, '2024-01-30 10:05:00', 'S', 'Yes, it is still available. Are you interested?'),
(2, 1, '2024-01-30 11:00:00', 'B', 'Hello, is the fantasy fiction novel collection in good condition?'),
(2, 2, '2024-01-30 11:10:00', 'S', 'Yes, all books are in excellent condition.'),
(3, 1, '2024-01-30 12:00:00', 'B', 'Hey, I am interested in the 1000-piece puzzles.'),
(3, 2, '2024-01-30 12:15:00', 'S', 'Sure! It is still available. Do you want to buy it?'),
(4, 1, '2024-01-30 13:00:00', 'B', 'Hi, is the non-stick cookware set still available?'),
(4, 2, '2024-01-30 13:10:00', 'S', 'Yes, it is. Would you like to make an offer?'),
(5, 1, '2024-01-30 14:00:00', 'B', 'Hello, can I schedule a viewing for the apartment?'),
(5, 2, '2024-01-30 14:20:00', 'S', 'Sure! When would you like to come by?'),
(6, 1, '2024-01-30 15:00:00', 'B', 'Is the premium running gear set new or used?'),
(6, 2, '2024-01-30 15:05:00', 'S', 'It is brand new and unused. Let me know if you are interested.');


/* SELECT * FROM statements */
/* List the content of the Tables from S/N 01 to S/N 21*/
SELECT * FROM Award;
SELECT * FROM Bump;
SELECT * FROM BumpOrder;
SELECT * FROM Buyer;
SELECT * FROM Category;
SELECT * FROM Chat;
SELECT * FROM ChatMsg;
SELECT * FROM Feedback;
SELECT * FROM FeedbkCat;
SELECT * FROM Follower;
SELECT * FROM Likes;
SELECT * FROM Listing;
SELECT * FROM ListingPhoto;
SELECT * FROM Member;
SELECT * FROM Offer;
SELECT * FROM Review;
SELECT * FROM Seller;
SELECT * FROM Staff;
SELECT * FROM SubCategory;
SELECT * FROM Team;
SELECT * FROM Win;
