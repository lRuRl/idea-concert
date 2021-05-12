// for express init
const express = require('express');
const cors = require('cors');

module.exports = async(app) => {
    // set app
    app.get('/status', (req, res) => { res.status(200).end();});
    app.head('/status', (req, res) => { res.status(200).end(); });
    app.enable('trust proxy');

    // CORS issue
    app.use(cors());
    // 💡 deprecated, changed to express @seunghwanly
    // app.use(bodyParser.urlencoded({ extended: false}));
    app.use(express.json());
    app.use(express.urlencoded({extended: false}));
    
    // custom routes
    const routes = require('../api');
    app.use('/', routes());

    return app;
}