
class ErrorResponse extends Error {
    constructor(statusCode, message = "Something went wrong", errors = undefined, suggestion = undefined) {
        super(message)
        this.statusCode = statusCode
        this.message = message,
        this.errors = errors,
        this.suggestion = suggestion
    }

    toJson(){
        return {
            statusCode: this.statusCode,
            message: this.message,
            errors : this.errors,
            suggestion : this.suggestion
        }
    }
}

export { ErrorResponse }