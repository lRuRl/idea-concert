var onPostSuccess = (body) => {
    return {
        status: 200,
        result: {
            message: "[POST] msg received",
            result: body
        }
    };
}

var onPostFailure = (err) => {
    return {
        status: 500,
        result: {
            message: "[POST] msg received, failed to save",
            result: err
        }
    };
}

var onGetSuccess = (body) => {
    return {
        status: 200,
        result: {
            message: "[GET] msg received",
            result: body
        }
    };
}

var onGetFailure = (err) => {
    return {
        status: 404,
        result: {
            message: "[GET] msg received, not found",
            result: err
        }
    };
}

var onUpdateSuccess = (body) => ({
    status: 200,
    result: {
        message: "[PATCH] msg received, updated successfully",
        result: body
    }
});

var onUpdateFailure = (err) => ({
    status: 500,
    result: {
        message: "[PATCH] msg received, could not update check id or body",
        result: err
    }
});

var onUpdateFailureNotFound = {
    status: 404,
    result: {
        message: "[PATCH] msg received, id not found",
        result: ""
    }
}

var onDeleteSuccess = (res) => ({
    status: 200,
    result: {
        message: "[DELETE] msg received, deleted successfully",
        result: res
    }
});

var onDeleteFailure = (err) => ({
    status: 500,
    result: {
        message: "[DELETE] msg received, cannot delete",
        result: err
    }
});

var onDeleteNotFound = {
    status: 404,
    result: {
        message: "[DELETE] msg received, not found",
        result: ""
    }
};

// export
module.exports = {
    onPostSuccess, onPostFailure, onGetSuccess, onGetFailure, onUpdateSuccess,
    onUpdateFailure, onUpdateFailureNotFound, onDeleteSuccess, onDeleteFailure, onDeleteNotFound
};