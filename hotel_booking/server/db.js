const Pool = require("pg").Pool;

const pool = new Pool({
    //replace with local configuration
    user: "postgres",
    
    password: "pompei", 
    host: "localhost",
    port: 5432,
    database: "reservio"
});

module.exports = pool;