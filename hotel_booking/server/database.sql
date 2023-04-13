-- A Database for a Hotel booking service
CREATE DATABASE reservio;

-- Create table commands

CREATE TABLE hotelChain (
    ID SERIAL,
    name VARCHAR(255) NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    province_or_state VARCHAR(255) NOT NULL,
    Postal_code_or_zip_code VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    number_of_hotels INT NOT NULL DEFAULT 0,
    PRIMARY KEY (ID)
);
CREATE TABLE emailAddress (
    hotelChainID INT NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    PRIMARY KEY (hotelChainID, email_Address),
    FOREIGN KEY (hotelChainID) REFERENCES hotelChain(ID) ON DELETE CASCADE
);
CREATE TABLE hotelChainPhoneNumber (
    hotelChainID INT NOT NULL,
    phoneNumber VARCHAR(255) NOT NULL,
    PRIMARY KEY (hotelChainID, phoneNumber),
    FOREIGN KEY (hotelChainID) REFERENCES hotelChain(ID) ON DELETE CASCADE
);
CREATE TABLE hotel (
    ID SERIAL,
    category INT NOT NULL CHECK (category >=1 AND category <=5),
    number_of_rooms INT NOT NULL DEFAULT 0,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    province_or_state VARCHAR(255) NOT NULL,
    Postal_code_or_zip_code VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    hotel_chain_id INT NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (hotel_chain_id) REFERENCES hotelChain(ID) ON DELETE CASCADE
);



CREATE TABLE hotelPhoneNumber (
    hotel_id INT NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL,
    PRIMARY KEY (hotel_id),
    FOREIGN KEY (hotel_id) REFERENCES hotel(id) ON DELETE CASCADE
);
CREATE TABLE employee (
    ID SERIAL NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    province_or_state VARCHAR(255) NOT NULL,
    Postal_code_zip_code VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    SSN_SIN INT NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    passwrd VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    hotel_id INT NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (hotel_id) REFERENCES hotel(ID) ON DELETE CASCADE
);


CREATE TABLE Admin (
    id SERIAL NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    passwrd VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE manages (
    employee_id SERIAL NOT NULL,
    mgr_id INT NOT NULL,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (mgr_id) REFERENCES employee(id) ON DELETE CASCADE
);
CREATE TABLE room (
    room_number INT NOT NULL,
    price INT NOT NULL,
    capacity VARCHAR(255) NOT NULL CHECK (LOWER(capacity) IN ('single', 'double', 'queen', 'king')), --add more
    View VARCHAR(255) NOT NULL CHECK(LOWER(View) IN ('sea', 'mountain')),
    Extended BOOLEAN NOT NULL,
    Problems BOOLEAN NOT NULL,
    hotel_id INT NOT NULL,
    PRIMARY KEY (room_number, hotel_id),
    FOREIGN KEY (hotel_id) REFERENCES hotel(ID) ON DELETE CASCADE
);

CREATE TABLE amenity (
    room_number INT NOT NULL,
    hotel_id INT NOT NULL,
    amenity VARCHAR(255) not NULL,
    PRIMARY KEY (room_number, hotel_id, amenity),
    FOREIGN KEY (room_number, hotel_id) REFERENCES room ON DELETE CASCADE
);

CREATE TABLE customer (
    ID SERIAL,
    full_name VARCHAR(255) NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    province_or_state VARCHAR(255) NOT NULL,
    Postal_code_zip_code VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    SSN_SIN INT NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    passwrd VARCHAR(255) NOT NULL,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (id)
);
CREATE TABLE booking(
    booking_id SERIAL,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    hotel_id INT NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    booking_date DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (booking_id),
    FOREIGN KEY (customer_id) REFERENCES customer(ID) ON DELETE CASCADE,
    FOREIGN KEY (room_id, hotel_id) REFERENCES room(room_number, hotel_id) ON DELETE CASCADE
);
CREATE TABLE renting (
    renting_id SERIAL NOT NULL,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    room_id INT NOT NULL,
    hotel_id INT NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    paid_for BOOLEAN NOT NULL,
    booking_id INT,
    renting_date DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (renting_id),
    FOREIGN KEY (employee_id) REFERENCES employee(ID) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customer(ID) ON DELETE CASCADE,
    FOREIGN KEY (room_id, hotel_id) REFERENCES room(room_number, hotel_id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES booking ON DELETE CASCADE
);
CREATE TABLE booking_archive(
    booking_id INT NOT NULL,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    hotel_id INT NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    booking_date DATE NOT NULL,
    PRIMARY KEY (booking_id)
);

CREATE TABLE renting_archive (
    renting_id INT NOT NULL,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    room_id INT NOT NULL,
    hotel_id INT NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    renting_date DATE NOT NULL,
    paid_for BOOLEAN NOT NULL,
    booking_id INT,
    PRIMARY KEY (renting_id)
);


---------------------Hotels Page Specific Test Insertions ------------------------------------
-- INSERT INTO room (room_number, price, capacity, View, Extended, Problems, hotel_id)
-- VALUES (101, 100, 'single', 'sea', true, false, 1);

-- INSERT INTO room (room_number, price, capacity, View, Extended, Problems, hotel_id)
-- VALUES (102, 150, 'double', 'mountain', true, false, 1);

-- INSERT INTO room (room_number, price, capacity, View, Extended, Problems, hotel_id)
-- VALUES (201, 200, 'queen', 'sea', true, false, 2);

-- INSERT INTO room (room_number, price, capacity, View, Extended, Problems, hotel_id)
-- VALUES (202, 250, 'king', 'mountain', true, false, 2);

-- INSERT INTO room (room_number, price, capacity, View, Extended, Problems, hotel_id)
-- VALUES (203, 250, 'king', 'sea', true, false, 2);

-- INSERT INTO room (room_number, price, capacity, View, Extended, Problems, hotel_id)
-- VALUES (204, 100, 'single', 'mountain', true, false, 2);

-- INSERT INTO room (room_number, price, capacity, View, Extended, Problems, hotel_id)
-- VALUES (205, 200, 'queen', 'sea', true, false, 2);

-- INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (201, 2, 'Wifi');

-- INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (203, 2, 'Free Breakfast');

-- INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (205, 2, 'Pool');

-- INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (205, 2, 'Free Breakfast');

-- INSERT INTO booking (customer_id, room_id, hotel_id, checkin_date, checkout_date)
-- VALUES (1, 101, 1, '2023-04-05', '2023-04-10');

-- INSERT INTO booking (customer_id, room_id, hotel_id, checkin_date, checkout_date)
-- VALUES (2, 201, 2, '2023-05-01', '2023-05-06');




-- -------------------------------VIEWS-----------------------------------------------------
CREATE VIEW ROOM_LOC_VIEW AS
SELECT id, number_of_rooms, city, country
FROM hotel;

CREATE VIEW hotel_room_count AS
SELECT hotel_id, COUNT(*) AS total_rooms
FROM room
GROUP BY hotel_id;

-- -------------------------------INDEX-----------------------------------------------------

CREATE INDEX hotel_ad_idx on hotel(city, country);
CREATE INDEX customer_email_password on customer(email, passwrd);
CREATE INDEX employee_email_password on employee(email, passwrd);
CREATE INDEX hotelchain_ad_idx on hotelChain(name);

-- -----------------------------------------------------Hotel chains------------------------

INSERT INTO hotelchain (id, name, street_address, city, province_or_state, Postal_code_or_zip_code, country) 
VALUES (1, 'Mariot inn', '123 road', 'Ottawa', 'ON', 'K1J AX6', 'canada');
INSERT INTO hotelchain (id, name, street_address, city, province_or_state, Postal_code_or_zip_code, country)
VALUES (2, 'Hilton', '123 road', 'New york City', 'NY', '60000', 'United States of America');
INSERT INTO hotelchain (id, name, street_address, city, province_or_state, Postal_code_or_zip_code, country)
VALUES (3, 'Business Inn', '123 road', 'Los Angeles', 'CA', '60000', 'United States of America');
INSERT INTO hotelchain (id, name, street_address, city, province_or_state, Postal_code_or_zip_code, country)
VALUES (4, 'Accor ', '123 road', 'Chicago', 'NY', '60000', 'United States of America');
INSERT INTO hotelchain (id, name, street_address, city, province_or_state, Postal_code_or_zip_code, country)
VALUES (5, 'Hyatt Hotels and Resorts', '123 road', 'Vancouver', 'BC', '60000', 'United States of America');
INSERT INTO hotelchain (id, name, street_address, city, province_or_state, Postal_code_or_zip_code, country)
VALUES (6, 'Four Seasons Hotels and Resorts', '123 road', 'Montreal', 'QC', '60000', 'United States of America');
INSERT INTO hotelchain (id, name, street_address, city, province_or_state, Postal_code_or_zip_code, country)
VALUES (7, 'Wyndham Hotels and Resorts', '123 road', 'Denver', 'CO', '60000', 'United States of America');



-- ------------------------------Hotels---------------------------------------
INSERT INTO hotel (id, category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id)
 VALUES(1, 3, '123 one rd', 'Ottawa', 'ON', 'A1X 5K1', 'Canada', 'a@ex.com', 1);

INSERT INTO hotel (id, category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) 
VALUES(2, 3,'123 one rd', 'Ottawa', 'ON', 'A1X 5K7', 'Canada', 'a2@ex.com', 1);

INSERT INTO hotel(id, category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) 
VALUES(3, 4,'1234 two rd', 'Ottawa', 'ON', 'A1X 5KX', 'Canada', 'a3@ex.com', 1);

INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) 
VALUES(4, 5,'143 two rd', 'Vancouver', 'BC', 'A1X 5KX', 'Canada', 'a3@ex.com', 1);

INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) 
VALUES(5, 5,'123 central rd', 'Austin', 'TX', '66544', 'United States of America', 'a4@ex.com', 1);

INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) 
VALUES(6, 5, '123 st louis rd', 'Houston', 'TX', '465652', 'United States of America', 'a5@ex.com', 1);

INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code, country, contact_email, hotel_chain_id) 
VALUES(7, 3, '123 btoadway', 'New York City', 'NY', '45646', 'United States of America', 'a6@ex.com', 1);

INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code, country, contact_email, hotel_chain_id)
 VALUES(8, 2, '123 town rd', 'Vancouver', 'BC', 'H1J 5KX', 'Canada', 'a7@ex.com', 1);




INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(9, 3, '123 celine rd', 'New york City', 'NY', '50000', 'United States of America', 'b1@ex.com', 2);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(10, 3, '123 joyce rd', 'Boulder', 'CO', '10000', 'United States of America', 'b2@ex.com', 2);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(11, 2, '123 candy rd', 'Los Angeles', 'CA', '21200', 'United States of America', 'b3@ex.com', 2);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(12, 5, '123 Makepe', 'New york City', 'NY', '77777', 'United States of America', 'b4@ex.com', 2);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(13, 2, '123 Joy', 'Cleveland', 'OH', '54411', 'United States of America', 'b5@ex.com', 2);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(14, 1, '123 Hurdman', 'Vancouver', 'BC', 'T1X 5K4', 'Canada', 'b6@ex.com', 2);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(15, 4, '123 Lyon', 'Montreal', 'QC', 'L1X 5K4', 'Canada', 'b7@ex.com', 2);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(16, 4, '123 st Germain', 'Quebec City', 'QC', 'M1X 5K4', 'Canada', 'b8@ex.com', 2);

INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(17, 3, '123 paris rd', 'Ottawa', 'ON', 'C1V 5K4', 'Canada', 'c@ex.com', 3);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(18, 3, '123 london rd', 'Toronto', 'ON', 'M1X 5K4', 'Canada', 'c2@ex.com', 3);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(19, 4, '123 boyca rd', 'Vancouver', 'BC', 'J1X 5K4', 'Canada', 'c3@ex.com', 3);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(20, 5, '123 douala rd', 'Vancouver', 'BC', 'N1X 4K4', 'Canada', 'c4@ex.com', 3);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(21, 1, '123 Dakar rd', 'Montreal', 'QC', 'V1V 4K1', 'Canada', 'c5@ex.com', 3);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(22, 2, '123 Huffman rd', 'Toronto', 'ON', 'J1Y 5K7', 'Canada', 'c6@ex.com', 3);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(23, 2, '123 Puffy rd', 'Toronto', 'ON', 'U1X 1KX', 'Canada', 'c7@ex.com', 3);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(24, 2, '123 corny rd', 'Vancouver', 'BC', 'A1T 5K3', 'Canada', 'c8@ex.com', 3);

INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(25, 3, '123 July rd', 'Ottawa', 'ON', 'X1X 5K9', 'Canada', 'd@ex.com', 4);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(26, 4, '123 August rd', 'Toronto', 'ON', 'Z1X 7K8', 'Canada', 'd2@ex.com', 4);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(27, 5, '123 jane rd', 'Vancouver', 'BC', 'N1X 5K4', 'Canada', 'd3@ex.com', 4);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(28, 5, '123 korea rd', 'Vancouver', 'BC', 'J1X 5K5', 'Canada', 'd4@ex.com', 4);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(29, 5, '123 witness rd', 'Montreal', 'QC', 'B1X 5K1', 'Canada', 'd5@ex.com', 4);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(30, 5, '123 ford rd', 'Indianapolis', 'IN', '14666', 'United States of America', 'd6@ex.com', 4);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(31, 2, '123 Levesque rd', 'Los Angeles', 'CA', '11722', 'United States of America', 'd7@ex.com', 4);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(32, 2, '123 Jackson rd', 'Sacramento', 'CA', '56912', 'United States of America', 'd8@ex.com', 4);

INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(33, 3, '123 Kanye rd', 'Chicago', 'IL', '22000', 'United States of America', 'e@ex.com', 5);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(34, 4, '123 Common rd', 'Toronto', 'ON', 'A1X 5K7', 'Canada', 'e2@ex.com', 5);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(35, 5, '123 street', 'Vancouver', 'BC', 'S1X 5KX', 'Canada', 'e3@ex.com', 5);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(36, 5, '123 other street', 'Vancouver', 'BC', 'C1X 5K1', 'Canada', 'e4@ex.com', 5);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(37, 2, '123 boomer rd', 'Ottawa', 'ON', 'A1X 5K1', 'Canada', 'e5@ex.com', 5);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(38, 2, '123 genz rd', 'New York City', 'NY', '78200', 'United States of America', 'e6@ex.com', 5);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(39, 2, '123 select ', 'Minnesota', 'WI', '54312', 'United States of America', 'e7@ex.com', 5);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(40, 2, '123 miles rd', 'Vancouver', 'ON', '54545', 'United States of America', 'e8@ex.com', 5);

INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(41, 3, '123 john st', 'Ottawa', 'ON', 'G1G 5K1', 'Canada', 'f@ex.com', 6);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(42, 4, '123 igor st', 'Toronto', 'ON', 'K1G 5K7', 'Canada', 'f2@ex.com', 6);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(43, 5, '123 main rd', 'Vancouver', 'BC', 'V1X 5K4', 'Canada', 'f3@ex.com', 6);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(44, 1, '123 two rd', 'Vancouver', 'BC', 'V1X 5K4', 'Canada', 'f4@ex.com', 6);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(45, 1, '123 thre rd', 'Ottawa', 'ON', 'A1X 5K1', 'Canada', 'f5@ex.com', 6);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(46, 2, '123 four rd', 'New York City', 'NY', '12521', 'United States of America', 'f6@ex.com', 6);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(47, 2, '123 five rd', 'New York City', 'NY', '96122', 'United States of America', 'f7@ex.com', 6);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(48, 2, '123 six rd', 'New York City', 'NY', '41515', 'United States of America', 'f8@ex.com', 6);

INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(49, 3, '123 seven rd', 'Ottawa', 'ON', 'K1X 5K1', 'Canada', 'g@ex.com', 7);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(50, 4, '123 kenny rd', 'Toronto', 'ON', 'J1X 5K4', 'Canada', 'g2@ex.com', 7);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(51, 5, '123 Lebum rd', 'Vancouver', 'BC', 'Y1X 5K7', 'Canada', 'g3@ex.com', 7);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(52, 5, '123 LeMickey rd', 'Vancouver', 'BC', 'J1X 7K9', 'Canada', 'g4@ex.com', 7);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(53, 4, '123 LeDisney rd', 'Ottawa', 'ON', 'N1X 5K8', 'Canada', 'g5@ex.com', 7);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(54, 4, '123 Le46 rd', 'Chicago', 'IL', '23233', 'United States of America', 'g6@ex.com', 7);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(55, 4, '123 Pessi rd', 'New York City', 'NY', '44545', 'United States of America', 'g7@ex.com', 7);
INSERT INTO hotel(id,category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(56, 4, '123 Penaldo rd', 'Saint Louis', 'CA', '11212', 'United States of America', 'g8@ex.com', 7);

-- -----------------------------------------Rooms -----------------------------------------------------
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', TRUE, TRUE, 1);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 140, 'double', 'sea', TRUE, TRUE, 1);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 160, 'queen', 'mountain', TRUE, TRUE, 1);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 180, 'king', 'mountain', TRUE, TRUE, 1);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', TRUE, TRUE, 2);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 140, 'double', 'sea', TRUE, TRUE, 2);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 160, 'queen', 'mountain', FALSE, TRUE, 2);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 180, 'king', 'mountain', TRUE, FALSE, 2);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', TRUE, TRUE, 3);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 120, 'double', 'sea', TRUE, FALSE, 3);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 220, 'queen', 'mountain', TRUE, TRUE, 3);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 190, 'king', 'mountain', FALSE, TRUE, 3);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', TRUE, TRUE, 4);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 120, 'double', 'sea', FALSE, TRUE, 4);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'sea', TRUE, TRUE, 4);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 500, 'queen', 'sea', TRUE, FALSE, 4);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 180, 'single', 'sea', FALSE, FALSE, 5);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 210, 'single', 'sea', TRUE, TRUE, 5);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 220, 'double', 'mountain', TRUE, FALSE, 5);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 240, 'double', 'mountain', TRUE, TRUE, 5);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 320, 'king', 'mountain', FALSE, FALSE, 6);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 420, 'king', 'mountain', FALSE, FALSE, 6);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 620, 'king', 'mountain', FALSE, FALSE, 6);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 720, 'king', 'mountain', FALSE, FALSE, 6);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 220, 'single', 'mountain', FALSE, FALSE, 7);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 320, 'queen', 'mountain', FALSE, FALSE, 7);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 420, 'queen', 'mountain', FALSE, TRUE, 7);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 520, 'king', 'sea', TRUE, FALSE, 7);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 90, 'single', 'sea', TRUE, TRUE, 8);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 120, 'single', 'sea', TRUE, FALSE, 8);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 130, 'king', 'sea', FALSE, FALSE, 8);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 140, 'king', 'sea', TRUE, TRUE, 8);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', FALSE, FALSE, 9);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 140, 'single', 'mountain', FALSE, FALSE, 9);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 145, 'king', 'mountain', TRUE, TRUE, 9);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 170, 'king', 'sea', TRUE, TRUE, 9);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 112, 'single', 'sea', FALSE, FALSE, 10);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 121, 'single', 'mountain', FALSE, FALSE, 10);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 220, 'king', 'sea', FALSE, TRUE, 10);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 230, 'king', 'sea', TRUE, TRUE, 10);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', TRUE, TRUE, 11);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 140, 'single', 'sea', FALSE, TRUE, 11);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 165, 'king', 'mountain', TRUE, TRUE, 11);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 175, 'king', 'mountain', TRUE, FALSE, 11);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', FALSE, TRUE, 12);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 140, 'double', 'sea', TRUE, TRUE, 12);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 145, 'double', 'sea', FALSE, FALSE, 12);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 246, 'queen', 'mountain', FALSE, TRUE, 12);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 90, 'single', 'sea', TRUE, FALSE, 13);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 120, 'single', 'sea', FALSE, FALSE, 13);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 210, 'Queen', 'mountain', TRUE, TRUE, 13);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 250, 'Queen', 'mountain', TRUE, FALSE, 13);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 210, 'single', 'mountain', FALSE, TRUE, 14);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 230, 'double', 'sea', TRUE, FALSE, 14);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 250, 'Queen', 'sea', FALSE, TRUE, 14);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 270, 'Queen', 'sea', TRUE, TRUE, 14);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 200, 'single', 'sea', TRUE, FALSE, 15);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 250, 'double', 'sea', FALSE, TRUE, 15);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 270, 'double', 'sea', TRUE, FALSE, 15);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 290, 'king', 'sea', TRUE, TRUE, 15);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'double', 'sea', TRUE, FALSE, 16);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 150, 'double', 'mountain', FALSE, FALSE, 16);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 160, 'queen', 'mountain', TRUE, FALSE, 16);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 170, 'king', 'mountain', TRUE, TRUE, 16);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 180, 'double', 'sea', TRUE, TRUE, 17);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 210, 'single', 'sea', TRUE, TRUE, 17);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 240, 'queen', 'sea', FALSE, FALSE, 17);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 260, 'king', 'mountain', FALSE, TRUE, 17);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 200, 'single', 'mountain', TRUE, TRUE, 18);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 220, 'single', 'mountain', TRUE, FALSE, 18);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 230, 'king', 'sea', FALSE, FALSE, 18);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 240, 'king', 'sea', FALSE, TRUE, 18);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'double', 'sea', TRUE, TRUE, 19);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 150, 'double', 'sea', FALSE, FALSE, 19);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 170, 'king', 'mountain', FALSE, FALSE, 19);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 180, 'king', 'mountain', TRUE, TRUE, 19);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', TRUE, TRUE, 20);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 130, 'double', 'sea', TRUE, FALSE, 20);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 150, 'king', 'mountain', FALSE, FALSE, 20);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 190, 'king', 'mountain', TRUE, TRUE, 20);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 80, 'single', 'mountain', TRUE, TRUE, 21);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 90, 'double', 'mountain', TRUE, FALSE, 21);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 100, 'queen', 'sea', FALSE, FALSE, 21);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'Queen', 'sea', FALSE, TRUE, 21);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', FALSE, TRUE, 22);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 130, 'Double', 'sea', FALSE, FALSE, 22);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 140, 'Queen', 'mountain', FALSE, FALSE, 22);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 160, 'king', 'mountain', FALSE, TRUE, 22);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 170, 'single', 'sea', TRUE, TRUE, 23);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 180, 'double', 'sea', FALSE, FALSE, 23);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 190, 'king', 'mountain', FALSE, TRUE, 23);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 220, 'king', 'mountain', TRUE, TRUE, 23);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 210, 'single', 'mountain', TRUE, TRUE, 24);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 230, 'double', 'sea', FALSE, FALSE, 24);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 240, 'Queen', 'sea', FALSE, TRUE, 24);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 270, 'Queen', 'mountain', TRUE, TRUE, 24);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 200, 'single', 'mountain', TRUE, TRUE, 25);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 230, 'double', 'mountain', FALSE, FALSE, 25);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 250, 'queen', 'sea', FALSE, TRUE, 25);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 270, 'king', 'sea', TRUE, TRUE, 25);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 150, 'single', 'sea', TRUE, TRUE, 26);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 180, 'double', 'sea', TRUE, FALSE, 26);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 190, 'queen', 'sea', FALSE, FALSE, 26);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 210, 'king', 'sea', TRUE, TRUE, 26);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', TRUE, TRUE, 27);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 130, 'Double', 'sea', FALSE, FALSE, 27);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 140, 'Double', 'mountain', FALSE, TRUE, 27);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'mountain', TRUE, TRUE, 27);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', TRUE, TRUE, 28);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 130, 'double', 'sea', FALSE, FALSE, 28);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 140, 'Queen', 'sea', FALSE, TRUE, 28);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'queen', 'mountain', TRUE, TRUE, 28);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 210, 'single', 'sea', TRUE, TRUE, 29);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 220, 'double', 'sea', TRUE, FALSE, 29);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 230, 'Queen', 'sea', FALSE, FALSE, 29);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 250, 'king', 'sea', FALSE, TRUE, 29);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 90, 'double', 'sea', TRUE, TRUE, 30);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 120, 'Double', 'mountain', TRUE, FALSE, 30);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 130, 'double', 'mountain', FALSE, FALSE, 30);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 134, 'king', 'sea', TRUE, TRUE, 30);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 111, 'single', 'sea', TRUE, TRUE, 31);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 171, 'double', 'sea', FALSE, FALSE, 31);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 189, 'Queen', 'mountain', FALSE, TRUE, 31);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 221, 'king', 'mountain', TRUE, TRUE, 31);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', TRUE, TRUE, 32);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 130, 'double', 'sea', FALSE, FALSE, 32);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 140, 'queen', 'mountain', FALSE, TRUE, 32);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'mountain', TRUE, TRUE, 32);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 160, 'single', 'sea', TRUE, TRUE, 33);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 170, 'double', 'sea', FALSE, FALSE, 33);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 180, 'queen', 'mountain', FALSE, TRUE, 33);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 190, 'king', 'mountain', TRUE, TRUE, 33);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 220, 'single', 'mountain', TRUE, FALSE, 34);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 230, 'double', 'sea', FALSE, TRUE, 34);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 240, 'queen', 'mountain', TRUE, TRUE, 34);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 250, 'king', 'mountain', TRUE, TRUE, 34);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 260, 'single', 'sea', TRUE, TRUE, 35);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 270, 'double', 'sea', FALSE, FALSE, 35);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 280, 'queen', 'mountain', TRUE, TRUE, 35);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 290, 'king', 'mountain', TRUE, TRUE, 35);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', FALSE, FALSE, 36);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 170, 'Double', 'sea', FALSE, TRUE, 36);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 220, 'queen', 'mountain', TRUE, TRUE, 36);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 240, 'king', 'mountain', TRUE, TRUE, 36);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', TRUE, TRUE, 37);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 130, 'double', 'sea', TRUE, FALSE, 37);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 140, 'queen', 'mountain', FALSE, TRUE, 37);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'mountain', TRUE, FALSE, 37);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 120, 'single', 'sea', FALSE, FALSE, 38);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 180, 'double', 'sea', FALSE, TRUE, 38);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 200, 'queen', 'mountain', TRUE, FALSE, 38);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 210, 'king', 'mountain', FALSE, FALSE, 38);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 140, 'single', 'sea', FALSE, FALSE, 39);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 150, 'double', 'mountain', FALSE, FALSE, 39);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 170, 'queen', 'mountain', FALSE, FALSE, 39);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 180, 'king', 'mountain', FALSE, FALSE, 39);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 190, 'single', 'mountain', FALSE, FALSE, 40);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 220, 'Double', 'mountain', FALSE, FALSE, 40);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 250, 'queen', 'mountain', FALSE, FALSE, 40);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 270, 'king', 'mountain', FALSE, FALSE, 40);


INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 290, 'single', 'sea', TRUE, FALSE, 41);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 310, 'double', 'sea', FALSE, FALSE, 41);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 350, 'queen', 'sea', TRUE, FALSE, 41);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 380, 'king', 'mountain', FALSE, FALSE, 41);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 70, 'single', 'mountain', FALSE, FALSE, 42);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 100, 'Double', 'mountain', FALSE, TRUE, 42);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'mountain', FALSE, FALSE, 42);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'sea', TRUE, FALSE, 42);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 290, 'single', 'sea', TRUE, FALSE, 43);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 310, 'double', 'sea', FALSE, FALSE, 43);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 350, 'queen', 'sea', TRUE, FALSE, 43);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 380, 'king', 'mountain', FALSE, FALSE, 43);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 70, 'single', 'mountain', FALSE, FALSE, 44);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 100, 'Double', 'mountain', FALSE, TRUE, 44);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'mountain', FALSE, FALSE, 44);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'sea', TRUE, FALSE, 44);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 290, 'single', 'sea', TRUE, FALSE, 45);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 310, 'double', 'sea', FALSE, FALSE, 45);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 350, 'queen', 'sea', TRUE, FALSE, 45);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 380, 'king', 'mountain', FALSE, FALSE, 45);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 70, 'single', 'mountain', FALSE, FALSE, 46);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 100, 'Double', 'mountain', FALSE, TRUE, 46);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'mountain', FALSE, FALSE, 46);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'sea', TRUE, FALSE, 46);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 290, 'single', 'sea', TRUE, FALSE, 47);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 310, 'double', 'sea', FALSE, FALSE, 47);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 350, 'queen', 'sea', TRUE, FALSE, 47);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 380, 'king', 'mountain', FALSE, FALSE, 47);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 70, 'single', 'mountain', FALSE, FALSE, 48);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 100, 'Double', 'mountain', FALSE, TRUE, 48);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'mountain', FALSE, FALSE, 48);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'sea', TRUE, FALSE, 48);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 290, 'single', 'sea', TRUE, FALSE, 49);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 310, 'double', 'sea', FALSE, FALSE, 49);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 350, 'queen', 'sea', TRUE, FALSE, 49);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 380, 'king', 'mountain', FALSE, FALSE, 49);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 70, 'single', 'mountain', FALSE, FALSE, 50);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 100, 'Double', 'mountain', FALSE, TRUE, 50);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'mountain', FALSE, FALSE, 50);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'sea', TRUE, FALSE, 50);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 70, 'single', 'mountain', FALSE, FALSE, 51);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 100, 'Double', 'mountain', FALSE, TRUE, 51);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'sea', FALSE, FALSE, 51);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'sea', TRUE, FALSE, 51);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 70, 'single', 'mountain', FALSE, FALSE, 52);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 100, 'Double', 'mountain', FALSE, TRUE, 52);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'mountain', FALSE, FALSE, 52);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'sea', TRUE, FALSE, 52);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 70, 'single', 'mountain', FALSE, FALSE, 53);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 100, 'Double', 'sea', FALSE, TRUE, 53);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'mountain', FALSE, FALSE, 53);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'sea', TRUE, FALSE, 53);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 70, 'single', 'mountain', FALSE, FALSE, 54);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 100, 'Double', 'mountain', FALSE, TRUE, 54);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'mountain', FALSE, FALSE, 54);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'sea', TRUE, FALSE, 54);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 70, 'single', 'sea', FALSE, FALSE, 55);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 100, 'Double', 'mountain', FALSE, TRUE, 55);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 120, 'queen', 'mountain', FALSE, FALSE, 55);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 150, 'king', 'sea', TRUE, FALSE, 55);

INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (1, 100, 'single', 'mountain', FALSE, FALSE, 56);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (2, 150, 'Double', 'sea', FALSE, TRUE, 56);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (3, 180, 'queen', 'mountain', FALSE, FALSE, 56);
INSERT INTO room (room_number,price,capacity,View, Extended, Problems, hotel_id) VALUES (4, 200, 'king', 'sea', TRUE, FALSE, 56);


-- ----------------------------Customers ---------------------------------
INSERT INTO customer(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, registration_date) 
VALUES (1, 'Ralph', '123 ex st', 'Ottawa', 'ON', 'K1J 5N2', 'Canada', '1102345646', 'ralph@ex.com', 'pompei', '2023-03-20');

-- --------------Employees---------------------------------------------
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (1, 'Tom', '123 ex st', 'Ottawa', 'ON', 'K1J 5N2', 'Canada', '15415112', 'tom@ex.com', 'pompei', 'receptionist', 1);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (2, 'Jennifer', '456 Main St', 'Toronto', 'ON', 'M5V 3K6', 'Canada', '963258741', 'jennifer@ex.com', '4tBk8sZr', 'receptionist', 2);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (3, 'John', '123 ex st', 'Ottawa', 'ON', 'K1J 5N2', 'Canada', '780452619', 'john@ex.com', 'u5Xn3vLq', 'receptionist', 3);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (4, 'Emily', '789 Elm St', 'Vancouver', 'BC', 'V6B 5J5', 'Canada', '214365870', 'emily@ex.com', '7mCp6hFy', 'receptionist', 4);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (5, 'Peter', '789 Street St', 'Montreal', 'QC', 'V6B 5P5', 'Canada', '679083542', 'peter@ex.com', 'a8Rt5gVb', 'receptionist', 5);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (6, 'Mark', '789 Maple St', 'Vancouver', 'BC', 'V7B 5J5', 'Canada', '509328716', 'mark@ex.com', '6yLp9kHj', 'receptionist', 6);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (7, 'Rachel', '123 Pine St', 'Toronto', 'ON', 'I9I 9I9', 'Canada', '893721456', 'rachel@ex.com', 's2Zc7bNx', 'receptionist', 7);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (8, 'Kevin', '456 Birch St', 'Montreal', 'QC', 'J0J 0J0', 'Canada', '201958637', 'kevin@ex.com', '5tVr2mBq', 'receptionist', 8);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (9, 'Julia', '789 Oak St', 'Vancouver', 'BC', 'K1K 1K1', 'Canada', '368507914', 'julia@ex.com', 'b3Df8kNp', 'receptionist', 9);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (10, 'Bryan', '123 Elm St', 'Toronto', 'ON', 'L2L 2L2', 'Canada', '927416385', 'bryan@ex.com', 'h7Gn5tRm', 'receptionist', 10);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (11, 'Sophia', '456 Oak St', 'Montreal', 'QC', 'M3M 3M3', 'Canada', '684209531', 'sophia@ex.com', 'j9Hb6xPc', 'receptionist', 11);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (12, 'Jacob', '789 Cedar St', 'Vancouver', 'BC', 'N4N 4N4', 'Canada', '741369825', 'jacob@ex.com', 'k8Jf5dVt', 'receptionist', 12);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (13, 'Sarah', '122 King St', 'Winnipeg', 'MB', 'O5O 5O5', 'Canada', '543870296', 'sarah@ex.com', 'r6Yg7bNc', 'receptionist', 13);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (14, 'Jake', '456 Bay St', 'Victoria', 'BC', 'P6P 6P6', 'Canada', '150987263', 'jake@ex.com', 'w9Lp4kTj', 'receptionist', 14);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (15, 'Amy', '890 Yonge St', 'Calgary', 'AB', 'Q7Q 7Q7', 'Canada', '236489571', 'amy@ex.com', '2nGd7sKf', 'receptionist', 15);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (16, 'David', '567 Queen St', 'Halifax', 'NS', 'R8R 8R8', 'Canada', '419238765', 'david@ex.com', '4mBv8pLc', 'receptionist', 16);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (17, 'William', '123 King St', 'Halifax', 'NS', 'S9S 9S9', 'Canada', '567894123', 'william@ex.com', '1tRn9sMx', 'receptionist', 17);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (18, 'Noah', '2929 Dogwood Blvd', 'Toronto', 'ON', 'T0T 0T0', 'Canada', '693215487', 'noah@ex.com', '3yTm4nLw', 'receptionist', 18);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (19, 'Olivia', '4141 Juniper Blvd', 'Toronto', 'ON', 'U1U 1U1', 'Canada', '985674312', 'oli@ex.com', '8sBk9pHf', 'receptionist', 19);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (20, 'Chloe', '4545 Linden St', 'Ottawa', 'ON', 'V2V 2V2', 'Canada', '361904758', 'chloe@ex.com', '7vNc3xRj', 'receptionist', 20);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (21, 'Lily', '4747 Magnolia Ave', 'Vancouver', 'BC', 'W3W 3W3', 'Canada', '594836127', 'l@ex.com', '6hFb4tKq', 'receptionist', 21);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (22, 'Daniel', '4949 Oak Hill Rd', 'Montreal', 'QC', 'Y5Y 5Y5', 'Canada', '247810963', 'daniel@ex.com', '9jLm2gVx', 'receptionist', 22);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (23, 'George', '151 Piney Ln', 'Vancouver', 'BC', 'Z6Z 6Z6', 'Canada', '615729834', 'george@ex.com', '2dGc7nHf', 'receptionist', 23);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (24, 'Harper', '555 Redwood Blvd', 'Toronto', 'ON', 'A7A 7A7', 'Canada', '935076412', 'harper@ex.com', '1kRb8pMx', 'receptionist', 24);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (25, 'Lewis', '5959 Tulip Rd', 'Montreal', 'QC', 'B8B 8B8', 'Canada', '473162598', 'lewis@ex.com', '5tFm7vNc', 'receptionist', 25);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (26, 'Samuel', '161 Umbrella St', 'Vancouver', 'BC', 'C9C 9C9', 'Canada', '802693541', 'sam@ex.com', '3yHn6bLw', 'receptionist', 26);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (27, 'Isaac', '6363 Vine Ln', 'Toronto', 'ON', 'D0D 0D0', 'Canada', '647983215', 'isaac@ex.com', '4kPj9sRf', 'receptionist', 27);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (28, 'Taylor', '6767 Xylophone Rd', 'Montreal', 'QC', 'E1E 1E1', 'Canada', '289045176', 'taylor@ex.com', '7vNc3xRj', 'receptionist', 28);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (29, 'Cooper', '6969 Yellowbrick Blvd', 'Vancouver', 'BC', 'F2F 2F2', 'Canada', '731468529', 'cooper@ex.com', '9jLm2gVx', 'receptionist', 29);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (30, 'Scarlett', '7171 Zebra Dr', 'Winnipeg', 'MB', 'G3G 3G3', 'Canada', '452036891', 'scar@ex.com', '2dGc7nHf', 'receptionist', 29);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (31, 'Grace', '373 Alpha St', 'Victoria', 'BC', 'H4H 4H4', 'Canada', '397210846', 'grace@ex.com', '1kRb8pMx', 'receptionist', 30);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (32, 'Joshua', '7575 Bravo Ln', 'Calgary', 'AB', 'I5I 5I5', 'Canada', '549618723', 'joshua@ex.com', '5tFm7vNc', 'receptionist', 31);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (33, 'Victoria', '7777 Charlie Rd', 'Halifax', 'NS', 'J6J 6J6', 'Canada', '987123456', 'vic@ex.com', '3yHn6bLw', 'receptionist', 33);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (34, 'Alexander', '7979 Delta Ave', 'Halifax', 'NS', 'K7K 7K7', 'Canada', '631049287', 'alex@ex.com', '4kPj9sRf', 'receptionist', 34);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (35, 'Abigail', '8181 Echo Blvd', 'Toronto', 'ON', 'L8L 8L8', 'Canada', '805742691', 'abigail@ex.com', '2mBv8pLc', 'receptionist', 35);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (36, 'Amelia', '8383 Foxtrot Dr', 'Toronto', 'ON', 'M9M 9M9', 'Canada', '217930546', 'amelia@ex.com', '1tRn9sMx', 'receptionist', 36);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (37, 'Jackson', '8585 Golf Rd', 'Ottawa', 'ON', 'N0N 0N0', 'Canada', '839204715', 'jackson@ex.com', '3yTm4nLw', 'receptionist', 37);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (38, 'Thompson', '8787 Hotel St', 'Vancouver', 'BC', 'O1O 1O1', 'Canada', '156493728', 'thom@ex.com', '8sBk9pHf', 'receptionist', 38);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (39, 'Martin', '8989 India Ln', 'Montreal', 'QC', 'P2P 2P2', 'Canada', '569081432', 'martin@ex.com', '7vNc3xRj', 'receptionist', 39);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (40, 'Perez', '9191 Juliet Blvd', 'Vancouver', 'BC', 'Q3Q 3Q3', 'Canada', '481672935', 'perez@ex.com', '6hFb4tKq', 'receptionist', 40);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (41, 'Jones', '9393 Kilo Ave', 'Toronto', 'ON', 'R4R 4R4', 'Canada', '763258140', 'jo@ex.com', '9jLm2gVx', 'receptionist', 41);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (42, 'Ava', '9595 Lima Rd', 'Montreal', 'QC', 'S5S 5S5', 'Canada', '310257469', 'ava@ex.com', '2dGc7nHf', 'receptionist', 42);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (43, 'Ethan', '9797 Mike Dr', 'Vancouver', 'BC', 'T6T 6T6', 'Canada', '985037216', 'ethan@ex.com', '1kRb8pMx', 'receptionist', 43);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (44, 'Chen', '9999 November Blvd', 'Toronto', 'ON', 'U7U 7U7', 'Canada', '734026815', 'chen@ex.com', '5tFm7vNc', 'receptionist', 44);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (45, 'Wright', '1212 Oscar St', 'Montreal', 'QC', 'V8V 8V8', 'Canada', '129576483', 'wr@ex.com', '3yHn6bLw', 'receptionist', 45);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (46, 'Collins', '1414 Papa Ln', 'Vancouver', 'BC', 'W9W 9W9', 'Canada', '670329814', 'col@ex.com', '4kPj9sRf', 'receptionist', 46);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (47, 'Kim', '1616 Quebec Rd', 'Winnipeg', 'MB', 'Y1Y 1Y1', 'Canada', '390574216', 'kim@ex.com', '8dMx6jLw', 'receptionist', 47);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (48, 'Andrew', '1818 Romeo Ave', 'Victoria', 'BC', 'Z2Z 2Z2', 'Canada', '862407935', 'and@ex.com', 'e6Hv7pJy', 'receptionist', 48);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (49, 'Lily', '2020 Sierra Dr', 'Calgary', 'AB', 'A3A 3A3', 'Canada', '258143679', 'lily@ex.com', '9nKc4bRf', 'receptionist', 49);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (50, 'Gabriel', '2222 Tango Ave', 'Halifax', 'NS', 'B3J 2K8', 'Canada', '943815027', 'gab@ex.com', 'w3Gm2sTq', 'receptionist', 50);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (51, 'Owen', '2424 Uniform Rd', 'Halifax', 'NS', 'C5C 5C5', 'Canada', '516247839', 'owen@ex.com', '4tBk8sZr', 'receptionist', 51);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (52, 'Amir', '2626 Victor Blvd', 'Toronto', 'ON', 'D6D 6D6', 'Canada', '368509724', 'amir@ex.com', 'u5Xn3vLq', 'receptionist', 52);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (53, 'Addison', '2828 Whiskey Ln', 'Victoria', 'BC', 'E7E 7E7', 'Canada', '172835964', 'addison@ex.com', '7mCp6hFy', 'receptionist', 53);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (54, 'Karim', '3030 X-ray St', 'Calgary', 'AB', 'F8F 8F8', 'Canada', '647982315', 'k@ex.com', 'a8Rt5gVb', 'receptionist', 54);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (55, 'Julian', '3232 Yankee Dr', 'Halifax', 'NS', 'G9G 9G9', 'Canada', '935170482', 'j@ex.com', '6yLp9kHj', 'receptionist', 55);
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, role, hotel_id) 
VALUES (56, 'Zoey', '3434 Zulu Ave', 'Halifax', 'NS', 'H0H 0H0', 'Canada', '201957634', 'z@ex.com', 's2Zc7bNx', 'receptionist', 56);


