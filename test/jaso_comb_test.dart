import 'package:flutter_test/flutter_test.dart';
import 'package:jaso/src/combinator.dart';

void main() {
  /**
   * 초성 중성 종성을 더해 글자가 완성되어야 한다
   */
  Combinator combinator = Combinator();

  test('ㅎㅏㄴ', () {
    List<String> cho = ['ㅎ'];
    List<String> joong = ['ㅏ'];
    List<String> jong = ['ㄴ'];
    var result = combinator.combinateJaso(cho, joong, jong, false, false);
    expect(result, ['한']);
  });

  test('ㅎㅏ', () {
    List<String> cho = ['ㅎ'];
    List<String> joong = ['ㅏ'];
    var result = combinator.combinateJaso(cho, joong, null, false, false);
    expect(result.length, 28);
  });

  test('ㅎ', () {
    List<String> cho = ['ㅎ'];
    var result = combinator.combinateJaso(cho, null, null, false, false);
    expect(result.length, 588);
  });

  test('ㅍ / ㅔ ㅐ ㅖ', () {
    List<String> cho = ['ㅍ'];
    List<String> joong = ['ㅔ', 'ㅐ', 'ㅖ'];
    var result = combinator.combinateJaso(cho, joong, null, false, false);
    expect(result.length, 84);
  });

  test('ㅍ / ㅔ ㅐ ㅖ / ㄴ', () {
    List<String> cho = ['ㅍ'];
    List<String> joong = ['ㅔ', 'ㅐ', 'ㅖ'];
    List<String> jong = ['ㄴ'];
    var result = combinator.combinateJaso(cho, joong, jong, false, false);
    expect(result, ['펜', '팬', '폔']);
  });

  test('cp949', () {
    List<String> cho = ['ㅍ'];
    List<String> joong = ['ㅔ', 'ㅐ', 'ㅖ'];
    List<String> jong = ['ㄴ'];
    var result = combinator.combinateJaso(cho, joong, jong, true, false);
    expect(result, ['펜', '팬']);
  });

  test('cp949_2_1', () {
    List<String> cho = ['ㅂ'];
    List<String> joong = ['ㅓ', 'ㅏ'];
    var result = combinator.combinateJaso(cho, joong, null, false, false);
    expect(result.length, 56);
  });

  test('cp949_2_2', () {
    List<String> cho = ['ㅂ'];
    List<String> joong = ['ㅓ', 'ㅏ'];
    var result = combinator.combinateJaso(cho, joong, null, true, false);
    expect(result.length, 26);
  });

  test('2780 옵션 1', () {
    List<String> cho = ['ㅂ'];
    List<String> joong = ['ㅓ', 'ㅏ'];
    var result = combinator.combinateJaso(cho, joong, null, true, true);
    expect(result.length, 32);
  });

  test('2780 옵션 2', () {
    List<String> cho = ['ㅎ'];
    List<String> joong = ['ㅗ', 'ㅛ'];
    var result = combinator.combinateJaso(cho, joong, null, true, true);
    expect(result.length, 16);
  });

  test('430 옵션 1', () {
    List<String> cho = ['ㅂ'];
    List<String> joong = ['ㅓ', 'ㅏ'];
    var result = combinator.combinateJaso(cho, joong, null, false, true);
    print(result);
    expect(result.length, 6);
  });

  test('430 옵션 2', () {
    List<String> cho = ['ㅎ'];
    List<String> joong = ['ㅗ', 'ㅛ'];
    var result = combinator.combinateJaso(cho, joong, null, false, true);
    print(result);
    expect(result.length, 1);
  });
}
