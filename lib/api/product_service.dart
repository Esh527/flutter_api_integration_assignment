import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_api_integration_assignment/model/product.dart';

class ProductService {
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('products')) {
        final List<dynamic> productList = data['products'];
        return productList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Products not found in response');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
