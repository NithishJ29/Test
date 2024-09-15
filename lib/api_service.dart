// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   final String authUrl = 'https://dummyjson.com/auth';
//   final String productsUrl = 'https://dummyjson.com/products';

//   Future<Map<String, dynamic>> authenticate(
//       String username, String password) async {
//     if (username.isEmpty || password.isEmpty) {
//       throw ArgumentError('Username and password must not be empty');
//     }

//     final response = await http.post(
//       Uri.parse(authUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'username': username, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to authenticate');
//     }
//   }

//   Future<List<dynamic>> fetchProducts() async {
//     final response = await http.get(Uri.parse(productsUrl));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data['products'] != null) {
//         return data['products'];
//       } else {
//         throw Exception('No products found');
//       }
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }
