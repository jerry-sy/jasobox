class Jaso {
  static final List<String> _choArr = [
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

  static final List<String> _doubleChoArr = [
    'ㄲ',
    'ㄸ',
    'ㅃ',
    'ㅆ',
    'ㅉ',
  ];


  static List<String> singleChoArr = _choArr.where((element) => !_doubleChoArr.contains(element)).toList();
  static List<String> doubleChoArr = _doubleChoArr;
  static List<String> choArr = _choArr;




  static const List<String> _joongArr = [
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

  static final List<String> _horizontalJoongArr = [
    'ㅏ',
    'ㅐ',
    'ㅑ',
    'ㅒ',
    'ㅓ',
    'ㅔ',
    'ㅕ',
    'ㅖ',
    'ㅣ'
  ];

  static final List<String> _verticalJoongArr = [
    'ㅗ',
    'ㅛ',
    'ㅜ',
    'ㅠ',
    'ㅡ',
  ];

  static List<String> joongArr = _joongArr;
  static List<String> horizontalJoongArr = _horizontalJoongArr;
  static List<String> verticalJoongArr = _verticalJoongArr;
  static List<String> mixedJoongArr = _joongArr.where((element) => !_horizontalJoongArr.contains(element) && !_verticalJoongArr.contains(element)).toList();

  static const List<String> jongArr = [
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


}
