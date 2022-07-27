import 'package:flutter_aplication/pages/cadastroPage.dart';
import 'package:flutter_aplication/pages/loginPage.dart';
import 'package:flutter_aplication/pages/carrinhoPage.dart';
import 'package:flutter_aplication/pages/itemPage.dart';
import 'package:flutter_aplication/pages/homePage.dart';
import 'package:flutter_aplication/pages/splashPage.dart';

var tipo = '';
var desc = '';
var cor = '';
var img = '';
var val = '';

var routes = {
  // ignore: prefer_const_constructors
  loginPage.routeName: (context) => loginPage(),
  // ignore: prefer_const_constructors
  cadastroPage.routeName: (context) => cadastroPage(),
  HomePage.routeName: (context) => HomePage(),
  CarrinhoPage.routeName: (context) => CarrinhoPage(),
  ItemPage.routeName: (context) => ItemPage(tipo, desc, cor, img, val),
  splashPage.routeName: (context) => splashPage(),
};
