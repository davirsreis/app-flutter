import 'package:flutter/material.dart';
import 'package:flutter_aplication/pages/splashPage.dart';
import 'package:flutter_aplication/route.dart';
import 'package:google_fonts/google_fonts.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(context) {
    //operation();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Havi Wear',
      // theme: ThemeData(
      //   textTheme: GoogleFonts.ralewayTextTheme(),
      //   //scaffoldBackgroundColor: const Color(0x143D59),
      //   //backgroundColor: const Color.fromARGB(255, 159, 175, 202),
      //   //primarySwatch: Colors.
      // ),
      theme: ThemeData(
          //textTheme: GoogleFonts.ralewayTextTheme(),
          //primarySwatch: Colors.red,
          //     textTheme: const TextTheme(
          //         subtitle1: const TextStyle(
          //   color: Colors.white,
          // ))
          ),
      routes: routes,
      home: splashPage(),
    );
  }
}
