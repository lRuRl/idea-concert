const express = require('express');
// import service here
const ArticleService = require('../../../services/article');
const uploadFilesMiddleware = require('../../middleware/multer');
// set router
const router = express.Router();

/**
 * @param {*} app - The app from routes/index.js, linked with router
 * this module will be added to parent router with following functions
 * @function
 *  @name articleUpload     - basic CRUD: Create new article
 *  @name aricleReadAll     - basic CRUD: Get all article in DB
 *  @name articleFindById   - get article that matches _id
 *  @name articleUpdate     - basic CRUD: Update article that matches _id
 *  @name deleteArticle     - basic CRUD: Delete article that matches _id
 *  @name applyFunction     - function for apply in article
 * 
 * @returns {*} routes of API
 * @author seunghwanly <seunghwanly@gmail.com>
 */
module.exports = (app) => {
    // route path
    app.use('/articles', router);

    // service - init
    const articleService = new ArticleService();

    /** @function articleUpload */
    router.post('/', uploadFilesMiddleware, async (req, res) => {
        const thumbnail = req.file;
        if (!thumbnail) return res.status(400).send({
            message: "[POST] thumbnail not uploaded !"
        });
        // file path
        const file = thumbnail.filename;
        const { status, result } = await articleService.post(req.body, file);
        return res.status(status).send(result);
    });
    /** @function articleReadAll */
    router.get('/', async (req, res) => {
        console.log('msg received : GET ALL')
        const { status, result } = await articleService.readAll();
        return res.status(status).send(result);
    })
    /** @function articleFindById */
    router.get('/:id', async (req, res) => {
        const { status, result } = await articleService.readOne(req.params.id);
        return res.status(status).send(result);
    })
    /** @function articleUpdate */
    router.patch('/:id', uploadFilesMiddleware, async (req, res) => {
        var file = req.file;
        if (!file) console.log("Thumbnail not uploaded");
        const { status, result } = await articleService.update(req.params.id, req.body, file.filename);
        return res.status(status).send(result);
    })
    /** @function deleteAritcle */
    router.delete('/:id', async (req, res) => {
        const { status, result } = await articleService.delete(req.params.id);
        return res.status(status).send(result);
    })
    /**
     *  extra function except basic CRUD - nested pages
     *  @param {string} req.params.id - Article _id
     *  @param {string | string[]} req.query.position - the position to work on
     *  @param {string} req.query.uid - the user id to work on
     *  @param {boolean} req.query.job - 'new' : add new userid to article, 'delete' : remove userid from article
     */
    /** @function applyFunction */
    router.patch('/apply/:id', async (req, res) => {
        var position = req.query.position;
        var uid = req.query.uid;
        var job = req.query.job;

        if (job === 'new') {
            const { status, result } = await articleService.postApply(req.params.id, position, uid);
            return res.status(status).send(result);
        }
        else if (job === 'delete') {
            const { status, result } = await articleService.deleteApply(req.params.id, position, uid);
            return res.status(status).send(result);
        }
        else return res.status(400).send('wrong info or needes parameter(query) job');
    })
}