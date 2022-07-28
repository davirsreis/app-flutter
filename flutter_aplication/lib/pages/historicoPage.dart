// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';
import 'package:flutter_aplication/models/historico.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_aplication/models/compras.dart';
import 'package:flutter_aplication/pages/loginPage.dart';

import '../prefs_service.dart';
import '../http.dart';

class HistoricoPage extends StatefulWidget {
  static String routeName = '/historico';
  @override
  State<HistoricoPage> createState() => HistoricoPageState();
}

class HistoricoPageState extends State<HistoricoPage> {
  var itens = [];

  _getItensHistorico() {
    servidor.listarHistorico().then((response) {
      if (mounted) {
        setState(() {
          Iterable lista = json.decode(response.body);
          itens = lista.map((model) => ItemHistorico.fromJson(model)).toList();
        });
      }
    });
  }

  Future sleep1() {
    return Future.delayed(const Duration(seconds: 3), () => "3");
  }

  HistoricoPageState() {
    _getItensHistorico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Histórico de compras',
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

          var val = itens[i].valor;
          val.toString();
          // itens[i].descricao.length <= 10
          //     ? itens[i].descricao
          //     : itens[i].descricao.substring(0, 10) + "...";
          //valortotal += double.parse(itens[i].valor);
          return ListTile(
            //key: ValueKey(itens[i]),
            leading: Image.network(
              foto,
            ),
            title: Row(children: [
              Text(('${itens[i].descricao}'),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(' Tamanho: ${itens[i].tamanho}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(' Quantidade: ${itens[i].quantidade}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold))
            ]),
            // ignore: unnecessary_string_interpolations, prefer_adjacent_string_concatenation
            subtitle: Text(
                r"Valor da compra: R$ " +
                    "${itens[i].valor.toString()}" +
                    " Data: " +
                    "${itens[i].data}",
                style: const TextStyle(fontSize: 14, color: Colors.black)),
          );
        },
      ),
    );
  }

  atualizar() {
    super.setState(() {});
  }
}
