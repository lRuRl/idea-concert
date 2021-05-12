// init router
const router = require('express').Router({ caseSensitive: true });

// custom routes
const article = require('./routes/article');
const user = require('./routes/user');

module.exports = () => {
    const app = router;
    // routes added here
    article(app);
    user(app);

    return app;
}