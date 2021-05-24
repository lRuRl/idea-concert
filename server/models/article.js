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
    /* 
        지원자를 포지션 별로 담아 낼 수 있어야 하기 때문에 구조 변화를 주어야함
        applicants : {
            write_mains : []
            write_contis : []
            draw_mains : []
            draw_contis : []
            draw_dessins : []
            draw_lines : []
            draw_chars : []
            draw_colors : []
            draw_afters : []
        }
    */
    applicant: {
        writeMains: [{ type: String }],
        writeContis: [{ type: String }],
        drawMains: [{ type: String }],
        drawContis: [{ type: String }],
        drawDessins: [{ type: String }],
        drawLines: [{ type: String }],
        drawChars: [{ type: String }],
        drawColors: [{ type: String }],
        drawAfters: [{ type: String }],
    }
});
// parent document
const articleSchema = new mongoose.Schema({
    // 💡 MongoDB does not allow overwriting the default _id
    imagePath: String,
    image: String,
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