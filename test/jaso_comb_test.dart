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
    var result =
        combinator.combinateJaso(
            cho: cho,
            joong: joong,
            jong: jong,
            useCP949: false,
            include430: false,
            withoutJong: false);
    expect(result, ['한']);
  });

  test('ㅎㅏ', () {
    List<String> cho = ['ㅎ'];
    List<String> joong = ['ㅏ'];
    var result =
        combinator.combinateJaso(
            cho: cho,
            joong: joong,
            jong: null,
            useCP949: false,
            include430: false,
            withoutJong: false
        );
    expect(result.length, 28);
  });

  test('ㅎ', () {
    List<String> cho = ['ㅎ'];
    var result = combinator.combinateJaso(
        cho: cho,
        joong: null,
        jong: null,
        useCP949: false,
        include430: false,
        withoutJong: false);
    expect(result.length, 588);
  });

  test('ㅍ / ㅔ ㅐ ㅖ', () {
    List<String> cho = ['ㅍ'];
    List<String> joong = ['ㅔ', 'ㅐ', 'ㅖ'];
    var result =
        combinator.combinateJaso(
            cho: cho,
            joong: joong,
            jong: null,
            useCP949: false,
            include430: false,
            withoutJong: false);
    expect(result.length, 84);
  });

  test('ㅍ / ㅔ ㅐ ㅖ / ㄴ', () {
    List<String> cho = ['ㅍ'];
    List<String> joong = ['ㅔ', 'ㅐ', 'ㅖ'];
    List<String> jong = ['ㄴ'];
    var result =
        combinator.combinateJaso(
            cho: cho,
            joong: joong,
            jong: jong,
            useCP949: false,
            include430: false,
            withoutJong: false);
    expect(result, ['펜', '팬', '폔']);
  });

  test('cp949', () {
    List<String> cho = ['ㅍ'];
    List<String> joong = ['ㅔ', 'ㅐ', 'ㅖ'];
    List<String> jong = ['ㄴ'];
    var result = combinator.combinateJaso(
        cho: cho,
        joong: joong,
        jong: jong,
        useCP949: true,
        include430: false,
        withoutJong: false);
    expect(result, ['펜', '팬']);
  });

  test('cp949_2_1', () {
    List<String> cho = ['ㅂ'];
    List<String> joong = ['ㅓ', 'ㅏ'];
    var result =
        combinator.combinateJaso(
            cho: cho,
            joong: joong,
            jong: null,
            useCP949: false,
            include430: false,
            withoutJong: false);
    expect(result.length, 56);
  });

  test('cp949_2_2', () {
    List<String> cho = ['ㅂ'];
    List<String> joong = ['ㅓ', 'ㅏ'];
    var result = combinator.combinateJaso(
        cho: cho,
        joong: joong,
        jong: null,
        useCP949: true,
        include430: false,
        withoutJong: false);
    expect(result.length, 26);
  });

  test('2780 옵션 1', () {
    List<String> cho = ['ㅂ'];
    List<String> joong = ['ㅓ', 'ㅏ'];
    var result = combinator.combinateJaso(
        cho: cho,
        joong: joong,
        jong: null,
        useCP949: true,
        include430: true,
        withoutJong: false
    );
    expect(result.length, 32);
  });

  test('2780 옵션 2', () {
    List<String> cho = ['ㅎ'];
    List<String> joong = ['ㅗ', 'ㅛ'];
    var result = combinator.combinateJaso(
        cho: cho,
        joong: joong,
        jong: null,
        useCP949: true,
        include430: true,
        withoutJong: false);
    expect(result.length, 16);
  });

  test('430 옵션 1', () {
    List<String> cho = ['ㅂ'];
    List<String> joong = ['ㅓ', 'ㅏ'];
    var result = combinator.combinateJaso(
        cho: cho,
        joong: joong,
        jong: null,
        useCP949: false,
        include430: true,
        withoutJong: false);
    print(result);
    expect(result.length, 6);
  });

  test('430 옵션 2', () {
    List<String> cho = ['ㅎ'];
    List<String> joong = ['ㅗ', 'ㅛ'];
    var result = combinator.combinateJaso(
        cho: cho,
        joong: joong,
        jong: null,
        useCP949: false,
        include430: true,
        withoutJong: false
    );
    print(result);
    expect(result.length, 1);
  });

  test('유효한 입력 초성', () {
    List<String> cho = ['ㄱ', 'ㅎ', 'ㅎ'];
    var result = combinator.filterValidCho(cho);
    print(result);
    expect(result.length, 2);
  });

  test('유효한 입력 중성', () {
    List<String> joong = ['ㅗ', 'ㅛ', 'ㅛ', 'ㅛ'];
    var result = combinator.filterValidJoong(joong);
    print(result);
    expect(result.length, 2);
  });

  test('유효한 입력 종성', () {
    List<String> jong = ['ㅇ', 'ㅇ', 'ㅅ', 'ㅅ'];
    var result = combinator.filterValidJong(jong);
    print(result);
    expect(result.length, 2);
  });

  test('종성 없는 글자만 보기 1', () {
    List<String> cho = ['ㅍ'];
    List<String> joong = ['ㅔ', 'ㅐ', 'ㅖ'];
    var result = combinator.combinateJaso(
        cho: cho,
        joong: joong,
        jong: null,
        useCP949: true,
        include430: false,
        withoutJong: true);
    print(result);
    expect(result.length, 3);
  });

  test('종성 없는 글자만 보기 2', () {
    List<String> cho = ['ㅍ'];
    List<String> joong = ['ㅔ', 'ㅐ', 'ㅖ'];
    List<String> jong = ['ㄴ'];
    var result = combinator.combinateJaso(
        cho: cho,
        joong: joong,
        jong: null,
        useCP949: true,
        include430: false,
        withoutJong: true);
    print(result);
    expect(result.length, 3);
  });
}
