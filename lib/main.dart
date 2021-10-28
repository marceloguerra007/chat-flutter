import 'package:chat/pages/loading_page.dart';
import 'package:flutter/material.dart';

import 'pages/auth_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}