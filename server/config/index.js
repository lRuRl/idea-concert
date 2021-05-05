const dotenv = require('dotenv');
/**
 *  variables of server
 *  author : @seunghwanly
 */
dotenv.config();    // read .env file

exports.config = {
    port: process.env.PORT,
    dbURI : process.env.DB_URI
}