-- ----------------------------Amenities ---------------------------------
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Pets Allowed');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Air conditioning');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Hot Tub');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Mini Bar');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Bathrobes and slippers');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Gym');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 1, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 1, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 1, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 1, 'Smart TV');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Pets Allowed');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Air conditioning');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Hot Tub');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Mini Bar');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Bathrobes and slippers');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Gym');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 2, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 2, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 2, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 2, 'Smart TV');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 3, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 3, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 3, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 3, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 3, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 3, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 3, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 3, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 3, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 3, 'Pets Allowed');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 3, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 3, 'Air conditioning');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 3, 'Hot Tub');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 3, 'Mini Bar');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 3, 'Bathrobes and slippers');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 3, 'Gym');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 3, 'Smart TV');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 4, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 4, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 4, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 4, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 4, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 4, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 4, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 4, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 4, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 4, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 4, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 4, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 4, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 4, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 4, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 4, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 5, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 5, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 5, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 5, 'Pets Allowed');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 5, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 5, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 5, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 5, 'Air conditioning');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 6, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 6, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 6, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 6, 'Hot Tub');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 7, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 7, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 7, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 7, 'Mini Bar');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 8, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 8, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 8, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 8, 'Bathrobes and slippers');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 9, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 9, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 9, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 9, 'Gym');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 10, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 10, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 10, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 10, 'Smart TV');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 11, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 11, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 11, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 11, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 12, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 12, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 12, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 12, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 13, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 13, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 13, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 13, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 14, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 14, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 14, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 14, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 15, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 15, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 15, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 15, 'Pets Allowed');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 16, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 16, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 16, 'Air conditioning');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 16, 'Air conditioning');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 17, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 17, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 17, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 17, 'Hot Tub');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 18, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 18, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 18, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 18, 'Mini Bar');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 19, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 19, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 19, 'Bathrobes and slippers');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 19, 'Bathrobes and slippers');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 20, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 20, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 20, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 20, 'Gym');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 21, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 21, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 21, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 21, 'Smart TV');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 22, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 22, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 22, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 22, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 23, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 23, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 23, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 23, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 24, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 24, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 24, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 24, 'Gym');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 25, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 25, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 25, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 25, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 26, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 26, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 26, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 26, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 27, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 27, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 27, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 27, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 28, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 28, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 28, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 28, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 29, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 29, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 29, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 29, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 30, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 30, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 30, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 30, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 31, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 31, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 31, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 31, 'Hot Tub');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 32, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 32, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 32, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 32, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 33, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 33, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 33, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 33, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 34, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 34, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 34, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 34, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 35, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 35, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 35, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 35, 'Pets Allowed');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 36, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 36, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 36, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 36, 'Smart TV');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 37, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 37, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 37, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 37, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 38, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 38, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 38, 'Gym');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 38, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 39, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 39, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 39, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 39, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 40, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 40, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 40, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 40, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 41, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 41, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 41, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 41, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 42, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 42, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 42, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 42, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 43, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 43, 'Smart TV');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 43, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 43, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 44, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 44, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 44, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 44, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 45, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 45, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 45, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 45, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 46, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 46, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 46, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 46, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 47, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 47, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 47, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 47, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 48, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 48, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 48, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 48, 'Free Parking');

INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 49, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 49, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 49, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 49, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 50, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 50, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 50, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 50, 'Free Parking');



INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 51, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 51, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 51, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 51, 'Mini Bar');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 52, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 52, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 52, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 52, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 53, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 53, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 53, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 53, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 54, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 54, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 54, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 54, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 55, 'Pets Allowed');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 55, 'Mini Bar');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 55, 'Pool');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 55, 'Free Parking');


INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (1, 56, 'Wifi');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (2, 56, 'Free Breakfast');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (3, 56, 'Hot Tub');
INSERT INTO amenity (room_number, hotel_id, amenity) VALUES (4, 56, 'Free Parking');


-----------Managers-------------

INSERT INTO manages(employee_id, mgr_id) VALUES (1, 1);
INSERT INTO manages(employee_id, mgr_id) VALUES (2, 2);
INSERT INTO manages(employee_id, mgr_id) VALUES (3, 3);
INSERT INTO manages(employee_id, mgr_id) VALUES (4, 4);
INSERT INTO manages(employee_id, mgr_id) VALUES (5, 5);
INSERT INTO manages(employee_id, mgr_id) VALUES (6, 6);
INSERT INTO manages(employee_id, mgr_id) VALUES (7, 7);
INSERT INTO manages(employee_id, mgr_id) VALUES (8, 8);
INSERT INTO manages(employee_id, mgr_id) VALUES (9, 9);
INSERT INTO manages(employee_id, mgr_id) VALUES (10, 10);
INSERT INTO manages(employee_id, mgr_id) VALUES (11, 11);
INSERT INTO manages(employee_id, mgr_id) VALUES (12, 12);
INSERT INTO manages(employee_id, mgr_id) VALUES (13, 13);
INSERT INTO manages(employee_id, mgr_id) VALUES (14, 14);
INSERT INTO manages(employee_id, mgr_id) VALUES (15, 15);
INSERT INTO manages(employee_id, mgr_id) VALUES (16, 16);
INSERT INTO manages(employee_id, mgr_id) VALUES (17, 17);
INSERT INTO manages(employee_id, mgr_id) VALUES (18, 18);
INSERT INTO manages(employee_id, mgr_id) VALUES (19, 19);
INSERT INTO manages(employee_id, mgr_id) VALUES (20, 20);
INSERT INTO manages(employee_id, mgr_id) VALUES (21, 21);
INSERT INTO manages(employee_id, mgr_id) VALUES (22, 22);
INSERT INTO manages(employee_id, mgr_id) VALUES (23, 23);
INSERT INTO manages(employee_id, mgr_id) VALUES (24, 24);
INSERT INTO manages(employee_id, mgr_id) VALUES (25, 25);
INSERT INTO manages(employee_id, mgr_id) VALUES (26, 26);
INSERT INTO manages(employee_id, mgr_id) VALUES (27, 27);
INSERT INTO manages(employee_id, mgr_id) VALUES (28, 28);
INSERT INTO manages(employee_id, mgr_id) VALUES (29, 29);
INSERT INTO manages(employee_id, mgr_id) VALUES (30, 30);
INSERT INTO manages(employee_id, mgr_id) VALUES (31, 31);
INSERT INTO manages(employee_id, mgr_id) VALUES (32, 32);
INSERT INTO manages(employee_id, mgr_id) VALUES (33, 33);
INSERT INTO manages(employee_id, mgr_id) VALUES (34, 34);
INSERT INTO manages(employee_id, mgr_id) VALUES (35, 35);
INSERT INTO manages(employee_id, mgr_id) VALUES (36, 36);
INSERT INTO manages(employee_id, mgr_id) VALUES (37, 37);
INSERT INTO manages(employee_id, mgr_id) VALUES (38, 38);
INSERT INTO manages(employee_id, mgr_id) VALUES (39, 39);
INSERT INTO manages(employee_id, mgr_id) VALUES (40, 40);
INSERT INTO manages(employee_id, mgr_id) VALUES (41, 41);
INSERT INTO manages(employee_id, mgr_id) VALUES (42, 42);
INSERT INTO manages(employee_id, mgr_id) VALUES (43, 43);
INSERT INTO manages(employee_id, mgr_id) VALUES (44, 44);
INSERT INTO manages(employee_id, mgr_id) VALUES (45, 45);
INSERT INTO manages(employee_id, mgr_id) VALUES (46, 46);
INSERT INTO manages(employee_id, mgr_id) VALUES (47, 47);
INSERT INTO manages(employee_id, mgr_id) VALUES (48, 48);
INSERT INTO manages(employee_id, mgr_id) VALUES (49, 49);
INSERT INTO manages(employee_id, mgr_id) VALUES (50, 50);
INSERT INTO manages(employee_id, mgr_id) VALUES (51, 51);
INSERT INTO manages(employee_id, mgr_id) VALUES (52, 52);
INSERT INTO manages(employee_id, mgr_id) VALUES (53, 53);
INSERT INTO manages(employee_id, mgr_id) VALUES (54, 54);
INSERT INTO manages(employee_id, mgr_id) VALUES (55, 55);
INSERT INTO manages(employee_id, mgr_id) VALUES (56, 56);


