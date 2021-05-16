const mongoose = require('mongoose');
const { fileSchema } = require('./file');

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
    // url or file path
    portfolio: String,
    info: {
        type: infoSchema,
        _id: false
    },
    // added for profile image
    image : String
});

module.exports = mongoose.model('User', userSchema);
