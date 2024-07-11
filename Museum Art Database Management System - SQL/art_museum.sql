DROP DATABASE IF EXISTS ART_MUSEUM;
CREATE DATABASE ART_MUSEUM; 
USE ART_MUSEUM;


# ARTIST
DROP TABLE IF EXISTS ARTIST;
CREATE TABLE ARTIST (
	Name			varchar(50)	not null,
	Date_Born		varchar(20),
	Date_Died			varchar(20),
	Country_of_Origin	varchar(20),
	Epoch				varchar(20),
	Main_Style			varchar(20),
	Description			mediumtext,
	primary key (Name)
);

INSERT INTO ARTIST(Name, Date_Born, Date_Died, Country_of_Origin, Epoch, Main_Style, Description)
VALUES
('Hans Holbein the Younger','1497','1543','Germany','Renaissance','Realistic', 'Considered one of the greatest portratists of the 16th century'),
('George Gower','1540','1596','England', 'Renaissance', 'Realistic', 'Serjeant Painter to Queen Elizabeth I'),
('Benedetto da Rovezzano','1474','1554','Italy','Renaissance', 'Realistic', 'Italian architect and sculptor'),
('John Shute',null,'1563','England', 'Renaissance', 'Realistic', 'English artist and architect'),
('Juan Fernández',null,'1657','Spain', 'Post-Renaissance','Realistic', 'Specialized in still life painting'),
('Pablo Picasso','October 25, 1881','April 8, 1973', 'Spain', 'Modern', 'Abstract', 'One of the most influential artists of the 20th century'),
('Isidore Leroy','1842',null, 'France', 'Modern', 'Pattern', 'French wallpaper house'),
('Robert Pruitt','1975',null, 'American', 'Modern', 'Realistic', 'Known for his figurative drawings'),
('Simone Leigh','1967',null, 'American', 'Modern', 'Abstract', 'American artist concerned with the marginilzation of women of colour'),
('Theaster Gates','1973',null, 'American', 'Modern', 'Abstract', 'American social practice artist'),
('Woody de Othello','1991',null, 'American', 'Modern', 'Abstract', 'American ceramicist and painter'),
('Robert Campin','1375',"April 26, 1444", 'Netherlands', 'Renaissance', 'Realistic', 'First great master of Early Netherlandish painting'),
('Anonymous',null, null, null, null,null,'Used when the artist could not be identified.'),
('Antoine-Louis Barye','September 24, 1795', 'June 25, 1875', 'France', 'Modern','Realistic','Famous for his work as an animalier');


# EXHIBITION
DROP TABLE IF EXISTS EXHIBITION;
CREATE TABLE EXHIBITION (
	Name			varchar(100)	not null,
	Start_Date			varchar(20),
	End_Date			varchar(20),
	primary key (Name)
);

