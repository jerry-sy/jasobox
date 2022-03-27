class Combinator {
  final List<String> _choArr = [
    'ㄱ',
    'ㄲ',
    'ㄴ',
    'ㄷ',
    'ㄸ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅃ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅉ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];
  final List<String> _joongArr = [
    'ㅏ',
    'ㅐ',
    'ㅑ',
    'ㅒ',
    'ㅓ',
    'ㅔ',
    'ㅕ',
    'ㅖ',
    'ㅗ',
    'ㅘ',
    'ㅙ',
    'ㅚ',
    'ㅛ',
    'ㅜ',
    'ㅝ',
    'ㅞ',
    'ㅟ',
    'ㅠ',
    'ㅡ',
    'ㅢ',
    'ㅣ'
  ];
  final List<String> _jongArr = [
    '',
    'ㄱ',
    'ㄲ',
    'ㄳ',
    'ㄴ',
    'ㄵ',
    'ㄶ',
    'ㄷ',
    'ㄹ',
    'ㄺ',
    'ㄻ',
    'ㄼ',
    'ㄽ',
    'ㄾ',
    'ㄿ',
    'ㅀ',
    'ㅁ',
    'ㅂ',
    'ㅄ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];

  List<String> combinateResult(String? cho, String? joong, String? jong) {
    List<int> choList = _getChoCodeList(cho);
    List<int> joongList = _getJoongCodeList(joong);
    List<int> jongList = _getJongCodeList(jong);

    List<String> resultList = [];
    choList.forEach((choCode) {
      joongList.forEach((joongCode) {
        jongList.forEach((jongCode) {
          resultList.add(String.fromCharCode(
              (choCode * 21 + joongCode) * 28 + jongCode + 0xAC00));
        });
      });
    });
    return resultList;
  }

  List<int> _getChoCodeList(String? cho) {
    //input cho가 진짜로 cho라는 전제 (입력 단계에서 초성 검증 필요
    if (cho == null) {
      return _choArr.asMap().keys.toList();
    } else {
      return [_choArr.indexOf(cho)];
    }
  }

  List<int> _getJoongCodeList(String? joong) {
    if (joong == null) {
      return _joongArr.asMap().keys.toList();
    } else {
      return [_joongArr.indexOf(joong)];
    }
  }

  List<int> _getJongCodeList(String? jong) {
    if (jong == null) {
      return _jongArr.asMap().keys.toList();
    } else {
      return [_jongArr.indexOf(jong)];
    }
  }
}
