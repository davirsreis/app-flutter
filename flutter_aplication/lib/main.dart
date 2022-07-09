import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import './pages/CadastroPage.dart';
import './pages/homePage.dart';
import './pages/loginPage.dart';

void main() => runApp(const MyApp());

Future operation() async {
  final connection = PostgreSQLConnection(
  '10.0.2.2',
  5432,
  'flutter-aplication',
  username: 'postgres',
  password: 'davi123'
  );

  try {
    await connection.open();
    print('Connected');
  } catch (e) {
    print('error');
    print(e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(context) {
    operation();
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
