const express = require('express');
const app = express();
const cors = require('cors');
const pool = require('./db');
const { useState } = require('react');

//middleware
app.use(cors());
app.use(express.json());


app.use('/login', async (req, res) => {
    console.log('params', req.body);
    res.send({
      token: req.body
    });

    console.log("token send");
  });

//ROUTES


/*-----------------POST ---------------------- */

//Create booking
app.post("/bookings", async (req, res) => {
    try {
        const {customerID, roomNum, hotelID, checkInDate, checkOutDate} = req.body;
        const queryCmd = `
            INSERT INTO booking (customer_id, room_id, hotel_id, checkin_date, checkout_date) VALUES (${customerID}, ${roomNum}, ${hotelID}, '${checkInDate}', '${checkOutDate}')
        `;
        console.log(queryCmd);
        const booking = await pool.query(queryCmd);
        res.json(booking.rows);
    } catch (error) {
        console.error(error);
    }
});

app.post("/bookingarchives", async (req, res) => {
    try {
        const {booking_id, customer_id, room_id, hotel_id, checkin_date, checkout_date, booking_date} = req.body;
        const checkin_date_str = checkin_date.split("T")[0]
        const checkOutDate_str = checkout_date.split("T")[0];
        const queryCmd = `
            INSERT INTO booking_archive (booking_id, customer_id, room_id, hotel_id, checkin_date, checkout_date, booking_date) 
            VALUES (${booking_id}, ${customer_id}, ${room_id}, 
                ${hotel_id}, '${checkin_date_str}','${checkOutDate_str}', '${booking_date}')
        `;
        console.log(queryCmd);
        const booking = await pool.query(queryCmd);
        res.json(booking.rows);
    } catch (error) {
        console.error(error);
    }
});

//Create Renting
app.post("/rentings", async (req, res) => {
    try {
        const {customerId, employeeId, roomNumber, hotelId, checkInStr, checkOutStr, bookingId} = req.body;
        const queryCmd = `
            INSERT INTO renting (customer_id, employee_id, room_id, hotel_id, checkin_date, checkout_date, paid_for, booking_id)
             VALUES (${customerId}, ${employeeId}, ${roomNumber}, ${hotelId}, '${checkInStr}', '${checkOutStr}', TRUE, ${bookingId})
        `;
        console.log(queryCmd);
        const renting = await pool.query(queryCmd);
        res.json(renting.rows);
    } catch (error) {
        console.error(error);
    }
});

//Create Renting archive
app.post("/rentingarchives", async (req, res) => {
    try {
        const {renting_id, customer_id, employee_id, room_id, hotel_id, checkin_date, checkout_date,booking_id, renting_date} = req.body;
        var renting_date_str  = renting_date.split("T")[0];
        var checkin_date_str = checkin_date.split("T")[0];
        var checkout_date_str = checkout_date.split("T")[0];
        const queryCmd = `
            INSERT INTO renting_archive (renting_id, customer_id, employee_id, 
                room_id, hotel_id, checkin_date, checkout_date,  renting_date,  paid_for, booking_id) 
            VALUES (${renting_id}, ${customer_id}, ${employee_id}, ${room_id},
                 ${hotel_id}, '${checkin_date_str}', '${checkout_date_str}', '${renting_date_str}',  TRUE, ${booking_id})
        `;
        console.log(queryCmd);
        const booking = await pool.query(queryCmd);
        res.json(booking.rows);
    } catch (error) {
        console.error(error);
    }
});

//Create hotel chain
app.post("/hotelchains", async (req, res) => {
    try {
        console.log(req.body);
        const {name, street_address, city, province_or_state, postal_code_or_zip_code,
             country} = req.body;
        const queryCmd = `
            INSERT INTO hotelchain (name, street_address, city, province_or_state,
                postal_code_or_zip_code, country)
                 VALUES ('${name}', '${street_address}', 
            '${city}', '${province_or_state}', '${postal_code_or_zip_code}',
            '${country}')
        `;
        console.log(queryCmd);
        const hc = await pool.query(queryCmd);
        res.json(hc.rows);
    } catch (error) {
        console.error(error);
    }
});

