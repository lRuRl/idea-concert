const express = require('express');
// import service here
const ArticleService = require('../../../services/article/article');
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
    router.post('/', async (req, res) => {
        const { status, result } = await articleService.post(req.body);
        return res.status(status).send(result);
    });
    // 2) R[Read]
    router.get('/', async (req, res) => {
        const {status, result} = await articleService.readAll();
        return res.status(status).send(result);
    })
    router.get('/:id', async(req, res) => {
        const {status, result} = await articleService.readOne(req.params.id);
        return res.status(status).send(result);
    })
    // 3) U[Update]
    router.patch('/:id', async (req, res) => {
        console.log(req.params.id)
        const {status, result} = await articleService.update(req.params.id, req.body);
        return res.status(status).send(result);
    })
    // 4) D[Delete]
    router.delete('/:id', async (req, res) => {
        const {status, result} = await articleService.delete(req.params.id);
        return res.status(status).send(result);
    })
}