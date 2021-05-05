const express = require('express');
// import service here
const ArticleService = require('../../../services/article/article');
// set router
const route = express.Router();

module.exports = (app) => {
    // route path
    app.use('/articles', route);

    // service - init
    const articleService = new ArticleService();
    // TODO : make function and routes
    // 1) C[Create]
    route.post('/', async (req, res) => {
        const { status, result } = await articleService.createArticle();
        if (status === 200) return res.send(result);
        else return res.status(status).send(result);
    });
    // 2) R[Read]
    
    // 3) U[Update]

    // 4) D[Delete]
}