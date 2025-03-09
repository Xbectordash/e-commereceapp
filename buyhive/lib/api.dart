import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchapi() async {
  
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to load products');
  }
}
