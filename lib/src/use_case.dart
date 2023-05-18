import 'package:jaso/src/combinator.dart';
import 'package:flutter/services.dart';

class UseCase {
  final Combinator _combinator = Combinator();

  Future<CombinateResultData> requestCombinate(
      {bool is2350 = false,
      bool is430 = false,
      bool isWithoutJong = false,
      bool isWithJong = false,
      String cho = "",
      String joong = "",
      String jong = ""}) async {
    List<String> inputCho = _combinator.filterValidCho(cho.split(''));
    List<String> inputJoong = _combinator.filterValidJoong(joong.split(''));
    List<String> inputJong = _combinator.getJong(withJong: isWithJong, withoutJong: isWithoutJong, jong: jong.split(''));

    return CombinateResultData(
        inputCho.join(''),
        inputJoong.join(''),
        inputJong.join(''),
        _combinator
            .combinateJaso(
                cho: inputCho,
                joong: inputJoong,
                jong: inputJong,
                useCP949: is2350,
                include430: is430,
                withoutJong: isWithoutJong,
                withJong: isWithJong)
            .join(''));
  }

  String onClickSingleCho() {
    return _combinator.getSingleCho.join();
  }

  String onClickDoubleCho() {
    return _combinator.getDoubleCho.join();
  }

  String onClickHorizontalJoong() {
    return _combinator.getHorizontalJoong.join();
  }

  String onClickVerticalJoong() {
    return _combinator.getVerticalJoong.join();
  }

  String onClickMixedJoong() {
    return _combinator.getMixedJoong.join();
  }

  Future onClickCopyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    // toast
  }
}

class CombinateResultData {
  String inputCho, inputJoong, inputJong, result;

  CombinateResultData(
      this.inputCho, this.inputJoong, this.inputJong, this.result);
}
