import 'package:flutter/material.dart';

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
  String _result = '결과리스트';
  bool _is2350 = false;

  void _getJasoResult() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('자소조합기'),
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
                    Checkbox(value: _is2350, onChanged: (bool? value) {}),
                    Text('2350 어쩌고')
                  ],
                ),
              ),
              SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(onPressed: () {}, child: Text('추출하기'))),
              SizedBox(
                  width: 1000,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('글자수 : '),
                        TextField(
                          readOnly: true,
                          maxLines: 15,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:
                        ElevatedButton(onPressed: () {}, child: Text('Clear')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Save as .txt')),
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
                Text('초성'),
                SizedBox(
                  width: 300,
                  child: TextField(
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
                Text('중성'),
                SizedBox(
                  width: 300,
                  child: TextField(
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
                Text('종성'),
                SizedBox(
                  width: 300,
                  child: TextField(
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
                Text('초성'),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
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
                Text('중성'),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
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
                Text('종성'),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          )
        ],
      );
}
