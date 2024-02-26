class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(), 
      name: json['name'].toString(), 
      description: json['description'].toString(), 
      price: json['price'].toString(), 
      imageUrl: json['imageUrl'].toString(), 
    );
  }
}
