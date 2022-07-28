// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';
import 'package:flutter_aplication/pages/itemPage.dart';
import 'package:flutter_aplication/route.dart';
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
  //var valorunitario = 0.0;

  var fdesc = '';
  var fimg = '';
  var ftamanho = '';
  var fqtd = '';

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
      backgroundColor: const Color.fromARGB(255, 159, 175, 202),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 14, 56, 122),
          title: const Text(
            'Carrinho',
            style: TextStyle(fontSize: 30),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamedAndRemoveUntil('/homepage', (_) => true),
              icon: Icon(Icons.home),
              color: Colors.white,
              hoverColor: Color.fromARGB(180, 49, 90, 167),
            ),
            IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamedAndRemoveUntil('/carrinho', (_) => true),
              icon: Icon(Icons.refresh),
              color: Colors.white,
              hoverColor: Color.fromARGB(180, 49, 90, 167),
            ),
            IconButton(
              onPressed: () => {
                PrefsService.logout(),
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (_) => true)
              },
              icon: Icon(Icons.logout),
              color: Colors.white,
              hoverColor: Color.fromARGB(180, 49, 90, 167),
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
          var valunitario = itens[i].valorunitario;
          valunitario.toString();
          val.toString();
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
                const Text(' Tam: ',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('${itens[i].tamanho}',
                    style: const TextStyle(fontSize: 16)),
                const Text(' Qtd: ',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('${itens[i].quantidade}',
                    style: const TextStyle(fontSize: 16)),
              ]),
              onTap: () {
                var tipo = itens[i].nome;
                var desc = itens[i].descricao;
                var cor = itens[i].cor;
                var img = itens[i].foto;
                var valuni = itens[i].valorunitario;
                var val = itens[i].valor;

                print(itens[i].valorunitario);
                print(itens[i].valor);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemPage(tipo, desc, cor, img, valuni, val)));
              },
              // ignore: unnecessary_string_interpolations, prefer_adjacent_string_concatenation
              subtitle: Text(r"R$ " + "${itens[i].valor.toString()}",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 14, 56, 122),
                      fontWeight: FontWeight.bold)),
              trailing: FloatingActionButton(
                backgroundColor: Colors.white,
                hoverColor: Color.fromARGB(180, 49, 90, 167),
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
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.all(15),
            //padding: EdgeInsets.only(top: 24),
            child: ElevatedButton(
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
                              backgroundColor:
                                  const Color.fromARGB(255, 159, 175, 202),
                              title: const Text(
                                'Confirmar compra',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
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
                                    backgroundColor:
                                        Color.fromARGB(255, 159, 175, 202),
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    'Aprovar',
                                    style: TextStyle(color: Colors.black),
                                  ),
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
                                          .finalizarCompra(
                                              fdesc,
                                              fimg,
                                              ftamanho,
                                              fqtd,
                                              '$valorfinal',
                                              formattedDate)
                                          .then((response) {
                                        var jsonData =
                                            '{"descricao": "$fdesc","foto": "$fimg", "tamanho": $ftamanho, "quantidade": $fqtd, "valor": "$valorfinal","data": $formattedDate}';
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
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 14, 56, 122)),
                )),
          ),
        ])
      ],
    );
  }

  atualizar() {
    super.setState(() {});
  }
}
