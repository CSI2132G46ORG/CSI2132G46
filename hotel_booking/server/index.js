const express = require('express');
const app = express();
const cors = require('cors');
const pool = require('./db');

//middleware
app.use(cors());
app.use(express.json());

//ROUTES

//Create booking
// app.post();

//Create Renting
// app.post();

//Delete booking
// app.delete();

//Delete renting
// app.delete();

// Create Customer
// app.post();

//Create employee
// app.post();1

//Delete employee

//Delete customer

//Update customer

//Update employee

//Get existing cities and countries

app.get("/city", async(req, res) => {
    try {
        console.log(res.status);
        const allLocations = await pool.query("SELECT id, city, country FROM hotelchain");
        res.json(allLocations.rows);
    } catch (error) {
        console.log("err " +error.message);
    }
});


app.listen(5000, () => {
    console.log("Server successfully listening on port 5000");
});