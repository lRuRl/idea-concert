// for mongodb init
const mongoose = require('mongoose');
const { config } = require('../config');

module.exports = async () => {
    // using native Promise from node.js
    mongoose.Promise = global.Promise;
    // connection
    const connect = await mongoose.connect(config.dbURI, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        useFindAndModify: false
    });

    return connect.connection.db;
}
