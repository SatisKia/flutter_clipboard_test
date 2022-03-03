import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  double contentWidth  = 0.0;
  double contentHeight = 0.0;

  String text = '';
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    contentWidth  = MediaQuery.of( context ).size.width;
    contentHeight = MediaQuery.of( context ).size.height - MediaQuery.of( context ).padding.top - MediaQuery.of( context ).padding.bottom;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0
      ),
      body: SingleChildScrollView(
        child: Column( children: [
          Row( children: [
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
              ),
              onPressed: () async {
                // クリップボードから読み出す
                ClipboardData? data = await Clipboard.getData('text/plain');
                if( data != null && data.text != null ){
                  String text = data.text!;
                  textController.text = text;
                }
              },
              child: const Text('読み出し'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
              ),
              onPressed: () async {
                // クリップボードに書き込む
                ClipboardData data = ClipboardData(text: text);
                await Clipboard.setData(data);
              },
              child: const Text('書き込み'),
            ),
          ]),
          TextField(
            controller: textController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: contentWidth / 40,
                  top: 0.0,
                  right: contentWidth / 40,
                  bottom: 0.0),
            ),
            autocorrect: false,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value) {
              text = value;
            },
          ),
        ]),
      ),
    );
  }
}
