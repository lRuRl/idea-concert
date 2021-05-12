// express and mongoose
const expressLoader = require('./express');
const mongooseLoader = require('./mongoose');

module.exports = async(app) => {
    // db
    const mongoConnection = await mongooseLoader();
    console.log("MongoDB has initialized !");
    // express
    await expressLoader(app).then((result) => console.log('Express has initialized !'));
}