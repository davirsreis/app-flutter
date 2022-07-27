import 'package:flutter_aplication/pages/cadastroPage.dart';
import 'package:flutter_aplication/pages/loginPage.dart';
import 'package:flutter_aplication/pages/carrinhoPage.dart';
import 'package:flutter_aplication/pages/homePage.dart';
import 'package:flutter_aplication/pages/splashPage.dart';

var routes = {
  // ignore: prefer_const_constructors
  loginPage.routeName: (context) => loginPage(),
  // ignore: prefer_const_constructors
  cadastroPage.routeName: (context) => cadastroPage(),
  HomePage.routeName: (context) => HomePage(),
  CarrinhoPage.routeName: (context) => CarrinhoPage(),
  splashPage.routeName: (context) => splashPage(),
};
