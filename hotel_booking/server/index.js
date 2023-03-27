const express = require('express');
const app = express();
const cors = require('cors');
const pool = require('./db');
const { useState } = require('react');

//middleware
app.use(cors());
app.use(express.json());


app.use('/login', async (req, res) => {
    res.send({
      token: 'test123'
    });

    console.log("token send");
  });

//ROUTES


/*-----------------POST ---------------------- */

//Create booking
app.post("/bookings", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});

//Create Renting
app.post("/rentings", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});

//Create hotel chain
app.post("/hotelchains", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});

//Create hotel
app.post("/hotel", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});

//Create Room
app.post("/rooms", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});


// Create Customer
app.post("/signup", async(req, res) => {
    try {
        const {name, address, city, prov_or_state, post_or_zip, country, 
            ssn_sin, email, password, registration_date} = req.body;

        const queryCmd = `INSERT INTO\
        customer(full_name, street_address, city, province_or_state, Postal_code_zip_code, country, SSN_SIN, email, passwrd)\
         VALUES ('${name}', '${address}', '${city}', '${prov_or_state}', '${post_or_zip}', '${country}', ${ssn_sin}, '${email}', '${password}')`;
        
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
        const query = `SELECT * FROM customer WHERE email='${email}'`;
        console.log(req.params);
        const customer = await pool.query(query);
        res.json(customer.rows);
        // console.log(customer.rows);
    } catch (error) {
        
    }
});

//Get existing cities and countries

app.get("/city", async(req, res) => {
    try {
        console.log(res.status);
        const allLocations = await pool.query("SELECT DISTINCT ON (lower(city)) city, country, id FROM hotel GROUP BY city, id;");
        res.json(allLocations.rows);
    } catch (error) {
        console.log("err " +error.message);
    }
});

//Get existing bookings

app.get("/bookings", async(req, res) => {
    try {
        console.log(res.status);
        const bookings = await pool.query("");
    } catch (error) {
        console.log("err " +error.message);
    }
});

//Get existing rentings

app.get("/rentings", async(req, res) => {
    try {
        console.log(res.status);
        const rentings = await pool.query("");
    } catch (error) {
        console.log("err " +error.message);
    }
});


// Get existing hotel chains
app.get("/hotelchains", async(req, res) => {
    try {
        const hotelchains = await pool.query("SELECT id, name FROM hotelchain");
        console.log(hotelchains.rows);
        res.json(hotelchains.rows);
    } catch (error) {
        
    }
});

// Get existing hotels
app.get("/hotels", async(req, res) => {
    try {
       
        
    } catch (error) {
        
    }
});

const parseString = (str) =>{
    var strArr = str.split(",");

    for (var i = 0; i < strArr.length; i++) {
        var val = strArr[i];
        strArr[i] = `'${val}'`;
    }

    return strArr.join(",");
};

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
        var whereStatement = "";
        
        var c1 = 0;
        var c2 = 0;
        var c3 = 0;
        console.log("Dates", checkIn, checkOut);
        if (criteriaObj.numRooms != ''){
            numRoomCond = `AND number_of_rooms = ${criteriaObj.numRooms}`;
            c1++;
        }

        if (criteriaObj.hotelchains != '') {
            const val = parseString(criteriaObj.hotelchains);
            hotelChainCond = `WHERE LOWER(name) IN (${val})`;
        }

        if(criteriaObj.category != ''){
            const val = parseString(criteriaObj.category);
            categoryCond = `AND category IN (${val})`;
            c1++;
        }

        if (criteriaObj.view != '') {
            const val = parseString(criteriaObj.view);
            viewCond = `AND LOWER(view) IN (${val})`;
            c1++;
        }

        if(extendedCond != ''){
            const val = parseString(criteriaObj.extended);
            extendedCond = `AND LOWER(extended) IN (${val})`;
        }

        if (criteriaObj.amenities != '') {
            const val = parseString(criteriaObj.amenities);
            amenityCond = ` WHERE LOWER(amenity) IN (${val})`;
        }

        if (criteriaObj.capacity != '') {
            const val = parseString(criteriaObj.capacity);
            capCond = ` AND LOWER(capacity) IN (${val})`;
        }

        if (c1>0) whereStatement = "WHERE";

        let hotelchains = [];
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
    

            SELECT * FROM hotel_room as hr
            INNER JOIN hotelChain as hc ON  hc.id = hr.hotel_chain_id
            WHERE PRICE BETWEEN ${minPrice} AND ${maxPrice} ${categoryCond} ${capCond} 
            ${viewCond} ${extendedCond} ${numRoomCond}
            AND room_number IN (SELECT room_number FROM room_amenity ${amenityCond})
            AND hr.hotel_chain_id in (SELECT id FROM hotel_hotel_chain ${hotelChainCond})
            AND room_number NOT IN (SELECT room_id FROM Booking WHERE (checkout_date >= '${checkIn}' AND checkout_date <= '${checkOut}') 
            OR (checkin_date >= '${checkIn}' AND checkin_date <='${checkOut}') OR (checkin_date <='${checkIn}' AND checkout_date >='${checkOut}'))
        `;
        console.log(queryStatement);
        const hotels = await pool.query(queryStatement);
        // console.log("results, ", hotels.rows);
        res.json(hotels.rows);
    } catch (error) {
        console.error(error);
    }
});

// Get existing rooms
app.get("/rooms", async(req, res) => {
    try {
        
    } catch (error) {
        
    }
});



/*---------UPDATE------------------------------- */

// update customer info

app.put("/customers/:email", async(req, res) => {
    try {
        
    } catch (error) {
        
    }
});

// Update employee info

app.put("/employees/:id", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});


// update hotel chain info
app.put("/hotelchains/:id", async(req, res) =>{
    try {
        
    } catch (error) {
        
    }
});

// update hotels info
app.put("/hotel/:id", async(req, res) =>{
    try {
        
    } catch (error) {
        
    }
});

// update hotel chain info
app.put("/rooms/:id", async(req, res) =>{
    try {
        
    } catch (error) {
        
    }
});

/*---------DELETE------------------------- */

//Delete booking
app.delete("/bookings/:id", async(req, res) => {
    try {
        
    } catch (error) {
        
    }
});

//Delete renting
app.delete("/rentings/:id", async(req, res) => {
    try {
        
    } catch (error) {
        
    }
});

//Delete hotel chain
app.delete("/hotelchains/:id", async(req, res) => {
    try {
        
    } catch (error) {
        
    }
});

// Delete hotel
app.delete("/hotels/:id", async(req, res) => {
    try {
        
    } catch (error) {
        
    }
});

//Delete room
app.delete("/rooms/:id", async(req, res) => {
    try {
        
    } catch (error) {
        
    }
});

// Delete registered employee

app.delete("/employees/:id", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});

// Delete registered customer

app.delete("/customer/:id", async (req, res) => {
    try {
        
    } catch (error) {
        
    }
});

// Port through which connection is established with server
const port= 5000;


app.listen(port, () => {
    console.log(`Server successfully listening on port ${port}`);
});