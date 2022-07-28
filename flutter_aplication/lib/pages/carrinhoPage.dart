// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';
import 'package:flutter_aplication/pages/itemPage.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:intl/intl.dart';

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

final List<Map<String, dynamic>> _sizes = [
  {
    'value': 'P',
    'label': 'P',
  },
  {
    'value': 'M',
    'label': 'M',
  },
  {
    'value': 'G',
    'label': 'G',
  },
];

class CarrinhoPageState extends State<CarrinhoPage> {
  var itens = [];
  var valortotal = 0.0;
  var frete = 20.0;
  var valorfinal = 0.0;

  var fdesc = '';
  var fimg = '';
  var ftamanho = '';
  var fqtd = '';

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
              onPressed: () => Navigator.of(context)
                  .pushNamedAndRemoveUntil('/carrinho', (_) => true),
              icon: Icon(Icons.refresh),
            ),
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

          // fdesc.insert(i, itens[i].descricao);
          // fimg.insert(i, itens[i].foto);
          // ftamanho.insert(i, itens[i].tamanho);
          // fqtd.insert(i, itens[i].quantidade);

          fdesc = itens[i].descricao;
          fimg = itens[i].foto;
          ftamanho = itens[i].tamanho;
          fqtd = itens[i].quantidade;

          var val = itens[i].valor;
          var valunitario = itens[i].valor;
          val.toString();
          // itens[i].descricao.length <= 10
          //     ? itens[i].descricao
          //     : itens[i].descricao.substring(0, 10) + "...";
          valortotal += double.parse(itens[i].valor);
          return ListTile(
              //key: ValueKey(itens[i]),
              leading: Image.network(
                foto,
              ),
              title: Row(children: [
                Text(('${itens[i].descricao}'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const Text(' Tamanho: ', style: TextStyle(fontSize: 16)),
                Text('${itens[i].tamanho}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const Text(' Quantidade: ',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                Text('${itens[i].quantidade}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ]),
              onTap: () {
                var tipo = itens[i].nome;
                var desc = itens[i].descricao;
                var cor = itens[i].cor;
                var img = itens[i].foto;
                var val = itens[i].valor;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemPage(tipo, desc, cor, img, val)));
              },
              // ignore: unnecessary_string_interpolations, prefer_adjacent_string_concatenation
              subtitle: Text(r"R$ " + "${itens[i].valor.toString()}",
                  style: const TextStyle(
                      fontSize: 14,
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
                    // ignore: avoid_print
                    print(valortotal);
                    //print('finalizar compra');
                    valorfinal = valortotal + frete;

                    // ignore: unnecessary_new, avoid_print
                    print(new DateTime.now());
                    DateTime now = DateTime.now();
                    String formattedDate =
                        DateFormat('yyyy-MM-dd – kk:mm').format(now);
                    print(formattedDate);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar compra'),
                            content:
                                // ignore: prefer_adjacent_string_concatenation
                                Text(
                              // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
                              r'Valor da compra: R$ ' +
                                  '$valortotal' +
                                  '\n' +
                                  r'Frete: R$ ' +
                                  '$frete' +
                                  '\n' +
                                  r'Valor Final: R$ ' +
                                  '$valorfinal',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Aprovar'),
                                onPressed: () async {
                                  //print(desc.runtimeType);
                                  //print(val.runtimeType);
                                  print(fdesc);
                                  print(fdesc.length);

                                  // Navigator.pushNamedAndRemoveUntil(
                                  //     context, '/homepage', (route) => false);
                                  Navigator.of(context).pop();
                                  servidor.limparCarrinho();

                                  Timer(Duration(seconds: 3), () {
                                    servidor
                                        .finalizarCompra(fdesc, fimg, ftamanho,
                                            fqtd, '$valorfinal', formattedDate)
                                        .then((response) {
                                      var jsonData =
                                          '{"descricao": "$fdesc","foto": "$fimg", "tamanho": $ftamanho, "quantidade": $fqtd, "valor": "$valorfinal", "data": $formattedDate}';
                                      var parsedJson = json.decode(jsonData);

                                      print(
                                          '${parsedJson.runtimeType} : $parsedJson');
                                    });
                                  });
                                },
                              ),
                            ],
                          );
                        });
                  } catch (e) {
                    print(e);
                  }
                });
              }),
        ])
      ],
    );
  }

  atualizar() {
    super.setState(() {});
  }
}