//Create hotel
app.post("/hotel", async (req, res) => {
    try {
        console.log(req.body);
        const {category, stAd, city, provOrState, postOrZip,
             country, email, hotelChainId} = req.body;
        const queryCmd = `
            INSERT INTO hotel (category, street_address, city, province_or_state,
                postal_code_or_zip_code, country, contact_email, hotel_chain_id)
                 VALUES (${parseInt(category)}, '${stAd}', 
            '${city}', '${provOrState}', '${postOrZip}',
            '${country}', '${email}', '${parseInt(hotelChainId)}')
        `;
        console.log(queryCmd);
        const hotel = await pool.query(queryCmd);
        res.json(room.rows);
    } catch (error) {
        console.error(error);
        
    }
});

//Create Room
app.post("/rooms", async (req, res) => {
    try {
        const {roomNumber, hotelId, price, capacity, view, extended, problems} = req.body;
        const queryCmd = `
            INSERT INTO room VALUES (${parseInt(roomNumber)}, ${parseInt(price)}, '${capacity}', 
            ${view}, '${extended}', '${problems}', '${parseInt(hotelId)}')
        `;
        console.log(queryCmd);
        const room = await pool.query(queryCmd);
        res.json(room.rows);
    } catch (error) {
        console.error(error);
        
    }
});


// Create Customer
app.post("/signup", async(req, res) => {
    try {
        const {name, address, city, provOrState, postOrZip, country, 
            ssn_sin, email, password, registration_date} = req.body;

        const queryCmd = `INSERT INTO\
        customer(full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd)\
         VALUES ('${name}', '${address}', '${city}', '${provOrState}', '${postOrZip}', '${country}', ${ssn_sin}, '${email}', '${password}')`;
        
         console.log(queryCmd);
        const customer = await pool.query(queryCmd);
        res.json(customer.rows);
    } catch (error) {
        console.log("err " +error.message);
    }
});

// Create employee

app.post("/employees", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});

/*---------GET------------------------------- */

//Get all registered customers
app.get("/customers", async (req, res) => {
    try {
        console.log(res.body);
        const customers = await pool.query("SELECT * FROM customer");
        res.json(customers.rows);
    } catch (error) {
        console.error(error)
    }
});

//Get all registered customers by id
app.get("/customersbyid/:id", async (req, res) => {
    try {
        console.log(res.body);
        const customers = await pool.query(`SELECT * FROM customer WHERE id = ${req.params.id}`);
        res.json(customers.rows);
    } catch (error) {
        console.error(error)
    }
});

// Get all registered employees

app.get("/employees/:id", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});

// Get Customer by email
app.get("/customers/:email", async (req, res) => {
    try {
        const email = req.params['email'];
        const query = `SELECT * FROM customer WHERE LOWER(email) ='${email.toLowerCase()}'`;
        console.log(req.params);
        const customer = await pool.query(query);
        res.json(customer.rows);
        // console.log(customer.rows);
    } catch (error) {
        console.log(error);
    }
});

// Get Customer by email and password
app.get("/employees/:email/:password", async (req, res) => {
    try {
        const email = req.params['email'];
        const password = req.params['password'];
        const query = `SELECT id, full_name, hotel_id FROM employee 
        WHERE LOWER(email) ='${email.toLowerCase()}' AND passwrd='${password}'`;
        console.log(req.params);
        const employee = await pool.query(query);
        res.json(employee.rows);
        console.log(employee.rows);
    } catch (error) {
        console.error(error);
    }
});

// Get Customer by email and password
app.get("/customers/:email/:password", async (req, res) => {
    try {
        const email = req.params['email'];
        const password = req.params['password'];
        const query = `SELECT id, full_name FROM customer WHERE LOWER (email)='${email.toLowerCase()}' AND passwrd='${password}'`;
        console.log(req.params);
        const customer = await pool.query(query);
        res.json(customer.rows);
        console.log(customer.rows);
    } catch (error) {
        console.error(error);
    }
});

// Get Admin by email and password
app.get("/admin/:email/:password", async (req, res) => {
    try {
        const email = req.params['email'];
        const password = req.params['password'];
        const query = `SELECT id, full_name FROM admin WHERE LOWER (email)='${email.toLowerCase()}' AND passwrd='${password}'`;
        console.log(req.params);
        const admin = await pool.query(query);
        res.json(admin.rows);
        console.log(admin.rows);
    } catch (error) {
        console.error(error);
    }
});

