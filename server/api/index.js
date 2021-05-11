// init router
const router = require('express').Router({ caseSensitive: true });

// custom routes
const article = require('./routes/article');

module.exports = () => {
    const app = router;
    // routes added here
    article(app);

    return app;
}