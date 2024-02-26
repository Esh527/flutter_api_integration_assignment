import 'package:flutter/material.dart';
import 'package:flutter_api_integration_assignment/model/product.dart';
import 'package:flutter_api_integration_assignment/api/product_service.dart';
import 'package:flutter_api_integration_assignment/screens/product_item.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
   
    await Future.delayed(Duration(seconds: 3));

    
    return ProductService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
           
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            
            return Center(
              child: Text('No products found.'),
            );
          } else {
            
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ProductItem(product: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}