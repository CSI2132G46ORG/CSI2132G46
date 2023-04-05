-- A Database for a Hotel booking service
CREATE DATABASE reservio;

-- Create table commands

CREATE TABLE hotelChain (
    ID SERIAL NOT NULL,
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

CREATE INDEX hotel_ad_idx on hotel(city, country);
CREATE INDEX customer_email_password on customer(email, passwrd);
CREATE INDEX employee_email_password on customer(email, passwrd);
CREATE INDEX hotelchain_ad_idx on hotelChain(name);

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
CREATE TABLE manages (
    employee_id SERIAL NOT NULL,
    mgr_id INT NOT NULL,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (mgr_id) REFERENCES employee(id) 
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
    booking_id INT NOT NULL DEFAULT -1,
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



-- -------------------------------VIEWS-----------------------------------------------------
CREATE VIEW ROOM_LOC_VIEW AS
SELECT id, number_of_rooms, city, country
FROM hotel;

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
VALUES (5, 'Hyatt Hotels & Resorts', '123 road', 'Vancouver', 'BC', '60000', 'United States of America');
INSERT INTO hotelchain (id, name, street_address, city, province_or_state, Postal_code_or_zip_code, country)
VALUES (6, 'Four Seasons Hotels & Resorts', '123 road', 'Montreal', 'QC', '60000', 'United States of America');
INSERT INTO hotelchain (id, name, street_address, city, province_or_state, Postal_code_or_zip_code, country)
VALUES (7, 'Wyndham Hotels & Resorts', '123 road', 'Denver', 'CO', '60000', 'United States of America');



-- ------------------------------Hotels---------------------------------------
INSERT INTO hotel (category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id)
 VALUES(3, '123 one rd', 'Ottawa', 'ON', 'A1X 5K1', 'Canada', 'a@ex.com', 1);

INSERT INTO hotel (category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) 
VALUES(3,'123 one rd', 'Ottawa', 'ON', 'A1X 5K7', 'Canada', 'a2@ex.com', 1);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) 
VALUES(4,'1234 two rd', 'Ottawa', 'ON', 'A1X 5KX', 'Canada', 'a3@ex.com', 1);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) 
VALUES(5,'143 two rd', 'Vancouver', 'BC', 'A1X 5KX', 'Canada', 'a3@ex.com', 1);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) 
VALUES(5,'123 central rd', 'Austin', 'TX', '66544', 'United States of America', 'a4@ex.com', 1);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) 
VALUES(5, '123 st louis rd', 'Houston', 'TX', '465652', 'United States of America', 'a5@ex.com', 1);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code, country, contact_email, hotel_chain_id) 
VALUES(3, '123 btoadway', 'New York City', 'NY', '45646', 'United States of America', 'a6@ex.com', 1);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code, country, contact_email, hotel_chain_id)
 VALUES(2, '123 town rd', 'Vancouver', 'BC', 'H1J 5KX', 'Canada', 'a7@ex.com', 1);




INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(3, '123 celine rd', 'New york City', 'NY', '50000', 'United States of America', 'b1@ex.com', 2);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(3, '123 joyce rd', 'Boulder', 'CO', '10000', 'United States of America', 'b2@ex.com', 2);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 candy rd', 'Los Angeles', 'CA', '21200', 'United States of America', 'b3@ex.com', 2);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 Makepe', 'New york City', 'NY', '77777', 'United States of America', 'b4@ex.com', 2);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 Joy', 'Cleveland', 'OH', '54411', 'United States of America', 'b5@ex.com', 2);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(1, '123 Hurdman', 'Vancouver', 'BC', 'T1X 5K4', 'Canada', 'b6@ex.com', 2);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 Lyon', 'Montreal', 'QC', 'L1X 5K4', 'Canada', 'b7@ex.com', 2);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 st Germain', 'Quebec City', 'QC', 'M1X 5K4', 'Canada', 'b8@ex.com', 2);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(3, '123 paris rd', 'Ottawa', 'ON', 'C1V 5K4', 'Canada', 'c@ex.com', 3);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(3, '123 london rd', 'Toronto', 'ON', 'M1X 5K4', 'Canada', 'c2@ex.com', 3);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 boyca rd', 'Vancouver', 'BC', 'J1X 5K4', 'Canada', 'c3@ex.com', 3);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 douala rd', 'Vancouver', 'BC', 'N1X 4K4', 'Canada', 'c4@ex.com', 3);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(1, '123 Dakar rd', 'Montreal', 'QC', 'V1V 4K1', 'Canada', 'c5@ex.com', 3);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 Huffman rd', 'Toronto', 'ON', 'J1Y 5K7', 'Canada', 'c6@ex.com', 3);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 Puffy rd', 'Toronto', 'ON', 'U1X 1KX', 'Canada', 'c7@ex.com', 3);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 corny rd', 'Vancouver', 'BC', 'A1T 5K3', 'Canada', 'c8@ex.com', 3);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(3, '123 July rd', 'Ottawa', 'ON', 'X1X 5K9', 'Canada', 'd@ex.com', 4);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 August rd', 'Toronto', 'ON', 'Z1X 7K8', 'Canada', 'd2@ex.com', 4);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 jane rd', 'Vancouver', 'BC', 'N1X 5K4', 'Canada', 'd3@ex.com', 4);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 korea rd', 'Vancouver', 'BC', 'J1X 5K5', 'Canada', 'd4@ex.com', 4);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 witness rd', 'Montreal', 'QC', 'B1X 5K1', 'Canada', 'd5@ex.com', 4);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 ford rd', 'Indianapolis', 'IN', '14666', 'United States of America', 'd6@ex.com', 4);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 Levesque rd', 'Los Angeles', 'CA', '11722', 'United States of America', 'd7@ex.com', 4);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 Jackson rd', 'Sacramento', 'CA', '56912', 'United States of America', 'd8@ex.com', 4);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(3, '123 Kanye rd', 'Chicago', 'IL', '22000', 'United States of America', 'e@ex.com', 5);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 Common rd', 'Toronto', 'ON', 'A1X 5K7', 'Canada', 'e2@ex.com', 5);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 street', 'Vancouver', 'BC', 'S1X 5KX', 'Canada', 'e3@ex.com', 5);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 other street', 'Vancouver', 'BC', 'C1X 5K1', 'Canada', 'e4@ex.com', 5);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 boomer rd', 'Ottawa', 'ON', 'A1X 5K1', 'Canada', 'e5@ex.com', 5);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 genz rd', 'New York City', 'NY', '78200', 'United States of America', 'e6@ex.com', 5);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 select ', 'Minnesota', 'WI', '54312', 'United States of America', 'e7@ex.com', 5);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 miles rd', 'Vancouver', 'ON', '54545', 'United States of America', 'e8@ex.com', 5);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(3, '123 john st', 'Ottawa', 'ON', 'G1G 5K1', 'Canada', 'f@ex.com', 6);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 igor st', 'Toronto', 'ON', 'K1G 5K7', 'Canada', 'f2@ex.com', 6);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 main rd', 'Vancouver', 'BC', 'V1X 5K4', 'Canada', 'f3@ex.com', 6);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(1, '123 two rd', 'Vancouver', 'BC', 'V1X 5K4', 'Canada', 'f4@ex.com', 6);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(1, '123 thre rd', 'Ottawa', 'ON', 'A1X 5K1', 'Canada', 'f5@ex.com', 6);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 four rd', 'New York City', 'NY', '12521', 'United States of America', 'f6@ex.com', 6);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 five rd', 'New York City', 'NY', '96122', 'United States of America', 'f7@ex.com', 6);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(2, '123 six rd', 'New York City', 'NY', '41515', 'United States of America', 'f8@ex.com', 6);

INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(3, '123 seven rd', 'Ottawa', 'ON', 'K1X 5K1', 'Canada', 'g@ex.com', 7);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 kenny rd', 'Toronto', 'ON', 'J1X 5K4', 'Canada', 'g2@ex.com', 7);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 Lebum rd', 'Vancouver', 'BC', 'Y1X 5K7', 'Canada', 'g3@ex.com', 7);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(5, '123 LeMickey rd', 'Vancouver', 'BC', 'J1X 7K9', 'Canada', 'g4@ex.com', 7);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 LeDisney rd', 'Ottawa', 'ON', 'N1X 5K8', 'Canada', 'g5@ex.com', 7);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 Le46 rd', 'Chicago', 'IL', '23233', 'United States of America', 'g6@ex.com', 7);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 Pessi rd', 'New York City', 'NY', '44545', 'United States of America', 'g7@ex.com', 7);
INSERT INTO hotel(category, street_address, city, province_or_state, Postal_code_or_zip_code
, country, contact_email, hotel_chain_id) VALUES(4, '123 Penaldo rd', 'Saint Louis', 'CA', '11212', 'United States of America', 'g8@ex.com', 7);

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



-- ----------------------------Customers ---------------------------------
INSERT INTO customer(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, registration_date) 
VALUES (1, 'Ralph', '123 ex st', 'Ottawa', 'ON', 'K1J 5N2', 'Canada', '1102345646', 'ralph@ex.com', 'pompei', '2023-03-20');

-- --------------Employees---------------------------------------------
INSERT INTO employee(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, registration_date) 
VALUES (1, 'Tom', '123 ex st', 'Ottawa', 'ON', 'K1J 5N2', 'Canada', '15415112', 'tom@ex.com', 'pompei', '2023-03-30');

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


