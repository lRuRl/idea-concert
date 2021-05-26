const mongoose = require('mongoose');

// define schema
const infoSchema = new mongoose.Schema({
    nickname: String,
    phoneNumber: String,
    email: String,
    programs: [String],
    location: String,
    desc: String
});

const userSchema = new mongoose.Schema({
    // _id
    roles: [String],
    // added for profile image
    image : String,
    // url or file path
    portfolio: String,
    info: {
        type: infoSchema,
        _id: false
    },
    // check for digital sign
    hasSigned : Boolean
});

module.exports = mongoose.model('User', userSchema);
