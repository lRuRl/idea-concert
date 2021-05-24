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
    desc: String
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
    // _id
    roles: [String],
    // url or file path
    portfolio: String,
    info: {
        type: infoSchema,
        _id: false
    },
    // added for profile image
    image: String
});

module.exports = mongoose.model('User', userSchema);
