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
const periodSchema = new mongoose.Schema({
    from: { type: Date, default: Date.now },
    to: { type: Date, default: Date.now }
});
/**
 * status for applicant in article
    * @enum {number}
    * 승인대기 : 0
    * 승인거절 : -1
    * 승인완료 : 1
    * 계약서대기 : 2
    * 계약서작성완료 : 3
 */
const applicantSchema = new mongoose.Schema({
    uid: { type: String, required: true },
    status: { type: Number, required: true }
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
        _id: false,
        type: periodSchema
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
        writeMains: [{ type: applicantSchema, _id: false }],
        writeContis: [{ type: applicantSchema, _id: false }],
        drawMains: [{ type: applicantSchema, _id: false }],
        drawContis: [{ type: applicantSchema, _id: false }],
        drawDessins: [{ type: applicantSchema, _id: false }],
        drawLines: [{ type: applicantSchema, _id: false }],
        drawChars: [{ type: applicantSchema, _id: false }],
        drawColors: [{ type: applicantSchema, _id: false }],
        drawAfters: [{ type: applicantSchema, _id: false }],
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