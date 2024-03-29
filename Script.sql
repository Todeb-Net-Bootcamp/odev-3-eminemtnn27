USE [emine]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateBookPublisher]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function	[dbo].[CalculateBookPublisher]
(
	@count decimal,
	@bookPrice decimal
)
Returns decimal
as
begin
	declare @bPrice decimal;
	set @bPrice=(@count+@bookPrice);
	return @bPrice
end
GO
/****** Object:  UserDefinedFunction [dbo].[func_CalculateBookPublisher]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Function	[dbo].[func_CalculateBookPublisher]
(
	@count decimal,
	@bookPrice decimal
)
Returns decimal
as
begin
	declare @bPrice decimal;
	set @bPrice=(@count+@bookPrice);
	return @bPrice
end
GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publisher](
	[publisher_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[address] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
 CONSTRAINT [PK_Publisher] PRIMARY KEY CLUSTERED 
(
	[publisher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[author_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[surname] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[gender] [varchar](50) NULL,
	[age] [varchar](50) NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[author_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[book_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[number_of_pages] [int] NULL,
	[edition_year] [varchar](50) NULL,
	[publisher_id] [int] NULL,
	[bookPrice] [nvarchar](50) NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reader]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reader](
	[reader_id] [int] NOT NULL,
	[name] [varchar](50) NULL,
	[surname] [varchar](50) NULL,
	[gender] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[book_author_publish]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[book_author_publish](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[book_id] [int] NULL,
	[author_id] [int] NULL,
	[publisher_id] [int] NULL,
	[reader_id] [int] NULL,
 CONSTRAINT [PK_book_author_publish] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vw_Library]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vw_Library]
AS
SELECT dbo.Publisher.publisher_id, dbo.book_author_publish.book_id, dbo.Reader.reader_id, dbo.Author.author_id
FROM     dbo.Publisher INNER JOIN
                  dbo.Book ON dbo.Publisher.publisher_id = dbo.Book.publisher_id INNER JOIN
                  dbo.book_author_publish ON dbo.Publisher.publisher_id = dbo.book_author_publish.publisher_id AND dbo.Book.book_id = dbo.book_author_publish.book_id INNER JOIN
                  dbo.Reader ON dbo.book_author_publish.reader_id = dbo.Reader.reader_id INNER JOIN
                  dbo.Author ON dbo.book_author_publish.author_id = dbo.Author.author_id
GO
/****** Object:  UserDefinedFunction [dbo].[BookPublisher]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[BookPublisher]  
(	
	-- Add the parameters for the function here
	@publisher_id int
	
)
RETURNS TABLE --tablo sonuç bekleniyor
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT 
	b.name as book_name, p.name as publisher_name
	from [dbo].[Book]  b
	inner join Publisher p on b.publisher_id=p.publisher_id
	where b.publisher_id=@publisher_id
)
GO
SET IDENTITY_INSERT [dbo].[Author] ON 

INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (1, N'Ronda', N'Maccaddie', N'(549) 4477206', N'Female', N'16')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (2, N'Jacinta', N'Augur', N'(567) 5924853', N'Female', N'54')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (3, N'Verene', N'Gravenall', N'(367) 9304494', N'Female', N'21')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (4, N'Wolfie', N'Hovenden', N'(648) 4998447', N'Male', N'10')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (5, N'Sunshine', N'Banisch', N'(978) 1058692', N'Female', N'29')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (6, N'Ella', N'Aartsen', N'(456) 5466194', N'Female', N'84')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (7, N'Sonia', N'Kovacs', N'(390) 3092874', N'Female', N'14')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (8, N'Natal', N'Spacy', N'(714) 9551038', N'Male', N'22')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (9, N'Goldina', N'Ricca', N'(222) 3548892', N'Female', N'74')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (10, N'Brandy', N'Kerwen', N'(584) 8230156', N'Female', N'32')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (11, N'Annabella', N'Lippett', N'(603) 4316248', N'Female', N'45')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (12, N'Brent', N'Normanville', N'(675) 3999436', N'Male', N'48')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (13, N'Ingrim', N'Zaczek', N'(680) 3686849', N'Male', N'35')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (14, N'Skyler', N'McGeachey', N'(293) 4238660', N'Female', N'36')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (15, N'Ruth', N'Drissell', N'(990) 5487675', N'Female', N'30')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (16, N'Kikelia', N'Franzonello', N'(536) 4838528', N'Female', N'23')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (17, N'Karlen', N'Chambers', N'(593) 9315108', N'Female', N'21')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (18, N'Niel', N'Joint', N'(484) 2206148', N'Male', N'52')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (19, N'Pete', N'Pattillo', N'(823) 5374749', N'Male', N'65')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (20, N'Karen', N'Pirozzi', N'(202) 2140807', N'Female', N'46')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (21, N'Silvan', N'Kensit', N'(376) 7621867', N'Male', N'41')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (22, N'Alisha', N'Hawkswood', N'(229) 2616127', N'Female', N'40')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (23, N'Gregorius', N'Ilyushkin', N'(228) 2864868', N'Male', N'27')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (24, N'Rheta', N'Tissington', N'(235) 3583527', N'Female', N'20')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (25, N'Aubry', N'Dabourne', N'(114) 2011660', N'Female', N'18')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (26, N'Conn', N'MacIlory', N'(140) 2662175', N'Male', N'14')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (27, N'Kizzie', N'MacSorley', N'(751) 8168950', N'Male', N'24')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (28, N'Kelila', N'Cockerell', N'(559) 8578905', N'Female', N'66')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (29, N'Ashlie', N'Kinset', N'(169) 3618374', N'Female', N'64')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (30, N'Javier', N'Duckfield', N'(628) 4673570', N'Male', N'77')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (31, N'Mimi', N'Lillee', N'(621) 9690120', N'Female', N'21')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (32, N'Becka', N'Brigham', N'(825) 2733315', N'Female', N'56')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (33, N'Charlie', N'Pilsbury', N'(183) 8741629', N'Male', N'57')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (34, N'Barnett', N'Kleinerman', N'(109) 9668347', N'Male', N'85')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (35, N'Pavlov', N'Cleary', N'(276) 1111313', N'Male', N'44')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (36, N'Addy', N'Mardall', N'(544) 2615428', N'Male', N'19')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (37, N'Heather', N'Dallyn', N'(543) 5310115', N'Female', N'59')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (38, N'Ranice', N'Lissaman', N'(235) 7787775', N'Female', N'19')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (39, N'Fields', N'Sterley', N'(547) 7671052', N'Male', N'19')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (40, N'Gilly', N'Frow', N'(201) 2958265', N'Female', N'24')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (41, N'Alexei', N'Bradnum', N'(901) 5497799', N'Male', N'66')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (42, N'Claribel', N'Chillingsworth', N'(646) 7370602', N'Male', N'64')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (43, N'Guilbert', N'Hoyer', N'(447) 2718476', N'Male', N'77')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (44, N'Rebekah', N'Lorimer', N'(410) 2561760', N'Female', N'21')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (45, N'Bartholomeo', N'Ayshford', N'(373) 2543191', N'Male', N'56')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (46, N'Jo', N'Hofner', N'(369) 6209490', N'Male', N'57')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (47, N'Eryn', N'Roggieri', N'(486) 1716489', N'Female', N'85')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (48, N'Gelya', N'Sone', N'(743) 8275864', N'Female', N'44')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (49, N'Trina', N'Alders', N'(658) 1278713', N'Female', N'22')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (50, N'Cad', N'Jankovsky', N'(614) 8869210', N'Male', N'74')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (51, N'Tanny', N'Maffione', N'(220) 4324050', N'Male', N'32')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (52, N'Petr', N'Macbeth', N'(130) 4789995', N'Male', N'45')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (53, N'Nicolle', N'Waylen', N'(861) 8007357', N'Female', N'48')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (54, N'Normie', N'Gamwell', N'(258) 3357718', N'Male', N'35')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (55, N'Thebault', N'MacNeilly', N'(658) 9603059', N'Male', N'36')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (56, N'Chase', N'Shilito', N'(156) 8889079', N'Male', N'30')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (57, N'Dorisa', N'Crehan', N'(371) 2497574', N'Female', N'23')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (58, N'Mikaela', N'Moreby', N'(256) 1393255', N'Female', N'21')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (59, N'Venus', N'Boyford', N'(278) 9352988', N'Female', N'18')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (60, N'Kizzee', N'Grigaut', N'(420) 1734086', N'Female', N'38')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (61, N'Roselin', N'Pere', N'(416) 1508068', N'Female', N'24')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (62, N'Andeee', N'Dugall', N'(259) 6441751', N'Female', N'66')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (63, N'Ogdan', N'De Stoop', N'(114) 4885158', N'Male', N'64')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (64, N'Ferd', N'Croal', N'(455) 7265918', N'Male', N'77')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (65, N'Lebbie', N'Cochrane', N'(683) 9095115', N'Female', N'21')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (66, N'Marillin', N'Sudell', N'(982) 7839383', N'Female', N'56')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (67, N'Flory', N'Wilacot', N'(517) 4431240', N'Male', N'57')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (68, N'Christoffer', N'Lansdowne', N'(273) 8331250', N'Female', N'85')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (69, N'Cody', N'Partrick', N'(670) 6245948', N'Female', N'44')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (70, N'Regan', N'Mackrill', N'(984) 8798716', N'Male', N'22')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (71, N'Karla', N'Holsall', N'(792) 4342933', N'Female', N'74')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (72, N'Abraham', N'Phizakarley', N'(970) 5848948', N'Male', N'32')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (73, N'Waldon', N'Reggio', N'(574) 7831852', N'Male', N'45')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (74, N'Thibaud', N'Zahor', N'(835) 4918285', N'Male', N'48')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (75, N'Samuele', N'Daulby', N'(684) 8986940', N'Male', N'35')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (76, N'Abner', N'Matus', N'(470) 8184405', N'Male', N'36')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (77, N'Jerome', N'O''Shiel', N'(989) 5124026', N'Male', N'30')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (78, N'Amye', N'Venner', N'(990) 1902439', N'Female', N'23')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (79, N'Lacey', N'Akram', N'(457) 3819535', N'Female', N'21')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (80, N'Dill', N'Wenham', N'(156) 7535064', N'Male', N'25')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (81, N'Reinald', N'Casone', N'(551) 1565407', N'Male', N'78')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (82, N'Dame', N'Angrock', N'(254) 5778428', N'Male', N'19')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (83, N'Selina', N'Vance', N'(771) 5470354', N'Female', N'16')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (84, N'Ragnar', N'McFeat', N'(710) 3294393', N'Male', N'54')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (85, N'Lorrie', N'Panther', N'(230) 5680391', N'Female', N'21')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (86, N'Celene', N'Walker', N'(697) 2582649', N'Female', N'10')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (87, N'Marti', N'Mitford', N'(968) 7856701', N'Female', N'29')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (88, N'Colet', N'Thomtson', N'(382) 9709798', N'Male', N'85')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (89, N'Myrna', N'Pick', N'(327) 9236669', N'Female', N'44')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (90, N'Merry', N'Biddell', N'(448) 2531059', N'Male', N'22')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (91, N'Wenonah', N'Facher', N'(391) 4947603', N'Female', N'74')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (92, N'Guillema', N'Crusham', N'(511) 7241625', N'Female', N'32')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (93, N'Ambrosi', N'Beefon', N'(555) 2389314', N'Male', N'22')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (94, N'Liliane', N'Biaggioni', N'(507) 8977878', N'Female', N'10')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (95, N'Vera', N'Pyser', N'(382) 6408260', N'Male', N'29')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (96, N'Vida', N'Alflat', N'(440) 8093265', N'Male', N'36')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (97, N'Tabbie', N'McShane', N'(705) 3781767', N'Female', N'41')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (98, N'Dion', N'Sokill', N'(654) 7198966', N'Female', N'16')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (99, N'Madel', N'Lacrouts', N'(883) 1512689', N'Female', N'54')
GO
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (100, N'Domenico', N'Moorfield', N'(983) 7893533', N'Male', N'21')
INSERT [dbo].[Author] ([author_id], [name], [surname], [phone], [gender], [age]) VALUES (101, N'Charles', N'Dickens', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Author] OFF
GO
SET IDENTITY_INSERT [dbo].[Book] ON 

INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (1, N'Cry, the beloved country
', 327, N'1992', 3, N'60')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (2, N'Cathedral
', 487, N'2001', 5, N'54')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (3, N'Count of Monte Cristo
', 426, N'2012', 7, N'89')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (4, N'The Clay marble
', 380, N'1988', 2, N'54')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (5, N'Adventures of Sherlock Holmes
', 114, N'2007', 90, N'24')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (6, N'Adventures of Tom Sawyer
', 522, N'2005', 11, N'95')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (7, N'Animal Dreams
', 290, N'2008', 54, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (8, N'1984 / George Orwell
', 390, N'1992', 32, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (9, N'Pride and Prejudice', 585, N'2010', 1, N'52')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (10, N'To Kill a Mockingbird', 457, N'2000', 22, N'65')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (11, N'The Great Gatsby', 253, N'2000', 5, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (12, N'The Great Gatsby', 382, N'2002', 4, N'55')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (13, N' Wide Sargasso Sea', 464, N'1991', 100, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (14, N'Brave New World', 258, N'2004', 5, N'40')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (15, N'Jane Eyre', 282, N'1994', 6, N'65')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (16, N' The Lion, the Witch and the Wardrobe ', 452, N'1995', 8, N'60')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (17, N'Crime and Punishment', 549, N'2010', NULL, N'55')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (18, N'The Chrysalids ', 101, N'1983', NULL, N'44')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (19, N' Persuasion ', 197, N'1986', NULL, N'84')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (20, N'Moby-Dick', 368, N'2008', NULL, N'52')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (21, N'To the Lighthouse ', 417, N'2002', NULL, N'74')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (22, N'The Death of the Heart', 422, N'1996', NULL, N'52')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (23, N'Frankenstein', 485, N'1991', 23, N'28')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (24, N'The Master and Margarita', 150, N'2005', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (25, N'Nineteen Eighty-Four', 327, N'2008', NULL, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (26, N'The Grapes of Wrath', 521, N'1999', 27, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (27, N'Dracula ', 445, N'1999', NULL, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (28, N'The Lord of the Rings', 583, N'2008', NULL, N'49')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (29, N'The Adventures of Huckleberry Finn', 133, N'1999', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (30, N'Great Expectations', 549, N'1985', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (31, N'Catch-22', 126, N'2007', NULL, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (32, N' The Age of Innocence ', 441, N'1988', 93, N'59')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (33, N'Things Fall Apart', 293, N'2004', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (34, N'Middlemarch', 316, N'1994', NULL, N'39')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (35, N' Midnight''s Children ', 160, N'2010', NULL, N'55')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (36, N'Alice’s Adventures in Wonderland ', 372, N'2000', NULL, N'29')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (37, N'The Mill on the Floss ', 176, N'2012', NULL, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (38, N'Barchester Towers', 310, N'2012', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (39, N'Charlie and the Chocolate Factory', 198, N'1990', 75, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (40, N'Another Country', 423, N'2005', NULL, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (41, N' The Outsiders', 366, N'2005', NULL, N'55')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (42, N' The Count of Monte Cristo ', 458, N'2003', NULL, N'48')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (43, N' Ulysses', 296, N'2003', NULL, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (44, N'East of Eden', 302, N'2012', NULL, N'55')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (45, N'The Brothers Karamazov', 357, N'2009', NULL, N'34')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (46, N'The Secret Garden', 234, N'2003', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (47, N'Scoop', 303, N'2007', NULL, N'33')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (48, N'A Tale of Two Cities', 267, N'1993', 82, N'55')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (49, N'Anna Karenina', 104, N'2002', NULL, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (50, N' The Betrothed ', 233, N'2002', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (51, N'Orlando', 417, N'1995', NULL, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (52, N'Atlas Shrugged', 505, N'1992', NULL, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (53, N'The Time Machine', 124, N'2005', NULL, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (54, N'The Art of War', 570, N'2007', NULL, N'20')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (55, N'The Forsyte Saga', 435, N'2013', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (56, N'Travels with Charley', 381, N'1996', NULL, N'55')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (57, N' Tropic of Cancer', 231, N'2009', NULL, N'85')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (58, N' Staying On', 466, N'1996', NULL, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (59, N'The Wind in the Willows', 265, N'2005', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (60, N'My Ántonia', 475, N'2005', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (61, N'Wuthering Heights', 135, N'2012', 81, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (62, N'War and Peace', 480, N'1991', NULL, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (63, N' Of Human Bondage ', 365, N'2012', NULL, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (64, N'Bleak House', 258, N'1986', NULL, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (65, N'Lost Illusions ', 110, N'2012', NULL, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (66, N' Breakfast of Champions', 277, N'2006', 61, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (67, N' A Christmas Carol', 296, N'2001', 38, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (68, N'Silas Marner', 396, N'1984', 57, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (69, N'Mrs Dalloway', 492, N'1993', 19, N'36')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (70, N'Little Women', 144, N'1984', 99, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (71, N'The Sea', 138, N'2008', 29, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (72, N'Zen and the Art of Motorcycle Maintenance', 479, N'1994', 14, N'47')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (73, N'The Castle', 320, N'2007', 90, N'55')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (74, N'I, Claudius', 101, N'1963', 73, N'20')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (75, N' Peter Pan ', 230, N'1988', 74, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (76, N' A Confederacy of Dunces ', 305, N'2000', 92, N'25')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (77, N' The Razor''s Edge', 340, N'1995', 86, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (78, N'Lark Rise to Candleford', 209, N'2000', 55, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (79, N'The Return of the Native ', 430, N'2001', 98, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (80, N'A Portrait of the Artist as a Young Man', 117, N'1992', 87, N'39')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (81, N'Heart of Darkness', 356, N'2003', 91, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (82, N'North and South', 231, N'2009', 44, N'85')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (83, N'The Handmaid''s Tale ', 281, N'2004', 89, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (84, N'What A Carve Up!', 452, N'2009', 88, N'59')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (85, N'The Godfather', 209, N'2000', 37, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (86, N'Suite Francaise', 392, N'2010', 76, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (87, N'One Day in the Life of Ivan Denisovich ', 548, N'2007', 71, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (88, N'White Nights', 440, N'1984', 83, N'49')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (89, N'Hard Times', 385, N'2012', 30, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (90, N'Breathing Lessons ', 246, N'1985', 14, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (91, N'Jake''s Thing ', 378, N'1992', 37, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (92, N'The Joy Luck Club', 400, N'2005', 39, N'55')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (93, N'The Epic of Gilgamesh', 286, N'1996', 80, N'20')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (94, N'Spring ', 479, N'2011', 48, N'60')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (95, N'Never Change', 560, N'2004', 64, N'35')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (96, N'I Remember Nothing ', 248, N'2007', 84, N'45')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (97, N'Nine Island ', 148, N'2008', 13, N'30')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (98, N'Mrs Dalloway', 224, N'1988', 82, N'55')
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (99, N'The Sea, The Sea', 338, N'2001', 49, N'30')
GO
INSERT [dbo].[Book] ([book_id], [name], [number_of_pages], [edition_year], [publisher_id], [bookPrice]) VALUES (100, N'Middle England', 531, N'2001', 55, N'45')
SET IDENTITY_INSERT [dbo].[Book] OFF
GO
SET IDENTITY_INSERT [dbo].[book_author_publish] ON 

INSERT [dbo].[book_author_publish] ([id], [book_id], [author_id], [publisher_id], [reader_id]) VALUES (1, 1, 2, 3, 3)
INSERT [dbo].[book_author_publish] ([id], [book_id], [author_id], [publisher_id], [reader_id]) VALUES (2, 2, 4, 5, 9)
INSERT [dbo].[book_author_publish] ([id], [book_id], [author_id], [publisher_id], [reader_id]) VALUES (3, 100, 9, 2, 10)
SET IDENTITY_INSERT [dbo].[book_author_publish] OFF
GO
SET IDENTITY_INSERT [dbo].[Publisher] ON 

INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (1, N'Heather', N'00200 Bartelt Drive', N'hmattingley0@people.com.cn', N'(191) 3860539')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (2, N'Ryley', N'4 Cordelia Street', N'rmeekin1@amazon.com', N'(244) 9656688')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (3, N'Ailsun', N'9916 Bonner Park', N'apickerin2@spiegel.de', N'(411) 6274432')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (4, N'Maison', N'5 Bartillon Lane', N'mcarney3@squarespace.com', N'(791) 8779517')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (5, N'Vivian', N'8 Basil Hill', N'vkerans4@ed.gov', N'(119) 7472063')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (6, N'Vally', N'5255 Knutson Circle', N'vhegg5@illinois.edu', N'(309) 9824115')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (7, N'Patin', N'83670 Ramsey Avenue', N'pmccrainor6@storify.com', N'(624) 1811574')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (8, N'Gray', N'51 Lunder Parkway', N'gcurtain7@biblegateway.com', N'(500) 7026581')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (9, N'Cal', N'56947 Sunnyside Pass', N'cschoales8@google.co.uk', N'(299) 5115017')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (10, N'Edita', N'3 Cascade Way', N'ecovotto9@howstuffworks.com', N'(922) 6243842')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (11, N'Georgianna', N'3 Roth Terrace', N'gslatchera@dell.com', N'(358) 3401639')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (12, N'Drona', N'78296 Waywood Plaza', N'dfoxtenb@eventbrite.com', N'(660) 8635641')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (13, N'Aundrea', N'4 Shopko Pass', N'aobrallaghanc@acquirethisname.com', N'(888) 8871838')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (14, N'Quincy', N'02 Westerfield Junction', N'qduesberryd@tinypic.com', N'(505) 4627603')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (15, N'Anita', N'15189 South Road', N'ahackine@apple.com', N'(649) 3225744')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (16, N'Barrie', N'390 Sage Way', N'blightowlerf@odnoklassniki.ru', N'(847) 3920170')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (17, N'Gleda', N'0 Prairieview Drive', N'gbockettg@icio.us', N'(276) 1367728')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (18, N'Billie', N'773 Caliangt Avenue', N'bblibenh@posterous.com', N'(501) 4424813')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (19, N'Wilt', N'5356 Carioca Pass', N'wbriersi@rediff.com', N'(645) 6650751')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (20, N'Jemmie', N'9 Homewood Street', N'jwristj@yellowpages.com', N'(617) 7584977')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (21, N'Courtnay', N'8823 Vahlen Park', N'ccuxonk@wisc.edu', N'(753) 7497613')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (22, N'Cindi', N'0 Sundown Plaza', N'cklempsl@ed.gov', N'(294) 1194120')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (23, N'Bartholomeo', N'634 Jenna Crossing', N'bflintoffem@ehow.com', N'(293) 5201411')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (24, N'Janeta', N'40564 Merchant Junction', N'jclinchn@umich.edu', N'(274) 4732554')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (25, N'Feodor', N'5 Reindahl Court', N'fpelcheuro@unicef.org', N'(385) 4916688')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (26, N'Nady', N'00608 Mockingbird Avenue', N'nphillippsp@instagram.com', N'(996) 4946294')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (27, N'Cullan', N'7672 Fair Oaks Parkway', N'chulattq@theguardian.com', N'(436) 7971198')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (28, N'Cathrine', N'9006 Macpherson Trail', N'cfiddlerr@usatoday.com', N'(598) 5246998')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (29, N'Montgomery', N'3 Kingsford Plaza', N'mflacknoes@psu.edu', N'(171) 8699995')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (30, N'Anson', N'3485 Thackeray Way', N'apotteridget@youku.com', N'(897) 4342530')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (31, N'Michele', N'0 Aberg Road', N'mshaxbyu@is.gd', N'(702) 4291298')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (32, N'Cobb', N'5 Montana Point', N'cfortv@scribd.com', N'(881) 7380918')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (33, N'Elke', N'9 Hauk Crossing', N'epassfieldw@state.tx.us', N'(495) 4755706')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (34, N'Austina', N'87 Namekagon Trail', N'aoliverasx@webmd.com', N'(695) 7240750')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (35, N'Gregorio', N'246 Sage Road', N'gdinceyy@google.co.jp', N'(522) 8844845')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (36, N'Colline', N'6 Laurel Point', N'cfishleyz@php.net', N'(208) 4417466')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (37, N'Dyanna', N'154 Commercial Point', N'dterrington10@webmd.com', N'(906) 1766760')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (38, N'Nadya', N'39 Ryan Hill', N'ntrayton11@bigcartel.com', N'(927) 6076489')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (39, N'Arthur', N'7 Fairview Street', N'acracknall12@cocolog-nifty.com', N'(652) 3653456')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (40, N'Mikel', N'7 Village Plaza', N'mlies13@independent.co.uk', N'(547) 2642591')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (41, N'Ginny', N'55682 Southridge Court', N'gfalla14@vinaora.com', N'(639) 1627309')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (42, N'Joela', N'659 Iowa Drive', N'jharbidge15@cbsnews.com', N'(549) 2365323')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (43, N'Mirabel', N'07 Buhler Point', N'mjarman16@uiuc.edu', N'(526) 7804074')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (44, N'Carolan', N'5 Bonner Pass', N'ctrinke17@addtoany.com', N'(709) 9372069')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (45, N'Morty', N'8 Sloan Parkway', N'msaltmarsh18@altervista.org', N'(331) 3032306')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (46, N'Rab', N'673 Melby Center', N'rtizard19@google.cn', N'(457) 1073240')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (47, N'Courtenay', N'2 Maryland Junction', N'cgomer1a@fotki.com', N'(884) 7147669')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (48, N'Caspar', N'1 Hollow Ridge Circle', N'cnatalie1b@twitter.com', N'(589) 5754251')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (49, N'Carlota', N'1 Truax Circle', N'cwick1c@smugmug.com', N'(833) 8195745')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (50, N'Konstance', N'59 Spohn Lane', N'keyer1d@wix.com', N'(162) 4446978')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (51, N'Iggy', N'49727 Marcy Court', N'istute1e@sciencedirect.com', N'(379) 1551018')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (52, N'Stearn', N'86131 Grayhawk Park', N'shookes1f@networksolutions.com', N'(451) 2830008')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (53, N'Kelly', N'213 Kedzie Point', N'kmcgennis1g@freewebs.com', N'(448) 8036752')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (54, N'Izzy', N'4 Clemons Parkway', N'iespinosa1h@bloglovin.com', N'(884) 4639989')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (55, N'Monti', N'8 Eagan Crossing', N'msimenet1i@wikipedia.org', N'(742) 8452007')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (56, N'Letisha', N'3133 Hallows Terrace', N'lthorndale1j@uiuc.edu', N'(415) 4544115')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (57, N'Lonnie', N'72 Union Way', N'lbartomeu1k@dailymotion.com', N'(214) 4333600')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (58, N'Kailey', N'1 High Crossing Road', N'kjancey1l@icq.com', N'(221) 6360545')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (59, N'Floria', N'708 Evergreen Place', N'fconti1m@harvard.edu', N'(984) 3312267')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (60, N'Boyd', N'3877 Gerald Point', N'bpillman1n@sciencedaily.com', N'(724) 3133044')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (61, N'Brandise', N'1 Colorado Way', N'bgilling1o@soundcloud.com', N'(305) 7895601')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (62, N'Berty', N'347 Heffernan Place', N'blayland1p@fda.gov', N'(408) 5538184')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (63, N'Roosevelt', N'0 Warner Road', N'rsutlieff1q@goo.ne.jp', N'(534) 7868907')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (64, N'Giulietta', N'90223 Moland Park', N'gblew1r@youku.com', N'(644) 6924413')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (65, N'Brandy', N'5802 Rusk Place', N'bchamberlayne1s@dagondesign.com', N'(450) 3664620')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (66, N'Pierson', N'231 Pierstorff Place', N'ptotton1t@google.co.jp', N'(780) 2492019')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (67, N'Letty', N'05 Lunder Center', N'lastell1u@i2i.jp', N'(623) 7506802')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (68, N'Dixie', N'4414 Talisman Terrace', N'dsaint1v@cdc.gov', N'(331) 5699826')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (69, N'Barty', N'77 Green Ridge Hill', N'bsaveall1w@bravesites.com', N'(495) 5404916')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (70, N'Kingsley', N'420 Elka Center', N'kduplan1x@usda.gov', N'(434) 9564786')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (71, N'Maisey', N'138 Macpherson Terrace', N'mallin1y@youtu.be', N'(190) 2962772')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (72, N'Zaria', N'52517 Oakridge Lane', N'zbrecknell1z@scientificamerican.com', N'(236) 9384932')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (73, N'Greggory', N'9 Tennyson Lane', N'ghotton20@cdbaby.com', N'(745) 2205133')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (74, N'Christel', N'44 Sherman Pass', N'cclaridge21@japanpost.jp', N'(819) 9871996')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (75, N'Enoch', N'446 Browning Center', N'ebrevitt22@skype.com', N'(634) 6839536')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (76, N'Harriott', N'44 Westend Road', N'hjosephoff23@ebay.com', N'(888) 6172066')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (77, N'Hally', N'30255 Mariners Cove Trail', N'hdaleman24@accuweather.com', N'(905) 9070072')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (78, N'Quintin', N'14308 Truax Circle', N'qsangwine25@pcworld.com', N'(970) 9679152')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (79, N'Elberta', N'8 Mayer Plaza', N'esowley26@vinaora.com', N'(639) 6968738')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (80, N'Sergei', N'88 Continental Alley', N'skirman27@amazon.de', N'(192) 2046728')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (81, N'Cristie', N'113 Kropf Hill', N'cbidewel28@flickr.com', N'(363) 2059588')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (82, N'Iggie', N'09 Dorton Drive', N'iklezmski29@livejournal.com', N'(291) 4923552')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (83, N'Olav', N'26140 Glacier Hill Drive', N'opesek2a@umich.edu', N'(148) 2297962')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (84, N'Lorri', N'0 Havey Circle', N'lcharlin2b@prweb.com', N'(456) 8248134')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (85, N'Bendicty', N'55 Northport Circle', N'bpays2c@github.io', N'(276) 5946435')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (86, N'Bella', N'94194 Jana Plaza', N'bpleager2d@instagram.com', N'(653) 8656651')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (87, N'Aurel', N'4100 Sutherland Lane', N'amaccarroll2e@wordpress.org', N'(589) 7823859')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (88, N'Elladine', N'78208 Warrior Court', N'enarup2f@live.com', N'(319) 3357031')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (89, N'Roberta', N'13 Stang Center', N'rdouble2g@joomla.org', N'(841) 3166079')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (90, N'Porter', N'53 Killdeer Avenue', N'pgilbertson2h@goo.ne.jp', N'(410) 5581472')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (91, N'Deanna', N'80 7th Alley', N'dsilverwood2i@ucla.edu', N'(234) 7238167')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (92, N'Tobey', N'1607 Park Meadow Avenue', N'tschuler2j@thetimes.co.uk', N'(114) 1816692')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (93, N'Nicki', N'274 Sachs Way', N'nquan2k@angelfire.com', N'(370) 4958354')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (94, N'Marta', N'88 Lotheville Terrace', N'mhamlen2l@springer.com', N'(146) 1439386')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (95, N'Haroun', N'23 Surrey Hill', N'harsey2m@marketwatch.com', N'(510) 1545646')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (96, N'Goldie', N'489 Maryland Street', N'gplayer2n@wikimedia.org', N'(371) 2033710')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (97, N'Ross', N'408 Browning Way', N'rheigho2o@comsenz.com', N'(848) 8601198')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (98, N'Augustus', N'980 Hermina Center', N'apitrasso2p@accuweather.com', N'(620) 2717136')
INSERT [dbo].[Publisher] ([publisher_id], [name], [address], [email], [phone]) VALUES (99, N'Porty', N'921 Shelley Plaza', N'pgiovannelli2q@reference.com', N'(659) 5824981')
GO
SET IDENTITY_INSERT [dbo].[Publisher] OFF
GO
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (1, N'Carolus', N'Clifforth', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (2, N'Rikki', N'Kaaskooper', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (3, N'Kimberlee', N'Harle', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (4, N'Kameko', N'Tandy', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (5, N'Jemima', N'McFeate', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (6, N'Donalt', N'Jochen', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (7, N'Chrysler', N'Fidal', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (8, N'Alexina', N'Awcoate', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (9, N'Kirsti', N'De la Perrelle', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (10, N'Odessa', N'St. Pierre', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (11, N'Ravi', N'Farmery', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (12, N'Jenilee', N'Endley', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (13, N'Buck', N'Llewelly', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (14, N'Bastien', N'Pavier', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (15, N'Izabel', N'Froment', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (16, N'Rusty', N'Gall', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (17, N'Terencio', N'Laslett', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (18, N'Yorgos', N'Spohr', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (19, N'Benn', N'Attenbrough', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (20, N'Jillian', N'Buckner', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (21, N'Byrom', N'Rogeron', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (22, N'Amalle', N'Bier', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (23, N'Emory', N'Chyuerton', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (24, N'Cullin', N'Hackett', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (25, N'Dorette', N'Bondley', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (26, N'Nat', N'Minter', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (27, N'Esra', N'Vina', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (28, N'Jordan', N'Sprey', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (29, N'Leticia', N'Matitiaho', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (30, N'Bent', N'Killich', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (31, N'Lindie', N'Grote', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (32, N'Frankie', N'Abbate', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (33, N'Valida', N'Jedrzejczyk', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (34, N'Liane', N'Karolyi', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (35, N'Benjie', N'Whitmell', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (36, N'Moselle', N'Gosnay', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (37, N'Ethel', N'Chrystal', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (38, N'Ardath', N'de Pinna', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (39, N'Eziechiele', N'Thatcham', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (40, N'Aluino', N'Charville', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (41, N'Elmore', N'Hatchard', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (42, N'Idalina', N'Zanassi', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (43, N'Armin', N'Checkley', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (44, N'Raynard', N'Loxley', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (45, N'Maren', N'Ridd', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (46, N'Hal', N'Neeves', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (47, N'Giselle', N'Errey', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (48, N'Gayler', N'Chismon', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (49, N'Kingston', N'Tidy', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (50, N'Kelwin', N'Burtenshaw', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (51, N'Peri', N'Skechley', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (52, N'Dallon', N'Ashlin', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (53, N'Donaugh', N'Lavallin', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (54, N'Latia', N'Bernardeschi', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (55, N'Lorrin', N'Reidshaw', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (56, N'Dennet', N'Grewes', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (57, N'Corrine', N'Shemmans', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (58, N'Debby', N'Couchman', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (59, N'Alfredo', N'Tomasik', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (60, N'Franky', N'Bru', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (61, N'Zacherie', N'Ekkel', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (62, N'Flor', N'Osmund', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (63, N'Lavinie', N'Euplate', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (64, N'Bastian', N'Knutsen', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (65, N'Kimmie', N'King', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (66, N'Jeannie', N'Brozsset', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (67, N'Dal', N'Mattschas', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (68, N'Maudie', N'Yexley', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (69, N'Kearney', N'Ventum', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (70, N'Harri', N'Hopfner', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (71, N'Orrin', N'Bowell', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (72, N'Doralia', N'Hellmer', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (73, N'Kaitlynn', N'Robjohns', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (74, N'Lora', N'Edmeads', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (75, N'Glenna', N'Quemby', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (76, N'Leela', N'Juan', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (77, N'Pam', N'Hall-Gough', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (78, N'Salome', N'Reddy', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (79, N'Jemima', N'Pinner', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (80, N'Far', N'Coe', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (81, N'Winfield', N'Ollerhead', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (82, N'Alfons', N'Widdison', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (83, N'Enos', N'Filipyev', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (84, N'Christean', N'Odo', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (85, N'Ozzy', N'Spykins', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (86, N'Dasie', N'Whitley', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (87, N'Jeralee', N'Aronstam', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (88, N'Marney', N'Peabody', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (89, N'Marlee', N'Dyble', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (90, N'Lambert', N'Linfoot', N'Male')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (91, N'Cymbre', N'Collings', N'Female')
INSERT [dbo].[Reader] ([reader_id], [name], [surname], [gender]) VALUES (92, N'Harley', N'Dowty', N'Male')
GO
/****** Object:  StoredProcedure [dbo].[spAuthor]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAuthor]
	-- Add the parameters for the stored procedure here
	@name nvarchar(15),
	@surname nvarchar(15)
AS
BEGIN
	INSERT INTO Author([name],[surname])
	VALUES(@name,@surname)
	SELECT * FROM Author
END
GO
/****** Object:  StoredProcedure [dbo].[spPublisher]    Script Date: 12.07.2022 17:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPublisher]
	-- Add the parameters for the stored procedure here
	@name nvarchar(15),
	@address nvarchar(15)
AS
BEGIN
	INSERT INTO Publisher([name],[address])
	VALUES(@name,@address)
	SELECT * FROM Publisher
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[73] 4[3] 2[7] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Author"
            Begin Extent = 
               Top = 23
               Left = 37
               Bottom = 241
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Publisher"
            Begin Extent = 
               Top = 424
               Left = 890
               Bottom = 623
               Right = 1100
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Reader"
            Begin Extent = 
               Top = 77
               Left = 1010
               Bottom = 256
               Right = 1217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Book"
            Begin Extent = 
               Top = 77
               Left = 512
               Bottom = 278
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "book_author_publish"
            Begin Extent = 
               Top = 313
               Left = 256
               Bottom = 501
               Right = 463
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vw_Library'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'00
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vw_Library'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vw_Library'
GO
