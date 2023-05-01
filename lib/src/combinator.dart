import 'package:jaso/src/adobe_kr_9_list.dart' show list_430;
import 'package:jaso/src/cp949_converter.dart';
import 'package:jaso/src/jaso_list.dart';

class Combinator {
  List<String> combinateJaso(List<String>? cho, List<String>? joong,
      List<String>? jong, bool useCP949, bool include430, bool onlyJong) {
    List<int> choList = _getChoCodeList(cho);
    List<int> joongList = _getJoongCodeList(joong);
    List<int> jongList =
        onlyJong ? [Jaso.jongArr.asMap().keys.first] : _getJongCodeList(jong);

    List<String> resultList = [];
    for (var choCode in choList) {
      for (var joongCode in joongList) {
        for (var jongCode in jongList) {
          resultList.add(String.fromCharCode(
              (choCode * 21 + joongCode) * 28 + jongCode + 0xAC00));
        }
      }
    }
    if (useCP949 && include430) {
      return _extract2780(resultList);
    } else if (useCP949 && !include430) {
      return _extract2350(resultList);
    } else if (!useCP949 && include430) {
      return _extract430(resultList);
    } else {
      return resultList;
    }
  }

  final CP949 _cp = CP949();

  List<String> _extract2780(List<String> fullList) {
    /**
     * 2350 + 430 옵션 : CP949 인코딩 + 430자에 해당하는 글자 모두 return
     * @param fullList : 11172자로 추출된 full list
     */
    return fullList
        .map((e) => apply430Option(e))
        .where((element) => element.isNotEmpty)
        .toList();
  }

  String apply430Option(String e) {
    /**
     * 결과 중 430자 해당하는 글자는 그대로 출력되도록 스킵한다
     */
    if (list_430.contains(e)) {
      return e;
    } else {
      return _cp.decode(_cp.encode(e));
    }
  }

  List<String> _extract2350(List<String> fullList) {
    /**
     * 2350 옵션 : CP949 인코딩으로 정상 표현되는 글자만 return
     * @param fullList : 11172자로 추출된 full list
     */
    return fullList
        .map((e) => _cp.decode(_cp.encode(e)))
        .where((element) => element.isNotEmpty)
        .toList();
  }

  List<String> _extract430(List<String> fullList) {
    /**
     * 430 옵션 : 430자에 해당하는 글자만 return
     * @param fullList : 11172자로 추출된 full list
     */
    return fullList.where((element) => list_430.contains(element)).toList();
  }

  List<int> _getChoCodeList(List<String>? cho) {
    if (cho == null || cho.isEmpty) {
      return Jaso.choArr.asMap().keys.toList();
    } else {
      return cho.asMap().values.map((e) => Jaso.choArr.indexOf(e)).toList();
    }
  }

  List<int> _getJoongCodeList(List<String>? joong) {
    if (joong == null || joong.isEmpty) {
      return Jaso.joongArr.asMap().keys.toList();
    } else {
      return joong.asMap().values.map((e) => Jaso.joongArr.indexOf(e)).toList();
    }
  }

  List<int> _getJongCodeList(List<String>? jong) {
    if (jong == null || jong.isEmpty) {
      return Jaso.jongArr.asMap().keys.toList();
    } else {
      return jong.asMap().values.map((e) => Jaso.jongArr.indexOf(e)).toList();
    }
  }

  List<String> filterValidCho(List<String> rawList) {
    return rawList
        .where((element) => Jaso.choArr.contains(element))
        .toSet()
        .toList();
  }

  List<String> filterValidJoong(List<String> rawList) {
    return rawList
        .where((element) => Jaso.joongArr.contains(element))
        .toSet()
        .toList();
  }

  List<String> filterValidJong(List<String> rawList) {
    return rawList
        .toSet()
        .where((element) => Jaso.jongArr.contains(element))
        .toSet()
        .toList();
  }

  List<String> getSingleCho = Jaso.singleChoArr;
  List<String> getDoubleCho = Jaso.doubleChoArr;

  List<String> getHorizontalJoong = Jaso.horizontalJoongArr;
  List<String> getVerticalJoong = Jaso.verticalJoongArr;
  List<String> getMixedJoong = Jaso.mixedJoongArr;
}
