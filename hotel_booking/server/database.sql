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
    number_of_hotels INT NOT NULL,
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
    ID SERIAL NOT NULL,
    category INT NOT NULL CHECK (category >=1 AND category <=5),
    number_of_rooms INT NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    province_or_state VARCHAR(255) NOT NULL,
    Postal_code_or_zip_code VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    hotel_chain_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (hotel_chain_id) REFERENCES hotelChain(ID) ON DELETE CASCADE
);

CREATE INDEX hotel_ad_idx on hotel(city, country);

CREATE TABLE hotelPhoneNumber (
    hotel_id INT NOT NULL,
    phoneNumber VARCHAR(10) NOT NULL,
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
    role VARCHAR(255) NOT NULL,
    hotel_id VARCHAR(10) NOT NULL,
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
    capacity VARCHAR(255) NOT NULL CHECK (capacity IN ('SINGLE', 'DOUBLE')), --add more
    VIEW VARCHAR(255) NOT NULL,
    Extended BOOLEAN NOT NULL,
    Problems BOOLEAN NOT NULL,
    hotel_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (room_number, hotel_id),
    FOREIGN KEY (hotel_id) REFERENCES hotel(ID) ON DELETE CASCADE
);

CREATE TABLE amenity (
    room_number INT NOT NULL,
    amenity VARCHAR(255) not NULL,
    PRIMARY KEY (room_number, amenity),
    FOREIGN KEY (room_number) REFERENCES room ON DELETE CASCADE
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
    booking_id SERIAL NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    hotel_id INT NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    PRIMARY KEY (booking_id),
    FOREIGN KEY (customer_id) REFERENCES customer(ID),
    FOREIGN KEY (room_id) REFERENCES room(room_number)
);
CREATE TABLE renting (
    renting_id SERIAL NOT NULL,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    room_id INT NOT NULL,
    hotel_id INT NOT NULL,
    renting_date DATE NOT NULL,
    paid_for BOOLEAN NOT NULL,
    booking_id VARCHAR(10),
    PRIMARY KEY (renting_id),
    FOREIGN KEY (employee_id) REFERENCES employee(ID),
    FOREIGN KEY (customer_id) REFERENCES customer(ID),
    FOREIGN KEY (room_id) REFERENCES room(room_number),
    FOREIGN KEY (booking_id) REFERENCES booking
);
CREATE TABLE booking_archive(
    booking_id INT NOT NULL,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    hotel_id INT NOT NULL,
    booking_date DATE NOT NULL,
    PRIMARY KEY (booking_id),
    FOREIGN KEY (customer_id) REFERENCES customer(ID),
    FOREIGN KEY (room_id) REFERENCES room(room_number)
);

CREATE TABLE renting_archive (
    renting_id INT NOT NULL,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    room_id INT NOT NULL,
    hotel_id INT NOT NULL,
    renting_date DATE NOT NULL,
    paid_for BOOLEAN NOT NULL,
    booking_id INT,
    PRIMARY KEY (renting_id),
    FOREIGN KEY (employee_id) REFERENCES employee(ID),
    FOREIGN KEY (customer_id) REFERENCES customer(ID),
    FOREIGN KEY (room_id) REFERENCES room(room_number),
    FOREIGN KEY (booking_id) REFERENCES booking
);

INSERT INTO hotelchain VALUES (1, 'mariot', '123 road', 'Ottawa', 'ON', 'K1J AX6', 'canada', '5');
INSERT INTO hotelchain VALUES (2, 'hilton', '123 road', 'New york City', 'NY', '60000', 'United States of America', '5');

INSERT INTO hotel VALUES(1, 3, 15, '123 one rd', 'Ottawa', 'ON', 'A1X 5K1', 'Canada', 'a@ex.com', 1);
INSERT INTO hotel VALUES(2, 3, 15, '123 one rd', 'Toronto', 'ON', 'A1X 5K7', 'Canada', 'a2@ex.com', 1);
INSERT INTO hotel VALUES(3, 3, 15, '123 one rd', 'Vancouver', 'ON', 'A1X 5KX', 'Canada', 'a3@ex.com', 1);

INSERT INTO hotel VALUES(4, 3, 15, '123 one rd', 'New york City', 'NY', '50000', 'United States of America', 'b@ex.com', 2);
INSERT INTO hotel VALUES(5, 3, 15, '123 one rd', 'Boulder', 'CO', '10000', 'United States of America', 'b2@ex.com', 2);
INSERT INTO hotel VALUES(6, 3, 15, '123 one rd', 'Los Angeles', 'CA', '21200', 'United States of America', 'b3@ex.com', 2);

INSERT INTO customer(id, full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd, registration_date) 
VALUES (1, 'Ralph', '123 ex st', 'Ottawa', 'ON', 'K1J 5N2', 'Canada', '1102345646', 'ralph@ex.com', 'pompei', '2023-03-20');