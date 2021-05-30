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
                    applicantMap[`detail.applicant.${pos}`] = uid;
                }
            } else {
                applicantMap[`detail.applicant.${position}`] = uid;
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
    // remove applicant from the article
    deleteApply = async (id, position, uid) => {
        try {
            /**
             *  this function is only available for publishers !
             *  1) one-by-one
             *      removes uid from article-applicant one at a time
             *      simple API ==> ex) ?position=drawMains&uid=user123456
             *  2) multiple
             *      candidate 1 : set < index of position , index of uid >
             *      by setting same index, it would be easier to make object to remove from DB
             *      ex) position = [ 'drawMains', 'drawContis']
             *          uid = ['user123', 'user123', 'user456']
             *      The problem is that troubles in same postion with multi-uid
             *      there can't be any information by using just 2 querys to know like below
             *      ex) remove list
             *      drawMains : [ 'user123', 'user456']
             *      drawContis : [ 'user123']
             *  As this server is made up for demo-version, only handles one-by-one
             *  @author seunghwanly
             *  @since 2021-05-26
             */
            const path = `detail.applicant.${position}`;
            const res = await Article.findByIdAndUpdate(
                id,
                {
                    $pull: {
                        path: uid
                    }
                }
            );
            if (!res) return onUpdateNotFound;
            return onUpdateSuccess(res);
        } catch (error) {
            console.error(error);
            return onUpdateFailure(error);
        }
    }
}