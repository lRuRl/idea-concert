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
    title: String,
    desc: String,
    tags: [String],
    genres: [String],
    prefer: String
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
    period: {
        from: { type: Date, default: Date.now },
        to: { type: Date, default: Date.now }
    },
    condition: {
        // don't create objectID in sub document
        _id: false,
        type: conditionSchema
    },
    content: {
        // don't create objectID in sub document
        _id: false,
        type: contentSchema
    },
    writer: String,
    location: String,
    applicants: [String]
});
// parent document
const articleSchema = new mongoose.Schema({
    // 💡 MongoDB does not allow overwriting the default _id
    imagePath: String,
    members: [{ type: String }],
    contracts: [{ type: String }],
    detail: {
        type: detailSchema,
        // don't create objectID in sub document
        _id: false
    }
});

// export model
module.exports = mongoose.model('Article', articleSchema);