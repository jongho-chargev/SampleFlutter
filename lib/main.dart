import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TEST',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('kr')],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  var logger = Logger(
    printer: PrettyPrinter(methodCount: 1, noBoxingByDefault: true),
  );

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

    logger.d('Log message with 2 methods');
    // print('file://lib/sample_gs/main.dart:37');
    // print('package:sample_gs/main.dart:37:7');
    // final file = frame.library;
    // final line = frame.lineNumber;
    // final uri = frame.uri; // 파일 URI
    // // IDE에서 파일을 열 수 있는 링크 생성 (예: VS Code)
    // final vscodeLink = 'vscode://file/${Uri.encodeComponent(uri.path)}:${line}';
    // print('Error occurred in: $vscodeLink');
  }

  @override
  Widget build(BuildContext context) {
    logger.d('Log message with 2 methods');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
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
