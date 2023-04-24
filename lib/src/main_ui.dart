import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget firstStepColumn(
  TextEditingController choController,
  TextEditingController joongController,
  TextEditingController jongController,
) =>
    Container(
      constraints: const BoxConstraints(minHeight: 550),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(color: Colors.black12),
            child: const Text(
              'Step1',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Wrap(
              runSpacing: 30,
              children: [
                firstStepItem(
                    '초성',
                    choController,
                    subButtonsRow([
                      SubButtonProperty()
                        ..text = '낱자음'
                        ..onClick = () {},
                      SubButtonProperty()
                        ..text = '쌍자음'
                        ..onClick = () {}
                    ])),
                firstStepItem(
                    '중성',
                    joongController,
                    subButtonsRow([
                      SubButtonProperty()
                        ..text = '가로모임'
                        ..onClick = () {},
                      SubButtonProperty()
                        ..text = '세로모임'
                        ..onClick = () {},
                      SubButtonProperty()
                        ..text = '섞임모임'
                        ..onClick = () {},
                    ])),
                firstStepItem('종성', jongController, null),
              ],
            ),
          ),
        ],
      ),
    );

Widget firstStepItem(String? title, TextEditingController textEditingController,
        Widget? subButtons) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        title ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const VerticalDivider(color: Colors.black38),
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (subButtons != null)
          Padding(padding: const EdgeInsets.only(left: 60), child: subButtons)
      ],
    );

class SubButtonProperty {
  String text = "";
  void Function()? onClick;
}

Widget subButtonsRow(List<SubButtonProperty> list) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        children: list
            .map((item) => subButtonItem(item.text, item.onClick ?? () {}))
            .toList(),
      ),
    );

Widget subButtonItem(String text, void Function() onClickItem) => InkWell(
      onTap: () => onClickItem(),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.black38, borderRadius: BorderRadius.zero),
        child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              text = text,
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );

Widget secondStepColumn(list) => Column();
