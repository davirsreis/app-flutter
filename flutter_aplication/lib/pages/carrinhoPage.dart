// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aplication/models/compras.dart';
import 'package:flutter_aplication/pages/loginPage.dart';

import '../prefs_service.dart';
import '../models/roupa.dart';
import '../http.dart';

class CarrinhoPage extends StatefulWidget {
  static String routeName = '/carrinho';
  @override
  State<CarrinhoPage> createState() => CarrinhoPageState();
}

class CarrinhoPageState extends State<CarrinhoPage> {
  var itens = [];
  var valortotal = 0.0;
  // static double valortotal = 200.0;
  // valortotal.toString();
  // var roupas = [];
  // int j = 0;

  _getItens() {
    servidor.listarCarrinho().then((response) {
      if (mounted) {
        setState(() {
          Iterable lista = json.decode(response.body);
          itens = lista.map((model) => Item.fromJson(model)).toList();
        });
      }
    });
  }

  Future sleep1() {
    return Future.delayed(const Duration(seconds: 3), () => "3");
  }

  CarrinhoPageState() {
    _getItens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Carrinho',
            style: TextStyle(fontSize: 30),
          ),
          actions: [
            IconButton(
              onPressed: () => {
                PrefsService.logout(),
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (_) => true)
              },
              icon: Icon(Icons.logout),
            )
          ]),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: itens.length,
        itemBuilder: (context, i) {
          var foto = itens[i].foto;
          valortotal += double.parse(itens[i].valor);
          return ListTile(
              //key: ValueKey(itens[i]),
              leading: Image.network(
                foto,
              ),
              title: Text("${itens[i].descricao}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              // ignore: unnecessary_string_interpolations, prefer_adjacent_string_concatenation
              subtitle: Text(r"R$ " + "${itens[i].valor.toString()}",
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                      fontWeight: FontWeight.bold)),
              trailing: FloatingActionButton(
                backgroundColor: Colors.white,
                hoverColor: Colors.red,
                child:
                    const Icon(Icons.remove_shopping_cart, color: Colors.black),
                onPressed: () async {
                  setState(() {
                    var desc = itens[i].descricao;
                    servidor.removerCarrinho(desc).then((response) {
                      var jsonData = '{"descricao": "$desc"';
                      var parsedJson = json.decode(jsonData);
                      //print('${parsedJson.runtimeType} : $parsedJson');
                    });
                  });
                  //_getItens();
                },
              ));
        },
      ),
      persistentFooterButtons: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              child: const Text('Finalizar compra'),
              onPressed: () async {
                setState(() {
                  try {
                    print(valortotal);
                    // for (var j = 0; j < itens.length; j++) {
                    //   print(itens[i].valor);
                    //   valortotal += itens[i].valor.toDouble();
                    // }
                    // ignore: avoid_print
                    print('finalizar compra');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar compra'),
                            content:
                                // ignore: prefer_adjacent_string_concatenation
                                Text(
                              r'Valor total: R$ ' + '$valortotal',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Aprovar'),
                                onPressed: () async {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/homepage', (route) => false);
                                  //Navigator.of(context).pop();
                                  await servidor.limparCarrinho();
                                },
                              ),
                            ],
                          );
                        });

                    //Navigator.pushNamedAndRemoveUntil(
                    //context, '/cadastro', (route) => false);
                  } catch (e) {
                    print(e);
                  }
                });
              }),
        ])
      ],
      //const SizedBox(height: 20),
      //Row(
      // mainAxisAlignment: MainAxisAlignment.center,

      //),
    );
  }
}