-- ----------------------------hotel chain emails ---------------------------------

INSERT INTO emailAddress (hotelChainID, email_address) VALUES(1, 'mariotinn@contactus.ca');
INSERT INTO emailAddress (hotelChainID, email_address) VALUES(2, 'hilton@contactus.ca');
INSERT INTO emailAddress (hotelChainID, email_address) VALUES(3, 'businessinn@contactus.ca');
INSERT INTO emailAddress (hotelChainID, email_address) VALUES(4, 'accor@contactus.ca');
INSERT INTO emailAddress (hotelChainID, email_address) VALUES(5, 'hyatt@contactus.ca');
INSERT INTO emailAddress (hotelChainID, email_address) VALUES(6, 'fourseasons@contactus.ca');
INSERT INTO emailAddress (hotelChainID, email_address) VALUES(7, 'wyndham@contactus.ca');

-- ----------------------------hotel chain phone numbers ---------------------------------

INSERT INTO hotelChainPhoneNumber (hotelChainID, phoneNumber) VALUES(1, '514-000-0000');
INSERT INTO hotelChainPhoneNumber (hotelChainID, phoneNumber) VALUES(2, '613-000-0000');
INSERT INTO hotelChainPhoneNumber (hotelChainID, phoneNumber) VALUES(3, '519-000-0000');
INSERT INTO hotelChainPhoneNumber (hotelChainID, phoneNumber) VALUES(4, '611-000-0000');
INSERT INTO hotelChainPhoneNumber (hotelChainID, phoneNumber) VALUES(5, '989-000-0000');
INSERT INTO hotelChainPhoneNumber (hotelChainID, phoneNumber) VALUES(6, '222-000-0000');
INSERT INTO hotelChainPhoneNumber (hotelChainID, phoneNumber) VALUES(7, '454-000-0000');

--- ----------------------------hotel phone numbers ---------------------------------

INSERT INTO hotelPhoneNumber (hotel_id, phoneNumber) VALUES(1, '123-456-7890');
INSERT INTO hotelPhoneNumber (hotel_id, phoneNumber) VALUES(2, '613-111-0011');
INSERT INTO hotelPhoneNumber (hotel_id, phoneNumber) VALUES(3, '519-000-2222');
INSERT INTO hotelPhoneNumber (hotel_id, phoneNumber) VALUES(4, '611-899-222');
INSERT INTO hotelPhoneNumber (hotel_id, phoneNumber) VALUES(5, '989-030-0040');
INSERT INTO hotelPhoneNumber (hotel_id, phoneNumber) VALUES(6, '222-110-0090');
INSERT INTO hotelPhoneNumber (hotel_id, phoneNumber) VALUES(7, '454-024-0008');
INSERT INTO hotelPhoneNumber (hotel_id, phoneNumber) VALUES(8, '555-024-0008');
INSERT INTO hotelPhoneNumber (hotel_id, phoneNumber) VALUES(9, '454-024-8888');
INSERT INTO hotelPhoneNumber (hotel_id, phoneNumber) VALUES(10, '333-263-0008');

--------------------------------- BOOKING ------------------------------------

INSERT INTO booking () VALUES ();


-------------------QUERIES---------------------------------------------

WITH hotel_room AS (SELECT * FROM hotel AS h INNER JOIN Room AS r ON h.id = r.hotel_id),
    room_amenity AS (SELECT * FROM room INNER JOIN amenity ON room.room_number =amenity.room_number AND room.hotel_id=amenity.hotel_id),
    hotel_hotel_chain AS (SELECT * FROM hotel INNER JOIN hotelChain ON hotel.id = hotelchain.id)

SELECT * FROM hotel_room; 
WHERE category IN () AND capacity = '' AND PRICE BETWEEN MIN AND MAX
AND VIEW IN ('VALUE') AND EXTENDED IN ("TRUE/FALSE") AND number_of_rooms = VAL
AND room_number IN (SELECT room_number FROM room_amenity WHERE amenity IN (""))
AND room_number NOT IN (SELECT room_number FROM Booking WHERE check_in_date <= '' 
OR check_out_date <= '')
AND id in (SELECT id FROM hotel_hotel_chain WHERE name in (""));


--------------------------TRIGGERS-----------------------------------------------

CREATE FUNCTION decrementHotels() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
BEGIN
   UPDATE hotelchain
   SET number_of_hotels = number_of_hotels - 1
   WHERE id = OLD.hotel_chain_id;
   RETURN NEW;
END;
$$;

CREATE FUNCTION incrementHotels() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
BEGIN
   UPDATE hotelchain
   SET number_of_hotels = number_of_hotels+1
   WHERE id = NEW.hotel_chain_id;
   RETURN NEW;
END;
$$;

CREATE FUNCTION decrementRooms() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
BEGIN
   UPDATE hotel
   SET number_of_rooms = number_of_rooms - 1
   WHERE id = OLD.hotel_id;
   RETURN NEW; 
END;
$$;

CREATE FUNCTION incrementRooms() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
BEGIN
   UPDATE hotel
   SET number_of_rooms = number_of_rooms + 1
   WHERE id = NEW.hotel_id;
   RETURN NEW;
END;
$$;

CREATE TRIGGER decrementHotelsTrig
AFTER DELETE ON hotel
FOR EACH ROW
EXECUTE FUNCTION decrementHotels();


CREATE TRIGGER incrementHotelsTrig
AFTER INSERT ON hotel
FOR EACH ROW
EXECUTE FUNCTION incrementHotels();

CREATE TRIGGER decrementRoomsTrig
AFTER DELETE ON room
FOR EACH ROW
EXECUTE FUNCTION decrementRooms();

CREATE TRIGGER incrementRoomsTrig
AFTER INSERT ON room
FOR EACH ROW
EXECUTE FUNCTION incrementRooms();


