import 'package:flutter_test/flutter_test.dart';
import 'package:jaso/combinator.dart';

void main() {
  /**
   * 초성 중성 종성을 더해 글자가 완성되어야 한다
   */

  test('ㅎㅏㄴ', () {
    String cho = 'ㅎ';
    String joong = 'ㅏ';
    String jong = 'ㄴ';
    var result = Combinator().combinateResult(cho, joong, jong);
    print(result);
  });

  test('ㅎㅏ', () {
    String cho = 'ㅎ';
    String joong = 'ㅏ';
    var result = Combinator().combinateResult(cho, joong, null);
    print(result.length);
  });

  test('ㅎ', () {
    String cho = 'ㅎ';
    var result = Combinator().combinateResult(cho, null, null);
    print(result.length);
  });
}
