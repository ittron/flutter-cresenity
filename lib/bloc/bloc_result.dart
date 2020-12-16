class BlocResult<T> {
  T _value;

  String _state;

  BlocResult(this._value, [this._state]);

  BlocResult.fromDynamic(dynamic data) {
    if (data is BlocResult) {
      _value = data.value;
      _state = data.state;
    } else {
      _value = data;
    }
  }

  T get value => _value;
  String get state => _state;

  BlocResult<T> setValue(T value) {
    this._value = value;
    return this;
  }

  BlocResult<T> setState(String state) {
    this._state = state;
    return this;
  }
}
