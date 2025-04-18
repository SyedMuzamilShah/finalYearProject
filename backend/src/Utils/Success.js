export class SuccessResponse {
    constructor(
        statusCode,
        message, 
        data,
    ){
        this.statusCode = statusCode;
        this.message = message;
        this.data = data;
    }

    toJson(){
        return {
            statusCode: this.statusCode,
            message: this.message,
            data: this.data,
        }
    }
}