INSERT INTO EXHIBITION(Name, Start_Date, End_Date)
VALUES
('The Tudors: Art and Majesty in Renaissance England','October 10, 2022','January 8, 2023'),
('Cubism and the Trompe l''Oeil Tradition','October 20, 2022','January 22, 2023'),
('Hear Me Now: The Black Potters of Old Edgefield, South Carolina','September 9, 2022','February 5, 2023'),
('''MNR'' Works At The Musée du Louvre',null,null),
('Masterpieces of The Louvre',null,null);


# ART_OBJECT
DROP TABLE IF EXISTS ART_OBJECT;
CREATE TABLE ART_OBJECT (
	ID_Num					varchar(30)	not null,
	Artist				varchar(50),
	Year			varchar(10),
    Title			varchar(100),
	Description      mediumtext,
	Culture          varchar(20),
	Epoch             varchar(20),
	Exhibition           varchar(100),
	primary key (ID_Num),
	foreign key (Exhibition) references EXHIBITION(Name) ON DELETE CASCADE,
	foreign key (Artist) references ARTIST(Name) ON DELETE CASCADE
);

INSERT INTO ART_OBJECT (ID_Num, Artist, Year, Title, Description, Culture, Epoch, Exhibition)
VALUES
('A_001','Hans Holbein the Younger','1537','Henry VIII', 'Portrait of Henry VIII', 'England', 'Renaissance', 'The Tudors: Art and Majesty in Renaissance England'),
('A_002','George Gower','1567','Elizabeth I (The Hampden Portrait)','Portrait of Elizabeth I', 'England', 'Renaissance', 'The Tudors: Art and Majesty in Renaissance England'),
('A_003','Benedetto da Rovezzano','1524-29','Angel Bearing Candlestick','An angel bearing a candlestick','Italy', 'Renaissance', 'The Tudors: Art and Majesty in Renaissance England'),
('A_004','Benedetto da Rovezzano','1500','Candelabrum', 'A candelabrum', 'Italy', 'Renaissance', 'The Tudors: Art and Majesty in Renaissance England'),
('A_005','Hans Holbein the Younger','1533-36','Anne Boleyn', 'Portrait of Anne Boleyn', 'England', 'Renaissance', 'The Tudors: Art and Majesty in Renaissance England'),
('E_006','John Shute','1563','The First and Chief Groundes of Architecture Used in All the Auncient and Famous Monymentes...','Written Text', 'England', 'Renaissance','The Tudors: Art and Majesty in Renaissance England'),
('E_007','Juan Fernández','1636','Still Life with Four Bunches of Grapes', 'Still-life painting emerged in the 1600s as a fully independent subject in European art, and grapes and curtains became popular motifs for artists aiming to vaunt their skills', 'Spain', 'Post-Renaissance', 'Cubism and the Trompe l''Oeil Tradition'),
('E_008','Pablo Picasso','1912','Still Life with Chair Caning', 'Machine-printed to look like the textured rattan weave used in chairs, this piece of trumpery is materially real but patently fake.', 'Spain', 'Modern','Cubism and the Trompe l''Oeil Tradition'),
('E_009','Pablo Picasso','1914','The Absinthe Glass','Picasso''s life-size rendering of a glass of alcohol was shocking for its banality.', 'Spanish', 'Modern', 'Cubism and the Trompe l''Oeil Tradition'),
('E_010','Isidore Leroy','1908-09','Wallpaper: pattern 15292 R', 'The wallpapers and borders displayed here are similar or identical to those the Cubists used in their collages and pastiched in their paintings.', 'France', 'Modern', 'Cubism and the Trompe l''Oeil Tradition'),
('P_011','Robert Pruitt','2019','Birth and Rebirth and Rebirth', 'Painting of woman', 'American', 'Modern', 'Hear Me Now: The Black Potters of Old Edgefield, South Carolina'),
('P_012','Simone Leigh','2019','108 (Face Jug Series)', 'Abstract painting of woman on mug', 'American', 'Modern', 'Hear Me Now: The Black Potters of Old Edgefield, South Carolina'),
('P_013','Simone Leigh','2021-22','Large Jug', 'Abstract mug', 'American', 'Modern', 'Hear Me Now: The Black Potters of Old Edgefield, South Carolina'),
('P_014','Theaster Gates','2020','Signature Study', 'Stoneware', 'American', 'Modern', 'Hear Me Now: The Black Potters of Old Edgefield, South Carolina'),
('P_015','Woody de Othello','2021','Applying Pressure', 'Vase on Table', 'American', 'Modern', 'Hear Me Now: The Black Potters of Old Edgefield, South Carolina'),
('P_016','Robert Campin','1400-1500','Vierge et Enfant', 'Virgin and Child', 'Netherlands', 'Renaissance', '''MNR'' Works At The Musée du Louvre'),
('P_017','Anonymous','1900-35','Velours à losanges frappés à dominante rouge', 'Velvet with red diamonds', 'Unknown', 'Modern', '''MNR'' Works At The Musée du Louvre'),
('P_018','Anonymous','1500-1900','Vase hispano-mauresque à quatre anses', 'Hispano-Moorish vase with four handles', 'Spain', 'Renaissance', '''MNR'' Works At The Musée du Louvre'),
('P_019','Anonymous','525-550','Feuillet de diptyque en cinq parties : l''Empereur triomphant (Justinien?)', 'Diptych folio in five parts: the triumphant Emperor (Justinian?)', 'Constantinopole', 'Middle Ages', 'Masterpieces of The Louvre'),
('P_020','Anonymous','100-150','portrait de momie ; L''Européenne', 'Portrait of a Mummy', 'Egypt', 'Roman Period', 'Masterpieces of The Louvre'),
('P_021','Antoine-Louis Barye','1832','Lion au serpent', 'Lion with a snake', 'France', 'Modern', 'Masterpieces of The Louvre');


# PAINTING
DROP TABLE IF EXISTS PAINTING;
CREATE TABLE PAINTING (
	ID_Num			varchar(30) not null,
	Paint_Type				varchar(20),
	Drawn_on				varchar(20),
	Style			varchar(20),
	primary key (ID_Num),
	foreign key (ID_Num) references ART_OBJECT(ID_Num) ON DELETE CASCADE    
);

INSERT INTO PAINTING (ID_Num, Paint_Type, Drawn_on, Style)
VALUES
('A_001','Oil','Panel','Realistic'),
('A_002','Oil','Canvas','Realistic'),
('E_007','Oil','Canvas','Realistic'),
('E_008','Oil','Oilcloth','Abstract'),
('P_011','Conte',null,'Realistic'),
('P_016',null,'Metal','Realistic'),
('P_020','Leaf Gliding','Cedar','Realistic');


# SCULPTURE_STATUE
DROP TABLE IF EXISTS SCULPTURE_STATUE;
CREATE TABLE SCULPTURE_STATUE (
	ID_Num		varchar(30) not null,
	Material				varchar(20),
	Height		varchar(20),
	Weight		varchar(20),
	Style        varchar(20),
	primary key (ID_Num),
	foreign key (ID_Num) references ART_OBJECT(ID_Num) ON DELETE CASCADE
);

INSERT INTO SCULPTURE_STATUE (ID_Num, Material, Height, Weight, Style)
VALUES
('A_003','Bronze','101cm','141kg','Realistic'),
('A_004','Bronze','340cm','622kg', 'Realistic'),
('E_009','Bronze','22.5cm',null,'Abstract'),
('P_012','Porcelain','44.5cm',null, 'Abstract'),
('P_013','Stoneware','158.8cm','346.5kg', 'Abstract'),
('P_014','Stoneware','54.9cm','40.8kg', 'Abstract'),
('P_015','Ceramic/Oak Wood','96.5cm',null, 'Abstract'),
('P_018','Ceramic','48cm',null,'Realistic'),
('P_021','Bronze','135cm',null, 'Realistic');


# OTHER
DROP TABLE IF EXISTS OTHER;
CREATE TABLE OTHER (
	ID_Num		varchar(30) not null,
	Type		varchar(20),
	Style		varchar(20),
	primary key (ID_Num),
	foreign key (ID_Num) references ART_OBJECT(ID_Num) ON DELETE CASCADE
);

INSERT INTO Other (ID_Num, Type, Style)
VALUES
('A_005','Sketch','Realistic'),
('E_006','Text', 'Written'),
('E_010','Wallpaper', 'Pattern'),
('P_017','Textile', 'Pattern'),
('P_019','Diptych Sheet', 'Realistic');


# PERMANENT_COLLECTION
DROP TABLE IF EXISTS PERMANENT_COLLECTION;
CREATE TABLE PERMANENT_COLLECTION (
	ID_Num			varchar(30) not null,
	Date_Acquired			varchar(20),
	Status			varchar(10),
	Cost			integer,
	primary key (ID_Num),
	foreign key (ID_Num) references ART_OBJECT(ID_Num) ON DELETE CASCADE
);

INSERT INTO PERMANENT_COLLECTION (ID_Num, Date_Acquired, Status, Cost)
VALUES
('A_001',null,'On Display',null),
('A_002',null,'On Display',null),
('A_003',null,'On Display',null),
('A_004',null,'On Display',null),
('A_005',null,'On Display',null),
('E_006',null,'On Display',null),
('E_007',null,'On Display',null),
('E_008',null,'On Display',null),
('E_009',null,'On Display',null),
('E_010',null,'On Display',null),
('P_011',null,'On Display',null),
('P_012',null,'On Display',null),
('P_013',null,'On Display',null),
('P_014',null,'On Display',null),
('P_015',null,'On Display',null);


# COLLECTION
DROP TABLE IF EXISTS COLLECTION;
CREATE TABLE COLLECTION (
	Name			varchar(100)	not null,
	Type		varchar(10),
	Description			mediumtext,
	Address				varchar(75),
	Phone				varchar(25),
	Contact_Person		varchar(50),
	primary key (Name)
);

INSERT INTO COLLECTION(Name, Type, Description, Address, Phone, Contact_Person)
VALUES
('The Met Fifth Avenue','Museum','The Metropolitan Museum of Art collects, studies, conserves, and presents significant works of art across time and cultures in order to connect all people to creativity, knowledge, ideas, and one another.','1000 Fifth Avenue, New York, NY, 10028','212-535-7710',null),
('France','Country','Owned by the country.', null,null,null),
('National Museums Recovery','Recovery','A French state organization that manages the looted artworks recovered from Nazi Germany and returned to France after the Second World War.', null, null,null);


# BORROWED
DROP TABLE IF EXISTS BORROWED;
CREATE TABLE BORROWED (
	ID_Num			varchar(15)	not null,
	Collection		varchar(100),
	Date_Borrowed		varchar(20),
	Date_Returned		varchar(20),
	primary key (ID_Num),
	foreign key (ID_Num) references ART_OBJECT(ID_Num) ON DELETE CASCADE,
	foreign key (Collection) references COLLECTION(Name) ON DELETE CASCADE
);

INSERT INTO BORROWED (ID_Num, Collection, Date_Borrowed, Date_Returned)
VALUES
('P_016','National Museums Recovery','1950', null),
('P_017','National Museums Recovery','1951', null),
('P_018','National Museums Recovery','1999', null),
('P_019','France','1899', null),
('P_020','France','1951', null),
('P_021','France','March 28, 1911', null);

#Users
-- Drop and create roles
DROP ROLE IF EXISTS db_admin@localhost, read_access@localhost, employee@localhost;
CREATE ROLE db_admin@localhost, read_access@localhost, employee@localhost;

-- Grant privileges
GRANT ALL PRIVILEGES ON ART_MUSEUM.* TO db_admin@localhost;
GRANT SELECT ON ART_MUSEUM.* TO read_access@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON ART_MUSEUM.* TO employee@localhost;

-- Drop and create users
DROP USER IF EXISTS test_admin@localhost, guest@localhost, test_employee@localhost;

CREATE USER test_admin@localhost IDENTIFIED WITH mysql_native_password BY 'Qwerty2003';
GRANT db_admin@localhost TO test_admin@localhost;
SET DEFAULT ROLE ALL TO test_admin@localhost;

CREATE USER test_employee@localhost IDENTIFIED WITH mysql_native_password BY 'Qwerty2003';
GRANT employee@localhost TO test_employee@localhost;
SET DEFAULT ROLE ALL TO test_employee@localhost;

CREATE USER guest@localhost;
GRANT read_access@localhost TO guest@localhost;
SET DEFAULT ROLE ALL TO guest@localhost;