//Get existing cities and countries

app.get("/city", async(req, res) => {
    try {
        console.log(res.status);
        const allLocations = await pool.query("SELECT DISTINCT ON (lower(city)) city, country, id FROM hotel GROUP BY city, id;");
        res.json(allLocations.rows);
    } catch (error) {
        console.error(error);
    }
});

//Get existing bookings

app.get("/bookings", async(req, res) => {
    try {
        console.log(res.status);
        const bookings = await pool.query("SELECT * FROM Booking");
        res.json(bookings.rows);
    } catch (error) {
        console.log("err " +error.message);
    }
});

//Get existing bookings in given Hotel

app.get("/bookings/:hotelid", async(req, res) => {
    try {
        console.log(req.params.hotelid);
        const bookings = await pool.query(`SELECT * FROM Booking WHERE hotel_id= ${req.params.hotelid}`);
        res.json(bookings.rows);
    } catch (error) {
        console.error(error);
    }
});

//Get existing rentings

app.get("/rentings", async(req, res) => {
    try {
        console.log(res.status);
        const rentings = await pool.query("SELECT * FROM renting");
        res.json(rentings.rows);
    } catch (error) {
        console.error(error);
    }
});


app.get("/rentings/:hotelid", async(req, res) => {
    try {
        console.log(res.status);
        const rentings = await pool.query(`SELECT * FROM renting WHERE hotel_id= ${req.params.hotelid}`);
        res.json(rentings.rows);
    } catch (error) {
        console.error(error);
    }
});

// Get existing hotel chains
app.get("/hotelchains", async(req, res) => {
    try {
        const hotelchains = await pool.query("SELECT * FROM hotelchain");
        console.log(hotelchains.rows);
        res.json(hotelchains.rows);
    } catch (error) {
        console.error(error);
    }
});

// Get existing hotels
app.get("/allhotels/:id", async(req, res) => {
    try {
        console.log("id ", req.params.id);
        const hotelchains = await pool.query(`SELECT * FROM hotel WHERE hotel_chain_id=${req.params.id}` );
        console.log(hotelchains.rows);
        res.json(hotelchains.rows);
        
    } catch (error) {
        console.error(error);   
    }
});


