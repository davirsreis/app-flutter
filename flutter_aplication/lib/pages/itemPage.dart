// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aplication/pages/loginPage.dart';
import 'package:flutter_aplication/models/roupa.dart';
import 'package:flutter_aplication/pages/homePage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

import '../models/roupa.dart';
import '../http.dart';
import '../prefs_service.dart';

class ItemPage extends StatefulWidget {
  static String routeName = '/itempage';
  String tipo;
  String desc;
  String cor;
  String img;
  String val;
  ItemPage(this.tipo, this.desc, this.cor, this.img, this.val);
  @override
  State<ItemPage> createState() => ItemPageState();
}

class ItemPageState extends State<ItemPage> {
  var roupas = [];

  _getRoupas() {
    servidor.listarRoupas().then((response) {
      if (mounted) {
        setState(() {
          Iterable lista = json.decode(response.body);
          roupas = lista.map((model) => Roupa.fromJson(model)).toList();
        });
      }
    });
  }

  Future sleep1() {
    return Future.delayed(const Duration(seconds: 3), () => "3");
  }

  ItemPageState() {
    _getRoupas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Loja de roupas',
              style: TextStyle(fontSize: 30),
            ),
            actions: [
              IconButton(
                onPressed: () => {
                  PrefsService.logout(),
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/carrinho', (_) => true)
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              IconButton(
                onPressed: () => {
                  PrefsService.logout(),
                  Navigator.of(context).pushReplacementNamed('/login')
                },
                icon: const Icon(Icons.logout),
              )
            ]),
        body: Center(
            child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              widget.desc,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Image.network(
              widget.img,
              width: 400,
            ),
            const Text(
              'Informações do produto',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.tipo} ${widget.cor} com tecido 100% algodão e tratamento Confort que proporciona toque macio.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              (r'Somente R$ ' + widget.val),
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                child: const Text('Adicionar ao carrinho'),
                onPressed: () async {
                  setState(() {
                    try {
                      servidor
                          .adicionarCarrinho(
                              widget.desc, widget.img, widget.val)
                          .then((response) {
                        var jsonData =
                            '{"descricao": "${widget.desc}","foto": "${widget.img}", "valor": "${widget.val}"}';
                        var parsedJson = json.decode(jsonData);
                        //print('${parsedJson.runtimeType} : $parsedJson');
                      });
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Atenção'),
                              content:
                                  // ignore: prefer_adjacent_string_concatenation
                                  const Text(
                                'Seu item foi adicionado ao carrinho!',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Ver carrinho'),
                                  onPressed: () async {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/carrinho', (route) => false);
                                    //Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, '/cadastro', (route) => false);
                    } catch (e) {
                      print(e);
                    }
                  });
                }),
          ],
        )));
  }
}
