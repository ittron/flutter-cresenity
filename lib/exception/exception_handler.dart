


class ExceptionHandler {

  Function _handler;


  ExceptionHandler(this._handler);

  handle(e) {
    return _handler(e);
  }
}