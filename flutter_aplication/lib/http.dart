import 'package:http/http.dart' as http;

class servidor {
  static Future listarRoupas() async {
    var url = Uri.http('10.0.2.2:8080', '/');
    return await http.get(url);
  }

  static Future comprar(int id) async {
    var url = Uri.http('10.0.2.2:8080', '/comprar');
    return await http.post(url, body: {'id': '$id'});
  }
}