// Get existing hotels by criteria
app.get("/hotels/:criteria", async(req, res) => {
    try {
        const criteriaArr = req.params['criteria'].split("&");
        let criteriaObj = {};

        for (let i = 0; i < criteriaArr.length; i++) {
            const p1 = criteriaArr[i].split("=")[0];
            const p2 = criteriaArr[i].split("=")[1];
            criteriaObj = {
                ...criteriaObj,
                [p1] : p2
            }
        }
        console.log(criteriaObj);

        var minPrice = criteriaObj.minPrice === ''? 0 : parseInt(criteriaObj.minPrice);
        var maxPrice = criteriaObj.maxPrice === ''? 10000000 : parseInt(criteriaObj.maxPrice);
        var checkIn = criteriaObj.checkInDate.replace(/_/g, "/");
        var checkOut = criteriaObj.checkOutDate.replace(/_/g, "/");
        // const numRooms = criteriaObj.numRooms === ''? 0 : criteriaObj.numRooms;
        var numRoomCond = "";
        var hotelChainCond = "";
        var categoryCond = "";
        var viewCond = "";
        var amenityCond = "";
        var extendedCond = "";
        var capCond = "";
        var areaCond = "";
        

        // console.log("Dates", checkIn, checkOut);
        if (criteriaObj.numRooms != ''){
            numRoomCond = `AND number_of_rooms = ${criteriaObj.numRooms}`;
        }

        if (criteriaObj.hotelchains != '') {
            hotelChainCond = `WHERE LOWER(name) IN (${criteriaObj.hotelchains})`;
        }

        if(criteriaObj.category != ''){
            categoryCond = `AND category IN (${criteriaObj.category})`;
            console.log("Categories", criteriaObj.category);
        }

        if (criteriaObj.view != '') {
            viewCond = `AND LOWER(view) IN (${criteriaObj.view})`;
        }

        if(criteriaObj.extended != ''){
            extendedCond = `AND extended IN (${criteriaObj.extended})`;
        }

        if (criteriaObj.amenities != '') {
            amenityCond = ` WHERE LOWER(amenity) IN (${criteriaObj.amenities})`;
        }

        if (criteriaObj.capacity != '') {
            capCond = ` AND LOWER(capacity) IN (${criteriaObj.capacity})`;
        }

        if (criteriaObj.area != ''){
            // const val = parseString(criteriaObj.city);
            const areaArr = criteriaObj.area.split(',');
            const city = areaArr[0].trim().toLowerCase();
            const country = areaArr[1].trim().toLowerCase();

            areaCond = ` AND lower(hr.city) = '${city}' AND lower(hr.country) = '${country}'`;  
        }


        const queryStatement = `
            WITH hotel_room AS (SELECT h.id as hotel_id, h.category, h.number_of_rooms, h.street_address,
                 h.city, h.province_or_state, h.postal_code_or_zip_code, h.country, h.contact_email,
                  h.hotel_chain_id, r.room_number, r.price, 
                  r.capacity, r.view, r.extended, r.problems FROM hotel AS h INNER JOIN Room AS r ON h.id = r.hotel_id),
                room_amenity AS (SELECT r.room_number, r.price, r.capacity, r.view, r.extended, r.problems,
                     r.hotel_id, a.amenity  FROM room 
                      as r INNER JOIN amenity as a ON r.room_number =a.room_number AND r.hotel_id=a.hotel_id),
                hotel_hotel_chain AS 
                (SELECT h.id, h.category, h.number_of_rooms, h.street_address, h.city, h.province_or_state,
                     h.postal_code_or_zip_code, h.country, h.contact_email, 
                     h.hotel_chain_id, hc.name, hc.street_address, hc.city, 
                     hc.province_or_state, hc.postal_code_or_zip_code, hc.country, hc.number_of_hotels FROM hotel as h INNER JOIN hotelChain as hc ON h.id = hc.id)
    

            SELECT hr.hotel_id, MIN(hr.price), hc.name, hr.street_address, hr.city, 
            hr.province_or_state, hr.postal_code_or_zip_code, hr.country  FROM hotel_room as hr
            INNER JOIN hotelChain as hc ON  hc.id = hr.hotel_chain_id
            WHERE PRICE BETWEEN ${minPrice} AND ${maxPrice} ${categoryCond} ${capCond} 
            ${viewCond} ${extendedCond} ${numRoomCond} ${areaCond}
            AND room_number IN (SELECT room_number FROM room_amenity ${amenityCond})
            AND hr.hotel_chain_id in (SELECT id FROM hotel_hotel_chain ${hotelChainCond})
            AND (room_number, hr.hotel_id) NOT IN (SELECT room_id, hotel_id  FROM Booking WHERE (checkout_date >= '${checkIn}' AND checkout_date <= '${checkOut}') 
            OR (checkin_date >= '${checkIn}' AND checkin_date <='${checkOut}') OR (checkin_date <='${checkIn}' AND checkout_date >='${checkOut}'))
            AND (room_number, hr.hotel_id) NOT IN (SELECT room_id, hotel_id FROM Renting WHERE (checkout_date >= '${checkIn}' AND checkout_date <= '${checkOut}') 
            OR (checkin_date >= '${checkIn}' AND checkin_date <='${checkOut}') OR (checkin_date <='${checkIn}' AND checkout_date >='${checkOut}'))
            GROUP BY hr.hotel_id, hc.name, hr.street_address, hr.city, hr.province_or_state, hr.postal_code_or_zip_code, hr.country
            
        `;
        console.log(queryStatement);
        const hotels = await pool.query(queryStatement);
        console.log("results, ", hotels.rows);
        res.json(hotels.rows);
    } catch (error) {
        console.error(error);
    }
});

// Get existing rooms
app.get("/rooms/:hotelId", async(req, res) => {
    try {
        console.log("hotelId ", req.params.hotelId);
        const rooms = await pool.query(`SELECT * FROM room WHERE hotel_id=${req.params.hotelId}` );
        console.log(rooms.rows);
        res.json(rooms.rows);
    } catch (error) {
        console.error(error);
    }
});

