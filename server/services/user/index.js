// get model
const User = require('../../models/user');
const { onPostSuccess, onPostFailure, onGetSuccess, onGetFailure, onGetNotFound, onUpdateSuccess, onUpdateNotFound, onUpdateFailure, onDeleteFailure, onDeleteNotFound, onDeleteSuccess } = require('../../types/service-return');
const { File, UserImage, UserImageChunk, FileChunk } = require('../../models/file');

module.exports = class UserService {
    // constructor
    constructor() { }

    /**
     *  functions
     *  1) user profile upload  -> POST
     *  2) user profile read    -> GET
     *      - get by id
     *      - get all
     *  3) user profile update  -> PATCH
     *      - texture : top of the screen
     *      - file : upload / update
     *  4) user profile delete  -> DELETE
     *      - expire user info  -> DELETE ALL INFO in _id
     *      - delete uploaded portfolio file
     */
    // 1) POST : new User to application [ SIGN-UP ]
    post = async (body) => {
        try {
            // from data
            const {
                id, pw, info
            } = body;
            const {
                name, phoneNumber, roles
            } = info;
            // create object
            const uploadData = await User.create({
                id: id,
                pw: pw,
                info: {
                    name: name,
                    phoneNumber: phoneNumber,
                    rolse: roles != null ? JSON.parse(roles) : [],
                    // set null leftovers
                    nickname : null,
                    programs : [],
                    location : null,
                    desc: null,
                    genres: [],
                    career: null
                },
                /**
                 *  @param portfolio    init null : pdf, docx, ...
                 *  @param image        init null : profile image
                 *  @param hasSigned    init null : true, if user has signed digital autography
                 */
                portfolio: null,
                image : null,
                hasSigned : false
            });
            // db query
            const res = await uploadData.save();
            return onPostSuccess(res);
        } catch (error) {
            console.error(error);
            return onPostFailure(error);
        }
    }
    // 2-1) GET : read by id
    readOne = async (id) => {
        try {
            const res = await User.findById(id);
            if (!res) return onGetNotFound;
            else return onGetSuccess(res);
        } catch (error) {
            console.error(error);
            return onGetFailure(error);
        }
    }
    // 2-2) GET : read all users
    readAll = async () => {
        try {
            const res = await User.find();
            if (!res) return onGetNotFound;
            return onGetSuccess(res);
        } catch (error) {
            console.log(error);
            return onGetFailure(error);
        }
    }
    /**
     *  [ NOTICE ]
     *  all files are recommended to be uploaded up to 256KB
     *  if the file is over 256KB, more than 1 chunks will be generated
     *  and need operation to wrap up all chunks from n:0 to n:k
     *  more codes are in services/article at line 80
     *  @author seunghwanly - 2021-05-26
     */
    // get image from mongodb
    getImage = async (filename) => {
        try {
            // mongoose - model
            const findResult = await UserImage.findOne({ filename: filename });
            // console.log(findResult)
            const { _id } = findResult;
            // convert to ObjectID
            const res = await UserImageChunk.findOne({ files_id: _id });

            if (!res) return onGetNotFound;
            return { status: 200, result: res.data };
        } catch (error) {
            console.log(error);
            return onGetFailure(error);
        }
    }
    // get file from mongodb
    getFile = async (filename) => {
        try {
            // mongoose - model
            const findResult = await File.findOne({ filename: filename });
            const { _id } = findResult;
            const res = await FileChunk.findOne({ files_id: _id });
            if (!res) return onGetNotFound;
            return { status: 200, result: res.data };
        } catch (error) {
            console.error(error);
            return onGetFailure(error);
        }
    }
    // 3-1) PATCH : update only texture
    updateText = async (id, body, img) => {
        try {
            // retrieve data
            const { roles, info } = body;
            // update data
            var updateData;
            if(img === undefined || !img) {
                updateData = {
                    roles: roles,
                    info: info,
                };
            }
            else {
                updateData = {
                    roles: roles,
                    info: info,
                    image: img
                };
            }
            // db query
            const res = await User.findByIdAndUpdate(id, updateData, {
                new: true
            });
            if (!res) return onUpdateNotFound;
            return onUpdateSuccess(body);
        } catch (error) {
            console.error(error);
            return onUpdateFailure(error);
        }
    }
    // 3-2) PATCH : update only portfolio file
    updateFile = async (id, filepath) => {
        try {
            const res = await User.findByIdAndUpdate(id,
                { portfolio: filepath }, { new: true });
            if (!res) return onUpdateNotFound;
            return onUpdateSuccess(res);
        } catch (error) {
            console.error(error);
            return onUpdateFailure(error);
        }
    }
    // 4-1) DELETE : user data
    deleteUser = async (id) => {
        try {
            const res = await User.findByIdAndDelete(id);
            if (!res) return onDeleteNotFound;
            return onDeleteSuccess(res);
        } catch (error) {
            console.error(error);
            return onDeleteFailure(error);
        }
    }
    // 4-2) DELETE : user portfolio
    deletePortfolio = async (id) => {
        // 1. find the file name
        const resUser = await User.findById(id);
        // check user id
        if (!resUser) return onGetNotFound;
        else {
            const { portfolio } = resUser;
            if (!portfolio) return {
                status: 404, result: {
                    message: "User Portfolio is None"
                }
            }
            // 2. find the file in files.files
            const resFile = await File.findOne({ filename: portfolio });
            if (!resFile) return {
                status: 404, result: {
                    message: `Cannot find filename with ${portfolio}`
                }
            };
            // 3. find the file in files.chunks
            const { _id } = resFile;
            const resChunk = await FileChunk.findOneAndDelete({ files_id: _id })
                .then((value) => File.findByIdAndDelete(_id))
                .catch((err) => onDeleteNotFound);
            if (!resChunk) return onDeleteFailure(resChunk);
            return onDeleteSuccess(resChunk);
        }
    }
}