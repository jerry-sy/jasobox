import 'dart:convert';

import 'package:jaso/src/code_list.dart' show tableKSC5601;

/**
 * 출처 : https://github.com/eususu/cp949_dart
 */

class CP949Decoder extends Converter<List<int>, String> {
  @override
  convert(input) {
    StringBuffer out = StringBuffer();
    int c1, c2;

    c1 = 0;
    c2 = 0;
    for (var ch in input) {
      if (ch < 128) {
        out.writeCharCode(ch);
        c1 = 0;
        break;
      }

      if (c1 == 0) {
        c1 = ch;
      } else {
        c2 = ch;

        int i = 94 * (c1 - 0xa1) + (c2 - 0xa1);
        int utf = 0;

        utf = tableKSC5601[i];
        out.writeCharCode(utf);

        c1 = 0;
      }
    }

    return out.toString();
  }
}

class CP949Encoder extends Converter<String, List<int>> {
  @override
  convert(input) {
    List<int> out = <int>[];
    int c1, c2;
    int iter = 0;
    int ch;
    int index;
    int mod;

    for (iter = 0; iter < input.length; ++iter) {
      ch = input.codeUnitAt(iter);
      if (ch < 128) {
        out.add(ch);
        continue;
      }

      index = tableKSC5601.indexOf(ch);
      if (index != -1) {
        mod = (index / 94).floor();
        out.add(mod + 0xa1);
        out.add(index - (mod * 94) + 0xa1);
      }
    }
    return out;
  }
}

class CP949 extends Encoding {
  @override
  String name = "CP949";

  @override
  Converter<List<int>, String> get decoder {
    return new CP949Decoder();
  }

  @override
  Converter<String, List<int>> get encoder => CP949Encoder();
}
