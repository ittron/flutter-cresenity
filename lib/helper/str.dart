


class Str {
  /// Return the remainder of a string after the first occurrence of a given value.
  ///
  /// @param subject
  /// @param search
  /// @return The new string after first match
  static String after(String subject, String search) {

    return search == '' ? subject : subject.split(search).sublist(1).join(search);
  }
}