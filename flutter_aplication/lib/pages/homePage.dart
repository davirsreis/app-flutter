// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aplication/pages/loginPage.dart';
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

  

  // @override
  // void initState() {
  //   super.initState();

  //   Future.wait([
  //     PrefsService.isAuth(),
  //     Future.delayed(Duration(seconds: 3)),
  //   ]).then((value) => value[0]
  //   ? Navigator.of(context).pushReplacementNamed('/')
  //   : Navigator.of(context).pushReplacementNamed('/login'));
  // }

//   _addCart() {
//     servidor.adicionarCarrinho(idProduto).then((response) {

//     idProduto = roupas[i].id;
//     print(idProduto);
//     var jsonData = '{"idProduto": "$idProduto"}';
//     var parsedJson = json.decode(jsonData);
//     print('${parsedJson.runtimeType} : $parsedJson');

//   });
// }


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
          IconButton(onPressed: () => {
          PrefsService.logout(),
          Navigator.of(context).pushReplacementNamed('/carrinho')
        }, icon: const Icon(Icons.shopping_cart),),
        IconButton(onPressed: () => {
          PrefsService.logout(),
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => true)
        }, icon: const Icon(Icons.logout),)
        ]
      ),
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
            child: Image.network(foto,fit: BoxFit.cover,),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text("${roupas[i].descricao}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text("Valor: ${roupas[i].valor}",
                style: const TextStyle(fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold)),
              trailing: FloatingActionButton(
                backgroundColor: Colors.white,
                hoverColor: Colors.red,
                child: const Icon(Icons.shopping_cart),
                onPressed: () {

                  var desc = roupas[i].descricao;
                  var val = roupas[i].valor;
                  val.toString();
                  print(desc.runtimeType);
                  print(val.runtimeType);
                  servidor.adicionarCarrinho(desc, val).then((response) {
                  
                  var jsonData = '{"descricao": "$desc", "valor": "$val"}';
                  var parsedJson = json.decode(jsonData);
                  //print('${parsedJson.runtimeType} : $parsedJson');
                  });


                      // print("Id produto: ${roupas[i]._id}");
                      // servidor.comprar(roupas[i].id).then((response) {
                      // }); 
                  },
              )

            )
          );
        },
      ),
    );
  }
          
}
