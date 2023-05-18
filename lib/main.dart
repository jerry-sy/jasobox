import 'package:flutter/material.dart';
import 'package:jaso/src/main_ui.dart';
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
        primarySwatch: Colors.grey,
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
  bool _optionExceptJong = false;
  bool _optionWithJong = false;
  final _choController = TextEditingController();
  final _joongController = TextEditingController();
  final _jongController = TextEditingController();
  final _resultTextController = TextEditingController();
  final _useCase = UseCase();
  String _appVersion = '';

  List<Widget> contents() => [
        firstStepColumn(
            // step 1
            _choController,
            _joongController,
            _jongController,
          onClickSingleCho: (){
              _choController.text += _useCase.onClickSingleCho();
          },
          onClickDoubleCho: (){
              _choController.text += _useCase.onClickDoubleCho();
          },
          onClickHorizontalJoong: (){_joongController.text += _useCase.onClickHorizontalJoong();},
          onClickVerticalJoong: (){_joongController.text += _useCase.onClickVerticalJoong();},
          onClickMixedJoong: (){_joongController.text += _useCase.onClickMixedJoong();},
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 550),
          child: Wrap(
            // step 2
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                alignment: Alignment.topLeft,
                decoration: const BoxDecoration(color: Colors.black26),
                child: const Text(
                  'Step2',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    Row(
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
                      children: [
                        Checkbox(
                            value: _optionExceptJong,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == null) _optionExceptJong = false;
                                _optionExceptJong = value!;
                              });
                            }),
                        const Text('종성 없는 글자만 보기')
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: _optionWithJong,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == null) _optionWithJong = false;
                                _optionWithJong = value!;
                              });
                            }),
                        const Text('모든 종성 붙이기')
                      ],
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: const RoundedRectangleBorder(),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(50)),
                              onPressed: () async {
                                CombinateResultData combResult =
                                    await _useCase.requestCombinate(
                                        is2350: _option2350,
                                        is430: _option430,
                                        isWithoutJong: _optionExceptJong,
                                        isWithJong: _optionWithJong,
                                        cho: _choController.text,
                                        joong: _joongController.text,
                                        jong: _jongController.text);
                                setState(() {
                                  _choController.text = combResult.inputCho;
                                  _joongController.text = combResult.inputJoong;
                                  _jongController.text = combResult.inputJong;
                                  _resultTextController.text =
                                      combResult.result;
                                  _resultCount = combResult.result.length;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text('추출하기'),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          // step 3
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.topLeft,
              decoration: const BoxDecoration(color: Colors.black38),
              child: const Text(
                'Step3',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Wrap(
                runSpacing: 20,
                children: [
                  SizedBox(
                      width: 1000,
                      child: TextField(
                        controller: _resultTextController,
                        readOnly: true,
                        maxLines: 15,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      )),
                  Text('글자수 : $_resultCount'),
                  OutlinedButton(
                      style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {

                      },
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        children: const [
                          Icon(Icons.copy),
                          Text(
                            'Copy to Clipboard',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  OutlinedButton(
                      style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        clear();
                      },
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        children: const [
                          Icon(Icons.refresh),
                          Text(
                            'All clear',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  const SizedBox(height: 50.0,),
                  Text('v$_appVersion'),
                  const SizedBox(
                    height: 130,
                  )
                ],
              ),
            ),
          ],
        )
      ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVersion().then((value) => _appVersion = value),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        bool isVertical = MediaQuery.of(context).size.width < 750;
        return Scaffold(
            body: SingleChildScrollView(
          child: isVertical
              ? Column(
                  children: contents(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: contents()
                      .map((e) => Flexible(
                            child: e,
                            flex: 1,
                          ))
                      .toList(),
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
      _optionExceptJong = false;
      _optionWithJong = false;
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
