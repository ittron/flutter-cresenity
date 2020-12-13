


class Hash {

  /// Generates a hash code for multiple [objects].
  static int hashObjects(Iterable objects) =>
      _finish(objects.fold(0, (h, i) => _combine(h, i.hashCode)));

  /// Generates a hash code for two objects.
  static int hash2(a, b) => _finish(_combine(_combine(0, a.hashCode), b.hashCode));

  /// Generates a hash code for three objects.
  static int hash3(a, b, c) => _finish(
      _combine(_combine(_combine(0, a.hashCode), b.hashCode), c.hashCode));

  /// Generates a hash code for four objects.
  static int hash4(a, b, c, d) => _finish(_combine(
      _combine(_combine(_combine(0, a.hashCode), b.hashCode), c.hashCode),
      d.hashCode));

  // Jenkins hash functions

  static int _combine(int hash, int value) {
    hash = 0x1fffffff & (hash + value);
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int _finish(int hash) {
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }

}