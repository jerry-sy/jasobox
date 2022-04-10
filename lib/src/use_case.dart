import 'package:jaso/src/combinator.dart';

class UseCase {
  final Combinator _combinator = Combinator();
  Future<CombinateResultData> requestCombinate(bool is2350, bool is430,
      bool isOnlyJong, String cho, String joong, String jong) async {
    List<String> inputCho = _combinator.filterValidCho(cho.split(''));
    List<String> inputJoong = _combinator.filterValidJoong(joong.split(''));
    List<String> inputJong =
        isOnlyJong ? List.empty() : _combinator.filterValidJong(jong.split(''));

    return CombinateResultData(
        inputCho.join(''),
        inputJoong.join(''),
        inputJong.join(''),
        _combinator
            .combinateJaso(
                inputCho, inputJoong, inputJong, is2350, is430, isOnlyJong)
            .join(''));
  }
}

class CombinateResultData {
  String inputCho, inputJoong, inputJong, result;
  CombinateResultData(
      this.inputCho, this.inputJoong, this.inputJong, this.result);
}
