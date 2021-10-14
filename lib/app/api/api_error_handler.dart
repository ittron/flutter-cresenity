class ApiErrorHandler {
  Function _handler;

  ApiErrorHandler(handler) {
    _handler = _resolveHandler(handler);
  }

  Function _resolveHandler(handler) {
    if (handler == null) {
      return () {};
    }
    if (handler is ApiErrorHandler) {}

    return () {};
  }

  handle() {
    _handler();
  }
}
