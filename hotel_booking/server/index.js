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
        console.log(query);
        const customer = await pool.query(query);
        res.json(customer.rows);
        console.log(customer.rows);
    } catch (error) {
        
    }
});

//Get existing cities and countries

app.get("/city", async(req, res) => {
    try {
        console.log(res.status);
        const allLocations = await pool.query("SELECT DISTINCT id, city, country FROM hotel");
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

});

// Get existing hotels
app.get("/hotels", async(req, res) => {
    try {
        
    } catch (error) {
        
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