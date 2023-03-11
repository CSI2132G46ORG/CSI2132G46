const Pool = require("pg").Pool;

const pool = new Pool({
    user: "postgres",
    //to do
    password: "pompei", 
    host: "localhost",
    port: 5432,
    database: "reservio"
});

module.exports = pool;