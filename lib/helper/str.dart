import 'dart:math';

import 'package:flutter_cresenity/support/array.dart';
import 'package:flutter_cresenity/helper/arr.dart';
import 'package:flutter_cresenity/helper/c.dart';

class Str {
  //make private constructor
  Str._();

  static Map<String, String> _studlyCache = {};
  static Map<String, Map<String, String>> _snakeCache = {};

  /// Return the remainder of a string after the first occurrence of a given value.
  static String after(String subject, String search) {
    return search == ''
        ? subject
        : subject.split(search).sublist(1).join(search);
  }

  /// Generate a more truly "random" alpha-numeric string.
  static String random([int length = 16]) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random.secure();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  ///Convert a string to snake case.
  static snake(String value, [String delimiter = '_']) {
    String key = value;

    if (_snakeCache.containsKey(key) &&
        _snakeCache[key]!.containsKey(delimiter)) {
      return _snakeCache[key]![delimiter];
    }

    value =
        Str.ucwords(value).replaceAll(RegExp(r'\s+', caseSensitive: false), '');
    value = Str.lower(value.replaceAllMapped(
        RegExp(r'(.)(?=[A-Z])', caseSensitive: true), (match) {
      return match.group(1)! + delimiter;
    }));

    if (!_snakeCache.containsKey(key)) {
      _snakeCache[key] = Map<String, String>();
    }

    _snakeCache[key]![delimiter] = value;

    return (_snakeCache[key]![delimiter]);
  }

  ///Convert a value to studly caps case.
  static String studly(String value) {
    String key = value;
    if (_studlyCache.containsKey(key)) {
      return _studlyCache[key]!;
    }

    value = value.replaceAll('-', ' ');
    value = value.replaceAll('_', ' ');
    value = ucwords(value);

    return _studlyCache[key] = value.replaceAll(' ', '');
  }

  static String replace(search, replace, subject) {
    int i = 0, j = 0, sl = 0, fl = 0;
    String temp = '', repl = '';
    bool sa = !(subject is String);

    Array s = Arr.wrap(subject);
    i = 0;
    Array f = Arr.wrap(search);
    Array r = Arr.wrap(replace);

    //int tempCount = 0;

    if (C.isArray(search) && replace is String) {
      //make r become array with same value
      temp = replace;
      replace = new Array();
      for (i = 0; i < search.length; i += 1) {
        replace.add(temp);
      }
      temp = '';
      r = replace;
    }

    i = 0;
    for (sl = s.length; i < sl; i++) {
      if (s[i] == '') {
        continue;
      }
      j = 0;
      for (fl = f.length; j < fl; j++) {
        temp = s[i] + '';
        repl = r[j];

        s[i] = temp.split(f[j]).join(repl);
      }

      //tempCount += ((temp.split(f[j])).length - 1);

    }
    return sa ? s : s[0];
  }

  static String ucwords(String value) {
    return value
        .split(" ")
        .map(
            (e) => e.length > 0 ? "${e[0].toUpperCase()}${e.substring(1)}" : "")
        .join(" ");
  }

  static String trim(String str, [String? charlist]) {
    String? whitespace = charlist;
    if (whitespace == null) {
      whitespace =
          ' \n\r\t\f\x0b\xa0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000';
    } else {
      whitespace = whitespace
          .replaceAllMapped(r'([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])', (Match match) {
        return match.group(1) ?? '';
      });
    }
    int l = str.length;
    for (int i = 0; i < l; i++) {
      if (whitespace.indexOf(str[i]) == -1) {
        str = str.substring(i);
        break;
      }
    }

    l = str.length;
    for (int i = l - 1; i >= 0; i--) {
      if (whitespace.indexOf(str[i]) == -1) {
        str = str.substring(0, i + 1);
        break;
      }
    }
    return whitespace.indexOf(str[0]) == -1 ? str : '';
  }

  static List<String> explode(String delimiter, String string, [int? limit]) {
    if (delimiter == '') return [string];

    var s = string.split(delimiter);
    if (limit == null) {
      return s;
    }

    // Support for limit
    if (limit == 0) {
      limit = 1;
    }
    // Positive limit
    if (limit > 0) {
      if (limit >= s.length) {
        return s;
      }
      List<String> result = s.sublist(0, limit - 1);
      result.addAll([s.sublist(limit - 1).join(delimiter)]);
      return result;
    }

    // Negative limit
    if (-limit >= s.length) return [];
    s = s.sublist(s.length + limit);

    return s;
  }

  static String pregQuote(String str, [String delimiter = '']) {
    return str.replaceAllMapped(
        RegExp(r'([\\\.\+\*\?\[\^\]\$\(\)\{\}\=\!<\>\|\:' + delimiter + '])'),
        (match) {
      return "\\${match.group(0)}";
    });
  }

  static String pregReplace(pattern, String replacement, String subject) {
    if (pattern is String) {
      pattern = new RegExp(pattern);
    }
    return subject.replaceAll(pattern, replacement);
  }

