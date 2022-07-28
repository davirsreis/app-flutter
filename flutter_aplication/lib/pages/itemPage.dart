// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_aplication/pages/loginPage.dart';
import 'package:flutter_aplication/models/roupa.dart';
import 'package:flutter_aplication/pages/homePage.dart';
import 'package:select_form_field/select_form_field.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

import '../models/roupa.dart';
import '../http.dart';
import '../prefs_service.dart';

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

class ItemPage extends StatefulWidget {
  static String routeName = '/itempage';
  String tipo;
  String desc;
  String cor;
  String img;
  String valuni;
  String val;
  //String size = 'P';
  ItemPage(this.tipo, this.desc, this.cor, this.img, this.valuni, this.val);
  @override
  State<ItemPage> createState() => ItemPageState();
}

class ItemPageState extends State<ItemPage> {
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  var roupas = [];
  int contador = 1;
  String count = '';
  String valorunitario = '';
  String valor = '';
  TextEditingController? _controller;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';

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

  // void initState() {
  //   super.initState();

  //   //_initialValue = 'starValue';
  //   _controller = TextEditingController(text: '2');

  //   _getValue();
  // }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = 'circleValue';
        _controller?.text = 'P';
      });
    });
  }

  ItemPageState() {
    _getRoupas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 159, 175, 202),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 14, 56, 122),
          title: const Text(
            'Loja de roupas',
            style: TextStyle(fontSize: 30),
          ),
          actions: [
            IconButton(
              onPressed: () => {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
              child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                widget.desc,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Image.network(
                widget.img,
                width: 400,
              ),
              const SizedBox(height: 10),
              const Text(
                'Informações do produto',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '${widget.tipo} ${widget.cor} com tecido 100% algodão e tratamento confort que proporciona toque macio.',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                  width: 160,
                  child: Column(
                    children: [
                      SelectFormField(
                        key: _oFormKey,
                        type: SelectFormFieldType.dropdown, // or can be dialog
                        controller: _controller,
                        initialValue: 'P',
                        //icon: Icon(Icons.),
                        labelText: 'Tamanhos',
                        items: _sizes,
                        onChanged: (val) => setState(() => _valueChanged = val),
                        validator: (val) {
                          setState(() => _valueToValidate = val ?? '');
                          return null;
                        },
                        onSaved: (val) =>
                            setState(() => _valueSaved = val ?? ''),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Row(mainAxisSize: MainAxisSize.max, children: [
                          const SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  add();
                                  //print(contador);
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 14, 56, 122)),
                              ),
                              child: const Icon(Icons.add)),
                          const SizedBox(width: 10),
                          Text('$contador',
                              style: const TextStyle(fontSize: 15)),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  remove();
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 14, 56, 122)),
                              ),
                              child: const Icon(Icons.remove)),
                        ]),
                      )
                    ],
                  )),
              const SizedBox(height: 10),
              Text(
                // ignore: prefer_interpolation_to_compose_strings
                (r'Valor unitário R$ ' + widget.valuni),
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Comprar'),
                onPressed: () async {
                  setState(() {
                    try {
                      final loForm = _oFormKey.currentState;
                      loForm?.save();
                      if (_valueChanged == '') {
                        _valueChanged = 'P';
                      }
                      var valortotal = double.parse(widget.valuni) * contador;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 159, 175, 202),
                              title: const Text(
                                'Confirmar',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content:
                                  // ignore: prefer_adjacent_string_concatenation
                                  Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                ('Tamanho: ' +
                                    _valueChanged +
                                    '\nQuantidade: ' +
                                    '$contador' +
                                    '\nValor total: ' +
                                    '$valortotal'),
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    'Adicionar ao carrinho',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    valorunitario = widget.val;
                                    valor = valortotal.toString();
                                    count = contador.toString();
                                    servidor
                                        .adicionarCarrinho(
                                            widget.tipo,
                                            widget.desc,
                                            widget.img,
                                            _valueChanged,
                                            count,
                                            widget.cor,
                                            valor,
                                            valorunitario)
                                        .then((response) {
                                      var jsonData =
                                          '{"nome": ${widget.tipo}, "descricao": "${widget.desc}","foto": "${widget.img}","tamanho": $_valueChanged,"quantidade": $count,"cor": ${widget.cor}, "valor": "$valor", "valorunitario": "$valorunitario"}';
                                      var parsedJson = json.decode(jsonData);
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
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  add() {
    contador += 1;
  }

  remove() {
    if (contador > 1) {
      contador -= 1;
    } else {
      print('error');
    }
  }
}
