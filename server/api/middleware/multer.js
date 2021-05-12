const util = require('util');
const multer = require('multer');
const GridFsStorage = require("multer-gridfs-storage");
// config
const { config } = require('../../config');
var storage = new GridFsStorage({
    url: config.dbURI,
    options: { useNewUrlParser: true, useUnifiedTopology: true },
    file: (req, file) => {
        if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
            // for thumbnail and profile image
            if (req.baseUrl === '/user') {
                return {
                    bucketName: 'user-images',
                    filename: `${req.params.id}-profile`
                };
            } else {
                return {
                    bucketName: 'article-images',
                    filename: `${req.params.id}-thumbnail`
                }
            }
        } else {
            // expecting only pdf, docx, txt, ... -> portfolio
            return {
                bucketName: 'files',
                filename: `${req.params.id}-${file.originalname}`
            };
        }
    }
});

var upload = multer({ storage: storage }).single('userfile');
var uploadFilesMiddleware = util.promisify(upload);

module.exports = uploadFilesMiddleware;