  static List getcsv(String input,
      [String delimiter = ",", String enclosure = '"', String escape = "\\"]) {
    //   example 1: Str,getcsv('"abc","def","ghi"');
    //   returns 1: ['abc', 'def', 'ghi']
    //   example 2: Str.getcsv('"row2""cell1","row2cell2","row2cell3"', null, null, '"');
    //   returns 2: ['row2"cell1', 'row2cell2', 'row2cell3']

    List output = [];
    String Function(String) backwards = (String str) {
      // We need to go backwards to simulate negative look-behind (don't split on
      //an escaped enclosure even if followed by the delimiter and another enclosure mark)
      return str.split('').reversed.join('');
    };
    String Function(String) pq = (String str) {
      // preg_quote()
      return Str.pregQuote(str);
    };

    var pqEnc = pq(enclosure);
    var pqEsc = pq(escape);

    input = input
        .replaceAll(new RegExp(r'^\s*' + pqEnc), '')
        .replaceAll(new RegExp(pqEnc + r'\s*$'), '');

    // PHP behavior may differ by including whitespace even outside of the enclosure
    List inputArray = backwards(input)
        .split(RegExp(pqEnc +
            r'\s*' +
            pq(delimiter) +
            r'\s*' +
            pqEnc +
            r'(?!' +
            pqEsc +
            r')'))
        .reversed
        .toList();

    for (int i = 0, inpLen = inputArray.length; i < inpLen; i++) {
      output.add(backwards(inputArray[i])
          .replaceAll(RegExp(pqEsc + pqEnc), enclosure));
    }

    return output;
  }

  ///Find the position of the first occurrence of a substring in a string
  ///return false when not found
  static dynamic strpos(String haystack, String needle, [int? offset]) {
    //   example 1: strpos('Kevin van Zonneveld', 'e', 5);
    //   returns 1: 14

    var i = haystack.indexOf(needle, (offset ?? 0));
    return i == -1 ? false : i;
  }

  /// Determine if a given string contains a given substring.

  static contains(String haystack, needles) {
    needles = Arr.wrap(needles);
    for (int i = 0; i < needles.length; i++) {
      String needle = needles[i];
      if (needle != '' && strpos(haystack, needle) != false) {
        return true;
      }
    }
    return false;
  }

  ///Determine if a given string matches a given pattern.
  static bool match(pattern, value) {
    if (pattern == null || pattern == '') {
      return false;
    }
    Array patterns = Arr.wrap(pattern);
    for (int i = 0; i < patterns.length; i++) {
      pattern = patterns[i];
      if (pattern == value) {
        return true;
      }
      RegExp regex = new RegExp(Str.replace("\*", ".*", pattern));
      if (regex.hasMatch(value)) {
        return true;
      }
    }
    return false;
  }

  static String upper(String str) {
    return str.toUpperCase();
  }

  static String lower(String str) {
    return str.toLowerCase();
  }

  /// Make a string's first character uppercase.
  static String ucfirst(String string) {
    return Str.upper(Str.substr(string, 0, 1)) + Str.substr(string, 1);
  }

  /// Returns the portion of string specified by the start and length parameters.
  static String substr(String string, int start, [int? length]) {
    int? end = length != null ? length + start : null;
    return string.substring(start, end);
  }

  /// Returns the number of substring occurrences.
  static int substrCount(String haystack, String needle,
      [int offset = 0, int length = 0]) {
    int cnt = 0;

    if (needle.length == 0) {
      return 0;
    }
    offset--;
    while ((offset = haystack.indexOf(needle, offset + 1)) != -1) {
      if (length > 0 && (offset + needle.length) > length) {
        return 0;
      }
      cnt++;
    }
    return cnt;
  }

  /// Begin a string with a single instance of a given value.
  static String start(String value, String prefix) {
    String quoted = pregQuote(prefix, '/');
    return prefix + value.replaceAll(RegExp(r'^(?:' + quoted + ')+'), '');
  }

  /// Determine if a given string is 7 bit ASCII.
  static bool isAscii(String value) {
    return RegExp(r'^[\x00-\x7F]+$').hasMatch(value);
  }

  /// Generate a URL friendly "slug" from a given string.
  static String slug(String title, [String separator = '-']) {
    final _dupeSpaceRegExp = RegExp(r'\s{2,}');
    final _punctuationRegExp = RegExp(r'[^\w\s-]');

    // Convert all dashes/underscores into separator
    String flip = separator == '-' ? '_' : '-';

    title = pregReplace(r'[' + pregQuote(flip) + r']+', separator, title);

    // Replace @ with the word 'at'
    title = replace('@', separator + 'at' + separator, title);

    title = lower(title)
        // Condense whitespaces to 1 space.
        .replaceAll(_dupeSpaceRegExp, ' ')
        // Remove punctuation.
        .replaceAll(_punctuationRegExp, '')
        // Replace space with the delimiter.
        .replaceAll(' ', separator);

    // Replace all separator characters and whitespace by a single separator
    title =
        pregReplace(r'[' + pregQuote(separator) + r'\s]+', separator, title);

    return trim(title, separator);
  }
}
