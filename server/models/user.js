const mongoose = require('mongoose');
const { fileSchema } = require('./file');
const bcrypt = require('bcrypt');

// define schema
const infoSchema = new mongoose.Schema({
    // data from sign-up
    name: String,
    phoneNumber: String,
    // additional information from sign-up
    roles: [String],
    // edit in personal page
    nickname: String,
    programs: [String],
    location: String,
    desc: String,
    genres: [String],
    career: String
});

// TODO: 비밀번호 암호화
// /* Hashing password */
// infoSchema.pre('save', function (next) {
//     const info = this;
//     const saltFactor = 10;
//     bcrypt.genSalt(saltFactor, (err, salt) => { // Salt 생성
//         if (err) return next(err);

//         bcrypt.hash(info.pwd, salt, (err, hash) => {  // Hash생성
//             if (err) return next(err);
//             info.pwd = hash;  // Hash값 pwd에 저장
//             next();
//         });
//     });
// });

const userSchema = new mongoose.Schema({
    // information for sign-in
    // id = email 
    id: {
        type: String,
        required: true
    },
    pw: {
        type: String,
        required: true
    },
    // _id
    info: {
        type: infoSchema,
        _id: false
    },
    // added for profile image
    image: String,
    imageChunk : String,
    // url or file path
    portfolio: String,
    portfolioChunk: String,
    // check for digital sign
    hasSigned: Boolean
});

module.exports = mongoose.model('User', userSchema);
