


class Str {
  /**
   * 
   */
  static String after(String subject, String search) {

    return search == '' ? subject : subject.split(search).sublist(1).join(search);
  }
}