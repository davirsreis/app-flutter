import 'package:flutter/material.dart';

import 'CadastroPage.dart';
import 'homePage.dart';
import 'loginPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Roupas',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/login': (context) => loginPage(),
          '/cadastro': (context) => cadastroPage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          //'/second': (context) => const SecondScreen(),
          //home: HomePage(),
        });
  }
}
