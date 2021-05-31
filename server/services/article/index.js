const { onPostSuccess, onPostFailure, onGetFailure, onGetSuccess,
    onUpdateSuccess, onUpdateFailure, onUpdateNotFound, onDeleteSuccess,
    onDeleteNotFound, onDeleteFailure, onGetNotFound
} = require('../../types/service-return');
// get model
const Article = require('../../models/article');
const { ArticleImage, ArticleImageChunk } = require('../../models/file');

module.exports = class ArticleSerive {
    // constructor
    constructor() { }

    /**
     *  @function
     *      1) C : Create Article
     *      2) R : Read Article
     *      3) U : Update Article
     *      4) D : Delete Article
     */
    /**
     * post new article
     * @param {object} body - parsed json object from request
     * @param {string} file - The file path that stored in DB
     * @returns {status, result} - set in @borrows onPostSuccess, onPostFailure as result
     */
    post = async (body, file) => {
        try {
            const {
                members, contracts, detail
            } = body;
            const {
                status, reportedDate, dueDate, period, condition, content, writer, location
            } = detail;
            const { title, desc, tags, genres, prefer } = content;
            // create object
            const uploadData = await Article.create({
                imagePath: file,
                image: null,
                members: members != null ? JSON.parse(members) : [],
                contracts: contracts != null ? JSON.parse(contracts) : [],
                detail: {
                    status: status,
                    reportedDate: reportedDate,
                    dueDate: dueDate,
                    period: period,
                    condition: condition,
                    writer: writer,
                    location: location,
                    applicants: {
                        writeMains: [],
                        writeContis: [],
                        drawMains: [],
                        drawContis: [],
                        drawDessins: [],
                        drawLines: [],
                        drawChars: [],
                        drawColors: [],
                        drawAfters: [],
                    },
                    content: {
                        title: title,
                        desc: desc,
                        tags: tags != null ? JSON.parse(tags) : [],
                        genres: genres != null ? JSON.parse(genres) : [],
                        prefer: prefer
                    }
                }
            });
            // db query
            await uploadData.save();
            return onPostSuccess(body);
        } catch (error) {
            console.error(error);
            return onPostFailure(error);
        }
    }
    // read all
    readAll = async () => {
        try {
            // db query
            const res = await Article.find();
            var updatedRes = []
            // get Image
            async function updateImageProperty(res, updatedRes) {
                // iterable
                for (const document of res) {
                    const { imagePath } = document;
                    if (imagePath != null) {
                        const searchImageFile = await ArticleImage.findOne({ filename: imagePath });
                        if (searchImageFile != null) {
                            // get chunks
                            const searchImageChunk = await ArticleImageChunk.find({ files_id: searchImageFile._id });
                            var buffer = '';
                            searchImageChunk.map((doc) => buffer += Buffer.from(doc.data, 'binary').toString('base64'));
                            // put 'image' key and value
                            document['image'] = buffer;
                            updatedRes.push(document);
                            // console.log(JSON.stringify(updatedRes));

                        }
                    } else {
                        updatedRes.push(document);
                    }
                }

                return updatedRes;
            }
            const response = await updateImageProperty(res, updatedRes);
            if (!response) return onGetNotFound;
            return onGetSuccess(updatedRes);
        } catch (error) {
            console.error(error);
            return onGetFailure(err);
        }
    }
    // read specific
    readOne = async (id) => {
        try {
            // db query
            const res = await Article.findById(id);
            return onGetSuccess(res);
        } catch (error) {
            console.error(error);
            return onGetFailure(err);
        }
    }
    // update article
    update = async (id, body, filepath) => {
        try {
            // parse
            const {
                members, contracts, detail
            } = body;

            // update data
            var updateData;
            if (filepath === undefined || !filepath) {
                updateData = {
                    members: members,
                    contracts: contracts,
                    detail: detail
                };
            }
            else {
                updateData = {
                    imagePath: filepath,
                    members: members,
                    contracts: contracts,
                    detail: detail
                };
            }
            // console.log(JSON.stringify(updateData))
            // db query
            const res = await Article.findByIdAndUpdate(id, updateData, {
                new: true,
            });
            if (!res) return onUpdateNotFound;
            return onUpdateSuccess(body);
        } catch (error) {
            console.error(error);
            return onUpdateFailure(error);
        }
    }
    // remove article
    delete = async (id) => {
        try {
            const res = await Article.findByIdAndDelete(id);
            if (!res) return onDeleteNotFound;
            else return onDeleteSuccess(res);
        } catch (error) {
            console.error(error);
            return onDeleteFailure(error);
        }
    }
    // apply for position in article
    postApply = async (id, position, uid) => {
        try {
            // in position array
            var applicantMap = {}

            if (Array.isArray(position)) {
                for (const pos of position) {
                    applicantMap[`detail.applicant.${pos}`] = {
                        uid: uid,
                        status: 0
                    };
                }
            } else {
                applicantMap[`detail.applicant.${position}`] = {
                    uid: uid,
                    status: 0
                };
            }

            const res = await Article.findByIdAndUpdate(
                id,
                {
                    $push: applicantMap
                },
                {
                    "new": true
                }
            );
            if (!res) return onUpdateNotFound;
            return onUpdateSuccess(res);
        } catch (error) {
            console.error(error);
            return onUpdateFailure(error);
        }
    }
    /**
     * @function modifyApplicantStatus -1, 1, 2, 3
     * @param {ObjectId} id        the article object id
     * @param {String} position  the name of position to update
     * @param {String} uid       the uid of applicant to update
     * @param {String} job      the task to modify status -> delete, confirm, contractWait, contractComplete
     * @returns updatedResult
     */
    modifyApply = async (id, position, uid, job) => {
        const modifyMap = { "delete": -1, "confirm": 1, "contractWait": 2, "contractComplete": 3 };
        try {
            const res = await Article.findById(id, function (err, doc) {
                const { applicant } = doc.detail;
                for (let i = 0; i < applicant[position].length; ++i) {
                    if (applicant[position][i].uid === uid) {
                        applicant[position][i].status = modifyMap[job];
                        doc.save(function (err) {
                            if (err) throw err;
                            else return;
                        })
                    }
                }
            });
            if (!res) return onUpdateNotFound;
            return onUpdateSuccess(res);
        } catch (error) {
            console.error(error);
            return onUpdateFailure(error);
        }
    }
}