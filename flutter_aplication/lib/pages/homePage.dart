// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aplication/pages/loginPage.dart';
import 'package:flutter_aplication/pages/itemPage.dart';
import 'package:flutter_aplication/models/roupa.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

import '../models/roupa.dart';
import '../http.dart';
import '../prefs_service.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/homepage';
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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

  HomePageState() {
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
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: roupas.length,
        itemBuilder: (BuildContext, i) {
          var foto = roupas[i].foto;
          return GridTile(
              key: ValueKey(roupas[i]),
              // ignore: sort_child_properties_last
              child: GestureDetector(
                child: Image.network(
                  foto,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  var tipo = roupas[i].nome;
                  var desc = roupas[i].descricao;
                  var cor = roupas[i].cor;
                  var img = roupas[i].foto;
                  var val = roupas[i].valor;
                  //print(value);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ItemPage(tipo, desc, cor, img, val)));
                  // Navigator.of(context)
                  //     .pushNamedAndRemoveUntil('/itempage', (_) => true);
                },
              ),
              footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text("${roupas[i].descricao}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  // ignore: unnecessary_string_interpolations, prefer_adjacent_string_concatenation
                  subtitle: Text(r"R$ " + "${roupas[i].valor.toString()}",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                  trailing: FloatingActionButton(
                    backgroundColor: Colors.white,
                    hoverColor: Colors.red,
                    child: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      var desc = roupas[i].descricao;
                      var img = roupas[i].foto;
                      var tamanho = 'M';
                      var qtd = '1';
                      var val = roupas[i].valor;
                      val.toString();
                      //print(desc.runtimeType);
                      //print(val.runtimeType);
                      servidor
                          .adicionarCarrinho(desc, img, tamanho, qtd, val)
                          .then((response) {
                        var jsonData =
                            '{"descricao": "$desc","foto": "$img", "valor": "$val"}';
                        var parsedJson = json.decode(jsonData);
                        //print('${parsedJson.runtimeType} : $parsedJson');
                      });

                      // print("Id produto: ${roupas[i]._id}");
                      // servidor.comprar(roupas[i].id).then((response) {
                      // });
                    },
                  )));
        },
      ),
    );
  }
}
