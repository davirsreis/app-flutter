// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: const Color.fromARGB(255, 159, 175, 202),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 14, 56, 122),
          title: Text(r'Havi Wear', style: GoogleFonts.raleway(fontSize: 30)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/historico', (_) => true)
              },
              icon: const Icon(Icons.history),
              color: Colors.white,
              hoverColor: Color.fromARGB(180, 49, 90, 167),
            ),
            IconButton(
              onPressed: () => {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/carrinho', (_) => true)
              },
              icon: const Icon(Icons.shopping_cart),
              color: Colors.white,
              hoverColor: Color.fromARGB(180, 49, 90, 167),
            ),
            //Text('$user'),
            IconButton(
              onPressed: () => {
                PrefsService.logout(),
                Navigator.of(context).pushReplacementNamed('/login')
              },
              icon: const Icon(Icons.logout),
              color: Colors.white,
              hoverColor: Color.fromARGB(180, 49, 90, 167),
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
                  var valuni = roupas[i].valor;
                  var val = roupas[i].valor;

                  //print(value);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ItemPage(tipo, desc, cor, img, valuni, val)));
                  // Navigator.of(context)
                  //     .pushNamedAndRemoveUntil('/itempage', (_) => true);
                },
              ),
              footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text("${roupas[i].descricao}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  // ignore: unnecessary_string_interpolations, prefer_adjacent_string_concatenation
                  subtitle: Text(r"R$ " + "${roupas[i].valor.toString()}",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                  trailing: FloatingActionButton(
                    backgroundColor: Colors.white,
                    hoverColor: Color.fromARGB(255, 159, 175, 202),
                    child: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      var tipo = roupas[i].nome;
                      var desc = roupas[i].descricao;
                      var img = roupas[i].foto;
                      var tamanho = 'M';
                      var qtd = '1';
                      var cor = roupas[i].cor;
                      var val = roupas[i].valor;
                      var valorunitario = val;

                      val.toString();
                      //print(desc.runtimeType);
                      //print(val.runtimeType);
                      servidor
                          .adicionarCarrinho(tipo, desc, img, tamanho, qtd, cor,
                              val, valorunitario)
                          .then((response) {
                        var jsonData =
                            '{"descricao": "$desc","foto": "$img","tamanho": $tamanho, "qtd": $qtd, "cor": $cor, "valor": "$val"}';
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
