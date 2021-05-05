const { ObjectID } = require('bson');
const mongoose = require('mongoose');

// define schema
// sub document
const conditionSchema = new mongoose.Schema({
    projectType: String,
    contractType: String,
    wage: String
});
// sub document
const contentSchema = new mongoose.Schema({
    introduction: String,
    desc: String,
    tags: [String],
    prefer: String,
    imagePath: String
});
// middle document
const detailSchema = new mongoose.Schema({
    status: String,
    reportedDate: {
        type: Date,
        default: Date.now
    },
    dueDate: {
        type: Date,
        default: Date.now
    },
    periods: [Date],
    condition: conditionSchema,
    content: contentSchema,
    writer: String,
    location: String,
    applicants: [String]
});
// parent document
const articleSchema = new mongoose.Schema({
    // 💡 MongoDB does not allow overwriting the default _id
    // _id: {
    //     type: ObjectID,
    //     required: true,
    //     unique: true
    // },
    members: [String],
    contracts: [String],
    detail: detailSchema
});

// export model
module.exports = mongoose.model('Article', articleSchema);