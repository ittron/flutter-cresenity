

class BlocResult<T> {
  T _value;

  get value => _value;

  BlocResult<T> setValue(T val) {
    this._value = val;
    return this;
  }
}
