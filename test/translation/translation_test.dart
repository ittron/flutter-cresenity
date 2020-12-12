




import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_cresenity/cf.dart';

void main() {



  test("Test basic", (){
    expect(CF.translation != null, true);
    expect(CF.translator!=null, true);
  });

  test("Test translator", (){
    CF.translation.loadRepository("en_US", {
      'accepted' : 'The :attribute must be accepted.',
      'active_url' : 'The :attribute is not a valid URL.',
      'after' : 'The :attribute must be a date after :date.',
      'after_or_equal' : 'The :attribute must be a date after or equal to :date.',
      'alpha' : 'The :attribute may only contain letters.',
      'alpha_dash' : 'The :attribute may only contain letters, numbers, dashes and underscores.',
      'alpha_num' : 'The :attribute may only contain letters and numbers.',
      'array' : 'The :attribute must be an array.',
      'before' : 'The :attribute must be a date before :date.',
      'before_or_equal' : 'The :attribute must be a date before or equal to :date.',
    });
    expect(CF.translator.get('accepted',{'attribute':'terms'}), 'The terms must be accepted.');
  });
}