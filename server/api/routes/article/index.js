const express = require('express');
// import service here
const ArticleService = require('../../../services/article');
const uploadFilesMiddleware = require('../../middleware/multer');
// set router
const router = express.Router({// case sensitive routing
    caseSensitive: true
});

module.exports = (app) => {
    // route path
    app.use('/articles', router);

    // service - init
    const articleService = new ArticleService();
    // 1) C[Create] → 
    router.post('/', uploadFilesMiddleware, async (req, res) => {
        const thumbnail = req.file;
        if(!thumbnail) return res.status(400).send({
            message : "[POST] thumbnail not uploaded !"
        });
        // file path
        const file = thumbnail.filename;
        const { status, result } = await articleService.post(req.body, file);
        return res.status(status).send(result);
    });
    // 2) R[Read]
    router.get('/', async (req, res) => {
        const { status, result } = await articleService.readAll();
        return res.status(status).send(result);
    })
    router.get('/:id', async (req, res) => {
        const { status, result } = await articleService.readOne(req.params.id);
        return res.status(status).send(result);
    })
    // 3) U[Update]
    router.patch('/:id', uploadFilesMiddleware, async (req, res) => {
        var file = req.file;
        if(!file) console.log("Thumbnail not uploaded");
        const { status, result } = await articleService.update(req.params.id, req.body, file.filename);
        return res.status(status).send(result);
    })
    // 4) D[Delete]
    router.delete('/:id', async (req, res) => {
        const { status, result } = await articleService.delete(req.params.id);
        return res.status(status).send(result);
    })
}