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
    createArticle = async () => {
        try {
            // db query
            const res = await Article.create();
            return { status: 200, result: res };
        } catch (error) {
            console.error(error);
            return { status: 500, result: error };
        }
    }
}