import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Question App',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name!.startsWith('/kb/')) {
          final id = int.parse(settings.name!.replaceFirst('/kb/', ''));
          final question = questions.firstWhere((q) => q.id == id);
          return MaterialPageRoute(
            builder: (context) => QuestionDetail(),
            settings: RouteSettings(arguments: question),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => QuestionList(),
      },
    );
  }
}