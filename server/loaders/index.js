// express and mongoose
const expressLoader = require('./express');
const mongooseLoader = require('./mongoose');

module.exports = async(app) => {
    // db
    mongooseLoader().then((result) => {
        console.log("MongoDB has initialized !");
    }).catch((err) => {
        console.error(err);
    });
    // express
    expressLoader(app).then((result) => console.log('Express has initialized !'));
}