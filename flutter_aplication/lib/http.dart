import 'package:http/http.dart' as http;

// ignore: unused_import
import 'package:flutter_aplication/pages/cadastroPage.dart';

// ignore: camel_case_types
class servidor {
  static Future listarRoupas() async {
    var url = Uri.http('localhost:8080', '/');
    return await http.get(url);
  }

  static Future adicionarCarrinho(
      String nome,
      String descricao,
      String foto,
      String tamanho,
      String quantidade,
      String cor,
      String valor,
      String valorunitario) async {
    var url = Uri.http('localhost:8080', '/addCarrinho');
    var response = await http.post(url, body: {
      'nome': nome,
      'descricao': descricao,
      'foto': foto,
      'tamanho': tamanho,
      'quantidade': quantidade,
      'cor': cor,
      'valor': valor,
      'valorunitario': valorunitario
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }

  static Future removerCarrinho(String descricao) async {
    var url = Uri.http('localhost:8080', '/delItem');
    var response = await http.post(url, body: {'descricao': descricao});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }

  static Future limparCarrinho() async {
    var url = Uri.http('localhost:8080', '/limparCarrinho');
    var response = await http.post(url, body: {});
    print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    return response;
  }

  static Future finalizarCompra(String descricao, String foto, String tamanho,
      String quantidade, String valor, String data) async {
    var url = Uri.http('localhost:8080', '/finalizarCompra');
    var response = await http.post(url, body: {
      'descricao': descricao,
      'foto': foto,
      'tamanho': tamanho,
      'quantidade': quantidade,
      'valor': valor,
      'data': data
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }

  static Future listarCarrinho() async {
    var url = Uri.http('localhost:8080', '/carrinho');
    return await http.get(url);
  }

  static Future listarHistorico() async {
    var url = Uri.http('localhost:8080', '/historico');
    return await http.get(url);
  }

  static Future listarUsuarios() async {
    var url = Uri.http('localhost:8080', '/usuarios');
    return await http.get(url);
  }

  static Future comprar(int id) async {
    var url = Uri.http('localhost:8080', '/comprar');
    return await http.post(url, body: {'id': '$id'});
  }

  static Future cadastrarUsuario(
      String nome, String email, String endereco, String senha) async {
    var url = Uri.http('localhost:8080', '/cadastro');
    var response = await http.post(url, body: {
      'nome': nome,
      'email': email,
      'endereco': endereco,
      'senha': senha
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }

  static Future authUsuario(String email, String senha) async {
    var url = Uri.http('localhost:8080', '/login');
    var response = await http.post(url, body: {'email': email, 'senha': senha});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }
}
