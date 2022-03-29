import 'package:jaso/src/cp949_converter.dart';
import 'package:jaso/src/jaso_list.dart' show choArr, joongArr, jongArr;

class Combinator {
  List<String> combinateJaso(List<String>? cho, List<String>? joong,
      List<String>? jong, bool useCP949) {
    List<int> choList = _getChoCodeList(cho);
    List<int> joongList = _getJoongCodeList(joong);
    List<int> jongList = _getJongCodeList(jong);

    List<String> resultList = [];
    for (var choCode in choList) {
      for (var joongCode in joongList) {
        for (var jongCode in jongList) {
          resultList.add(String.fromCharCode(
              (choCode * 21 + joongCode) * 28 + jongCode + 0xAC00));
        }
      }
    }
    if (useCP949) {
      return _extract2350(resultList);
    } else {
      return resultList;
    }
  }

  final CP949 _cp = CP949();

  List<String> _extract2350(List<String> fullList) {
    return fullList
        .map((e) => _cp.decode(_cp.encode(e)))
        .where((element) => element.isNotEmpty)
        .toList();
  }

  List<int> _getChoCodeList(List<String>? cho) {
    //TODO INPUT VALID CHECK
    if (cho == null || cho.isEmpty) {
      return choArr.asMap().keys.toList();
    } else {
      return cho.asMap().values.map((e) => choArr.indexOf(e)).toList();
    }
  }

  List<int> _getJoongCodeList(List<String>? joong) {
    //TODO INPUT VALID CHECK
    if (joong == null || joong.isEmpty) {
      return joongArr.asMap().keys.toList();
    } else {
      return joong.asMap().values.map((e) => joongArr.indexOf(e)).toList();
    }
  }

  List<int> _getJongCodeList(List<String>? jong) {
    //TODO INPUT VALID CHECK
    if (jong == null || jong.isEmpty) {
      return jongArr.asMap().keys.toList();
    } else {
      return jong.asMap().values.map((e) => jongArr.indexOf(e)).toList();
    }
  }
}