// Get existing rooms by location
app.get("/roomsbyloc/:location", async(req, res) => {
    try {
        const locationArr = req.params['location'].split(",");
        const city = locationArr[0].trim().toLowerCase();
        const country = locationArr[1].trim().toLowerCase();
        console.log(city, country);
        const queryStatement = `
            SELECT SUM (number_of_rooms) FROM ROOM_LOC_VIEW WHERE LOWER (city) = '${city}' AND LOWER (country) = '${country}'    
            `
        console.log(queryStatement);
        const rooms = await pool.query(queryStatement);
        console.log("room results, ", rooms.rows);
        res.json(rooms.rows);
    } catch (error) {
        console.error(error);
    }
});

//booking -> booking archive
app.get("/lastbooking", async(req, res) => {
    try {

        const queryStatement = `
        SELECT *
            FROM booking
            ORDER BY booking_id DESC
            LIMIT 1
        `;

        const booking = await pool.query(queryStatement);
        console.log("last booking, ", booking.rows);
        res.json(booking.rows);
    } catch (error) {
        
    }
});

//renting -> renting_archive
app.get("/lastrenting", async(req, res) => {
    try {
        const queryStatement = `
        SELECT *
            FROM renting
            ORDER BY renting_id DESC
            LIMIT 1
        `;

        const renting = await pool.query(queryStatement);
        console.log("last renting, ", renting.rows);
        res.json(renting.rows);
    } catch (error) {
        
    }
});

//get hotel info for a specific hotel
app.get("/hotels/info/:hotel_id", async(req, res) => {
    const { hotel_id } = req.params;
    try {
        const amenity = await pool.query("SELECT * FROM hotel WHERE hotel.ID = $1",[hotel_id]);
        console.log(amenity.rows);
        res.json(amenity.rows);
        
    } catch (error) {
        console.log(error);
    }
});

app.get("/amenity/:hotel_id", async(req, res) => {
    const { hotel_id } = req.params;
    try {
        const hotel = await pool.query("SELECT * FROM amenity WHERE hotel_id = $1",[hotel_id]);
        console.log(hotel.rows);
        res.json(hotel.rows);
        
    } catch (error) {
        console.log(error);
    }
});


//get all rooms for specific hotel
app.get("/hotels/:hotel_id/rooms", async (req, res) => {
    const { hotel_id } = req.params;
    const { checkin_date, checkout_date } = req.query;
  
    try {
      const result = await pool.query(`
      SELECT *
      FROM room
      WHERE hotel_id = $1
      AND room_number NOT IN (
        
        SELECT room_id
        FROM booking
        WHERE hotel_id = $1
        AND (
            (checkin_date <= $2
            AND (checkout_date BETWEEN $2 AND $3))
        OR 
         (checkin_date >= $2
            AND checkout_date <= $3)
        OR
            ((checkin_date BETWEEN $2 AND $3)
            AND checkout_date >= $3)       
        OR 
            (checkin_date <= $2
            AND checkout_date >= $3)
        )
          );
      `, [hotel_id, checkout_date, checkin_date]);
  
      res.json(result.rows);
    } catch (error) {
      console.error(error);
      res.status(500).send('Server Error');
    }
  });



/*---------UPDATE------------------------------- */

// update customer info

app.put("/customers", async(req, res) => {
    try {
        console.log("req ", req.body);
        const queryStatement = `
            UPDATE customer
            SET full_name = '${req.body.name}', street_address = '${req.body.stAd}', ssn_sin = ${req.body.ssnSin},
            city = '${req.body.city}', province_or_state = '${req.body.provOrState}',
            postal_code_zip_code = '${req.body.postOrZip}', country = '${req.body.country}', email = '${req.body.email}',
            passwrd = '${req.body.password}'
            WHERE id = ${req.body.customerId}
        `;
        console.log(queryStatement);
        const customer = await pool.query(queryStatement);
        // console.log("last booking, ", booking.rows);
        res.json(customer.rows);
    } catch (error) {
        console.error(error);
    }
});

// Update employee info

app.put("/employees/:id", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});


// update hotel chain info
app.put("/hotelchains", async(req, res) =>{
    try {
        console.log("req ", req.body);
        const queryStatement = `
            UPDATE hotelchain
            SET name = '${req.body.name}', street_address = '${req.body.street_address}', city = '${req.body.city}', province_or_state = '${req.body.province_or_state}',
            postal_code_or_zip_code = '${req.body.postal_code_or_zip_code}', country = '${req.body.country}'
            WHERE id = ${req.body.id}
        `;
        console.log(queryStatement);
        const hc = await pool.query(queryStatement);
        // console.log("last booking, ", booking.rows);
        res.json(hc.rows);
    } catch (error) {
        console.log(error);
    }
});

