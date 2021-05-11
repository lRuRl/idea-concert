const { config } = require('./config');
const init = require('./loaders');
const express = require('express');

const runServer = async () => {
    // app init with express
    const app = express();
    // loaders
    await init(app);

    app.listen(config.port, error => {
        try {
            console.log(`server is listening on port ${config.port}`)
        } catch (error) {
            console.error(error);
            return;
        }
    });
}
// run
runServer();