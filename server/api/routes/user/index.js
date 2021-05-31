const express = require('express');

const UserService = require('../../../services/user');

const router = express.Router({ caseSensitive: true });

// middleware
const uploadFilesMiddleware = require('../../middleware/multer');

module.exports = (app) => {
    // route path
    app.use('/user', router);

    // service init
    const userService = new UserService();
    // 1) C[Post]
    /**
     *  회원가입을 처음할 때에는 포트폴리오 없이 가입을 진행
     *  입력되는 사항
     *  1) 이름
     *  2) 연락처
     *  3) 포지션(원하는 역할)
     *                          @author seunghwanly
     */
    router.post('/', async (req, res) => {
        const { status, result } = await userService.post(req.body);
        return res.status(status).send(result);
    });
    // 2) R[Get]
    router.get('/', async (req, res) => {
        const { status, result } = await userService.readAll();
        return res.status(status).send(result);
    })
    /** @function signIn */
    router.post('/sign-in', async (req, res) => {
        let { id, pw } = req.body;
        console.log(req.body);

        const { status, result } = await userService.signIn(id, pw);
        return res.status(status).send(result);
    })
    /** @function findUserById */
    router.get('/:id', async (req, res) => {
        const { status, result } = await userService.readOne(req.params.id);
        return res.status(status).send(result);
    })
    /**
     *  ⚠️ Image / File 은 모두 Binary로 전달됩니다 ⚠️ 
     *                          @author seunghwanly
     */
    // get image by filename
    router.get('/download-image/:filename', async (req, res) => {
        // const filename = "609a84c2bc084d78594849d0-docker.jpeg";
        const filename = req.params.filename;
        const { status, result } = await userService.getImage(filename);
        // res.type('jpeg');
        return res.status(status).end(new Buffer.from(result.toString()), 'binary');
    })
    router.get('/download-file/:filename', async (req, res) => {
        const filename = req.params.filename;
        const { status, result } = await userService.getFile(filename);
        return res.status(status).end(new Buffer.from(result.toString(), 'binary'));
    })
    // 파일 업로드는 Patch부터 구현
    // 미들웨어인 uploadFile.single('userfile') 먼저 실행 후 비동기 작업
    /** 🔥 Notice 
     *  upload.single('avatar') 의 매개변수 'avatar'는 form을 통해 전송되는 파일의 name속성을 가져야 함.
     *                                                                @author seunghwanly
     */
    // for text update
    router.patch('/:id', uploadFilesMiddleware, async (req, res) => {
        const file = req.file;
        if (!file) {
            console.log("no profile image");
        }
        const { status, result } = await userService.updateText(req.params.id, req.body, !file ? null : file);
        return res.status(status).send(result);
    })
    router.patch('/upload-user-portfolio/:id', uploadFilesMiddleware, async (req, res) => {
        const file = req.file;
        if (!file) return res.status(400).send({
            message: "[PATCH] file not uploaded !",
            result: ""
        });
        // file path
        const filepath = file.filename;
        // middle ware first
        const { status, result } = await userService.updateFile(req.params.id, filepath);
        return res.status(status).send(result);
    })
    // delete user 
    router.delete('/:id', async (req, res) => {
        const { status, result } = await userService.deleteUser(req.params.id);
        return res.status(status).send(result);
    })
    // delete portfolio
    router.delete('/remove-user-portfolio/:id', async (req, res) => {
        const { status, result } = await userService.deletePortfolio(req.params.id);
        return res.status(status).send(result);
    })
    
}