// update hotels info
app.put("/hotels", async(req, res) =>{
    try {
        console.log("req ", req.body);
        const queryStatement = `
            UPDATE hotel
            SET category = '${req.body.category}', street_address = '${req.body.stAd}', 
            city = '${req.body.city}', province_or_state = '${req.body.provOrState}',
            postal_code_or_zip_code = '${req.body.postOrZip}', country = '${req.body.country}', contact_email = '${req.body.email}'
            WHERE id = ${req.body.hotelId}
        `;
        console.log(queryStatement);
        const hc = await pool.query(queryStatement);
        // console.log("last booking, ", booking.rows);
        res.json(hc.rows);
    } catch (error) {
        console.error(error);
    }
});

// update hotel chain info
app.put("/rooms", async(req, res) =>{
    try {
        console.log("req ", req.body);
        const queryStatement = `
            UPDATE room
            SET price = '${req.body.price}', capacity = '${req.body.capacity}', 
            view = '${req.body.view}', extended = ${req.body.extended.toUpperCase()},
            problems = ${req.body.problems.toUpperCase()}
            WHERE room_number = ${req.body.roomNumber} AND hotel_id = ${req.body.hotelId}
        `;
        console.log(queryStatement);
        const hc = await pool.query(queryStatement);
        res.json(hc.rows);
    } catch (error) {
        console.error(error);
    }
});

/*---------DELETE------------------------- */

//Delete booking
app.delete("/bookings", async(req, res) => {
    try {
        console.log("req ", req.body);
        const queryStatement = `
            DELETE FROM booking WHERE booking_id =${req.body.bookingId}
        `;
        console.log(queryStatement);
        const hc = await pool.query(queryStatement);
        res.json(hc.rows);
    } catch (error) {
        console.error(error);
    }
});

//Delete renting
app.delete("/rentings/:rentingId", async(req, res) => {
    try {
        console.log("req ", req.body);
        const queryStatement = `
            DELETE FROM renting WHERE renting_id =${req.body.rentingId}
        `;
        console.log(queryStatement);
        const hc = await pool.query(queryStatement);
        res.json(hc.rows);
    } catch (error) {
        console.error(error);
    }
});

//Delete hotel chain
app.delete("/hotelchains/", async(req, res) => {
    try {
        console.log("req ", req.body);
        const queryStatement = `
            DELETE FROM hotelchain WHERE id =${req.body.id}
        `;
        console.log(queryStatement);
        const hc = await pool.query(queryStatement);
        res.json(hc.rows);
    } catch (error) {
        console.error(error);
    }
});

// Delete hotel
app.delete("/hotels/", async(req, res) => {
    try {
        console.log("req ", req.body);
        const queryStatement = `
            DELETE FROM hotel WHERE id =${req.body.hotelId}
        `;
        console.log(queryStatement);
        const hc = await pool.query(queryStatement);
        res.json(hc.rows);
    } catch (error) {
        console.error(error);
    }
});

//Delete room
app.delete("/rooms", async(req, res) => {
    try {
        console.log("req ", req.body);
        const queryStatement = `
            DELETE FROM room WHERE room_number = ${req.body.roomNumber} AND hotel_id =${req.body.hotelId}
        `;
        console.log(queryStatement);
        const hc = await pool.query(queryStatement);
        res.json(hc.rows);
    } catch (error) {
        console.error(error);
    }
});

// Delete registered employee

app.delete("/employees/:id", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});

// Delete registered customer

app.delete("/customers", async (req, res) => {

    try {
        const id = req.body.id;
        console.log("req ", req.body);

        const queryStatement = `
            DELETE FROM customer WHERE id = ${id}        
        `;

        console.log(queryStatement);
        const hc = await pool.query(queryStatement);
        res.json(hc.rows);

    } catch (error) {
        console.log(error);
    }
});

// Port through which connection is established with server
const port= 5100;


app.listen(port, () => {
    console.log(`Server successfully listening on port ${port}`);
});