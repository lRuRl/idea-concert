const { onPostSuccess, onPostFailure, onGetFailure, onGetSuccess, onUpdateSuccess, onUpdateFailure, onUpdateFailureNotFound, onDeleteSuccess, onDeleteNotFound } = require('../../types/service-return');
// get model
const Article = require('../../models/articles/article');

module.exports = class ArticleSerive {
    // constructor
    constructor() { }

    // functions
    /**
     *  TODO : 
     *      1) C : Create Article
     *      2) R : Read Article
     *      3) U : Update Article
     *      4) D : Delete Article
     */
    post = async (body) => {
        try {
            const {
                members, contracts, detail
            } = body;
            // create object
            const uploadData = await Article.create({
                members: members,
                contracts: contracts,
                detail: detail
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
            return onGetSuccess(res);
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
    update = async (id, body) => {
        try {
            // parse
            const {
                members, contracts, detail
            } = body;
            // update data
            const updateData = {
                members: members,
                contracts: contracts,
                detail: detail
            };
            console.log(JSON.stringify(updateData))
            // db query
            await Article.findByIdAndUpdate(id, updateData, {
                new: true,
            });
            return onUpdateSuccess(body);
        } catch (error) {
            console.error(error);
            return onUpdateFailure(err);
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
            return onUpdateFailure(error);
        }
    }
}