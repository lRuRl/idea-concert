const mongoose = require('mongoose');

const fileSchema = new mongoose.Schema({
    length: Number,
    chunkSize: Number,
    uploadDate: Date,
    filename: String,
    md5: String,
    contentType: String
});

const UserImage = mongoose.model('Image', fileSchema, 'user-images.files');
const ArticleImage = mongoose.model('Image', fileSchema, 'article-images.files');
const File = mongoose.model('File', fileSchema, 'files.files');

const chunkSchema = new mongoose.Schema({
    files_id: mongoose.Types.ObjectId,
    n: Number,
    data: Buffer
});

const UserImageChunk = mongoose.model('ImageChunk', chunkSchema, 'user-images.chunks');
const ArticleImageChunk = mongoose.model('ImageChunk', chunkSchema, 'article-images.chunks');
const FileChunk = mongoose.model('FileChunk', chunkSchema, 'files.chunks');

module.exports = {
    File, FileChunk,
    UserImage, UserImageChunk,
    ArticleImage, ArticleImageChunk
};