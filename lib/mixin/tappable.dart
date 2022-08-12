import '../helper/c.dart';

mixin Tappable {
  /// Call the given function with this instance then return the instance.
  ///
  /// @param  Function|null  $callback
  /// @return mixed
  tap([Function? callback]) {
    if (callback == null) {
      return this;
    }
    return C.tap(this, callback);
  }
}
