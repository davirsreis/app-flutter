import 'package:flutter/material.dart';
import 'package:flutter_aplication/pages/splashPage.dart';
import 'package:flutter_aplication/route.dart';
//import 'package:postgres/postgres.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

import './pages/CadastroPage.dart';
import './pages/homePage.dart';
import './pages/loginPage.dart';

void main() => runApp(const MyApp());

class DBConnection {
  static DBConnection? _instance;

  final String _host = "localhost";
  final String _port = "27017";
  final String _dbName = "flutter-db";
  late Db _db;

  static getInstance() {
    if (_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async {
    // ignore: unnecessary_null_comparison
    if (_db == null) {
      try {
        _db = Db(_getConnectionString());
        await _db.open();
      } catch (e) {
        print(e);
      }
    }
    return _db;
  }

  _getConnectionString() {
    return "mongodb://$_host:$_port/$_dbName";
  }

  closeConnection() {
    _db.close();
  }
}

// Future operation() async {
//   final connection = PostgreSQLConnection(
//   '10.0.2.2',
//   5432,
//   'flutter-aplication',
//   username: 'postgres',
//   password: 'davi123'
//   );

//   try {
//     await connection.open();
//     print('Connected');
//   } catch (e) {
//     print('error');
//     print(e.toString());
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(context) {
    //operation();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roupas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: routes,
      home: splashPage(),
    );
  }
}
