import 'package:flutter_test/flutter_test.dart';
import 'package:jaso/combinator.dart';

void main() {
  /**
   * 초성 중성 종성을 더해 글자가 완성되어야 한다
   */

  test('ㅎㅏㄴ', () {
    List<String> cho = ['ㅎ'];
    List<String> joong = ['ㅏ'];
    List<String> jong = ['ㄴ'];
    var result = Combinator().combinateResult(cho, joong, jong);
    print(result);
  });

  test('ㅎㅏ', () {
    List<String> cho = ['ㅎ'];
    List<String> joong = ['ㅏ'];
    var result = Combinator().combinateResult(cho, joong, null);
    print(result.length);
  });

  test('ㅎ', () {
    List<String> cho = ['ㅎ'];
    var result = Combinator().combinateResult(cho, null, null);
    print(result.length);
  });

  test('ㅍ / ㅔ ㅐ ㅖ', () {
    List<String> cho = ['ㅍ'];
    List<String> joong = ['ㅔ', 'ㅐ', 'ㅖ'];
    var result = Combinator().combinateResult(cho, joong, null);
    print(result.length);
  });

  test('ㅍ / ㅔ ㅐ ㅖ / ㄴ', () {
    List<String> cho = ['ㅍ'];
    List<String> joong = ['ㅔ', 'ㅐ', 'ㅖ'];
    List<String> jong = ['ㄴ'];
    var result = Combinator().combinateResult(cho, joong, jong);
    print(result);
  });
}
