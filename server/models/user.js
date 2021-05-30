const mongoose = require('mongoose');
const { fileSchema } = require('./file');
const bcrypt = require('bcrypt');

// define schema
const infoSchema = new mongoose.Schema({
    nickname: String,
    password: String,
    phoneNumber: String,
    email: String,
    programs: [String],
    location: String,
    desc: String,
    favorites: [ String],
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
    id : {
        type : String, 
        required : true   
    },
    pw : {
        type : String,
        required: true
    },
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
