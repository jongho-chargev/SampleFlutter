import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sample_gs/core/extensions.dart';
import 'package:sample_gs/widget/button.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key, required this.title});
  final String title;

  @override
  State<RootPage> createState() => _RootPageState();
  //tes 12123t12312123 1햣
}

class _RootPageState extends State<RootPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      logWithLink();
      _counter++;
    });
  }

  void logWithLink() {
    final stackTrace = StackTrace.current;

    // final frame = stackTrace.frames[0]; // 첫 번째 프레임 선택
    final msg = stackTrace.toString();
    // print(msg);
    'Log message with 2 methods'.log;
    // print('file://lib/sample_gs/main.dart:37');
    // print('package:sample_gs/main.dart:37:7');
    // final file = frame.library;
    // final line = frame.lineNumber;
    // final uri = frame.uri; // 파일 URI
    // // IDE에서 파일을 열 수 있는 링크 생성 (예: VS Code)
    // final vscodeLink = 'vscode://file/${Uri.encodeComponent(uri.path)}:${line}';
    // print('Error occurred in: $vscodeLink');
  }

  Widget dialogWidget() {
    'Log message with3 methods'.log;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('This is the example of showInDialog method',
              style: primaryTextStyle()),
          4.height,
          Text('Secondary text here', style: secondaryTextStyle()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    'Log message with 2 methods'.log;
    // logger.d('Log message with 2 methods');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppButton(
              text: 'Right to Left',
              onTap: () async {
                showInDialog(context,
                    builder: (_) => dialogWidget(),
                    dialogAnimation: DialogAnimation.SLIDE_RIGHT_LEFT);
              },
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            20.height,
            Button(ontap: () {}).padding(vertical: 30).center(),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
