import 'package:jaso/src/combinator.dart';

class UseCase {
  final Combinator _combinator = Combinator();
  Future<String> requestCombinate(
      bool is2350, String cho, String joong, String jong) async {
    return _combinator
        .combinateJaso(cho.split(''), joong.split(''), jong.split(''), is2350)
        .join('');
  }
}
