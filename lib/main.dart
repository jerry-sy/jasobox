import 'package:flutter/material.dart';
import 'package:jaso/src/use_case.dart';

void main() {
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
  State<StatefulWidget> createState() => _JasoHomeState();
}

class _JasoHomeState extends State<JasoHome> {
  int _resultCount = 0;
  bool _is2350 = false;
  final _choController = TextEditingController();
  final _joongController = TextEditingController();
  final _jongController = TextEditingController();
  final _resultTextController = TextEditingController();
  final _useCase = UseCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('자소조합기'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _getInputWidget(context),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: _is2350,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == null) _is2350 = false;
                            _is2350 = value!;
                          });
                        }),
                    const Text('2350자만 추출 (CP949 encoding)')
                  ],
                ),
              ),
              SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        String result = await _useCase.requestCombinate(
                            _is2350,
                            _choController.text,
                            _joongController.text,
                            _jongController.text);
                        setState(() {
                          _resultTextController.text = result;
                          _resultCount = result.length;
                        });
                      },
                      child: const Text('추출하기'))),
              SizedBox(
                  width: 1000,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Clear')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Save as .txt')),
                  )
                ],
              )
            ],
          ),
        ));
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
