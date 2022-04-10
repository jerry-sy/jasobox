import 'package:flutter/material.dart';
import 'package:jaso/src/use_case.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '자소조합기',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: JasoHome(),
    );
  }
}

class JasoHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JasoHomeState();
  }
}

class _JasoHomeState extends State<JasoHome> {
  int _resultCount = 0;
  bool _option2350 = false;
  bool _option430 = false;
  bool _optionJong = false;
  final _choController = TextEditingController();
  final _joongController = TextEditingController();
  final _jongController = TextEditingController();
  final _resultTextController = TextEditingController();
  final _useCase = UseCase();

  @override
  Widget build(BuildContext context) {
    String _appVersion = '';
    return FutureBuilder(
      future: getVersion().then((value) => _appVersion = value),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('자소조합기'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _getInputWidget(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: _option2350,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == null) _option2350 = false;
                              _option2350 = value!;
                            });
                          }),
                      const Text('2350자 (CP949 encoding)')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: _option430,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == null) _option430 = false;
                              _option430 = value!;
                            });
                          }),
                      const Text('430자 (Adobe-KR-9 collection)')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: _optionJong,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == null) _optionJong = false;
                              _optionJong = value!;
                            });
                          }),
                      const Text('종성 없는 글자만 보기')
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                    child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () async {
                              CombinateResultData combResult =
                                  await _useCase.requestCombinate(
                                      _option2350,
                                      _option430,
                                      _optionJong,
                                      _choController.text,
                                      _joongController.text,
                                      _jongController.text);
                              setState(() {
                                _choController.text = combResult.inputCho;
                                _joongController.text = combResult.inputJoong;
                                _jongController.text = combResult.inputJong;
                                _resultTextController.text = combResult.result;
                                _resultCount = combResult.result.length;
                              });
                            },
                            child: const Text('추출하기'))),
                  ),
                  SizedBox(
                      width: 1000,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('글자수 : $_resultCount'),
                            TextField(
                              controller: _resultTextController,
                              readOnly: true,
                              maxLines: 15,
                              decoration: const InputDecoration(
                                  border: const OutlineInputBorder()),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              onPressed: () {
                                clear();
                              },
                              child: const Text('Clear')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Save as .txt')),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('v$_appVersion'),
                  )
                ],
              ),
            ));
      },
    );
  }

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  void clear() {
    setState(() {
      _resultCount = 0;
      _option2350 = false;
      _option430 = false;
      _choController.clear();
      _joongController.clear();
      _jongController.clear();
      _resultTextController.clear();
    });
  }

  Widget _getInputWidget(BuildContext context) {
    final displayWidth = MediaQuery.of(context).size.width;
    if (displayWidth < 1000) {
      return columnWidget();
    } else {
      return rowWidget();
    }
  }

  Widget rowWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text('초성'),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _choController,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text('중성'),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _joongController,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text('종성'),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _jongController,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget columnWidget() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('초성'),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _choController,
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('중성'),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _joongController,
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('종성'),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _jongController,
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          )
        ],
      );
}
