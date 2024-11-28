// lib/models/product.dart

class Product {
  final String title;
  final String snippet;
  final String link;
  final String imageUrl;

  Product({
    required this.title,
    required this.snippet,
    required this.link,
    required this.imageUrl,
  });

  // Factory constructor to create a Product object from the API response
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'] ?? '',
      snippet: json['snippet'] ?? '',
      link: json['link'] ?? '',
      imageUrl: json['pagemap']?['cse_image']?[0]['src'] ?? '',
    );
  }
}
