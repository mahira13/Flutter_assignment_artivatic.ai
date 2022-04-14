import 'package:assignment_artivatic/views/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Assignment Artivatic',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blueGrey[50],
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Homepage(),
        });
  }
}

//vscode://vscode.github-authentication/did-authenticate?windowid=4&code=7195c6758fb0e29fea4e&state=30d16407-b1da-488e-a66e-6a2a0461fa6c
