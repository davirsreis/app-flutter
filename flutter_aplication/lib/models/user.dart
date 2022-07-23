import 'package:flutter_aplication/http.dart';

class User {
  String? nome;
  String? senha;
  String? email;

  User(
      {this.nome,
      this.email,
      this.senha});

  User.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
  }
}
