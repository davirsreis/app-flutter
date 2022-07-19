import 'package:http/http.dart' as http;

// ignore: unused_import
import 'package:flutter_aplication/pages/cadastroPage.dart';

// ignore: camel_case_types
class servidor {
  static Future listarRoupas() async {
    var url = Uri.http('localhost:8080', '/');
    return await http.get(url);
  }

  static Future comprar(int id) async {
    var url = Uri.http('localhost:8080', '/comprar');
    return await http.post(url, body: {'id': '$id'});
  }

  static Future cadastrarUsuario(String nome, String email, String senha) async {
    var url = Uri.http('localhost:8080', '/cadastro');
    var response = await http.post(url, body: {'nome': nome, 'email': email, 'senha': senha});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }
}
