// lib/screens/product_list_screen.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/product_service.dart';
import '../model/product_model.dart';


class ProductListScreen extends StatefulWidget {
  final String keywords;

  ProductListScreen({required this.keywords});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _searchProducts();
  }

  // Search products based on the keywords passed from the previous screen
  Future<void> _searchProducts() async {
    // final keyword =
    //     widget.keywords.join(' '); // Combine keywords into one search query
    //   print("keyword1213 : "+keyword);
    final productResults = await ProductSearchService.fetchProducts(widget.keywords);

    setState(() {
      products = productResults.map((e) => Product.fromJson(e)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Listings")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? Center(child: Text("No products found for the keywords."))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio:
                          0.7, // Aspect ratio adjusted for compact cards
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(product);
                    },
                  ),
                ),
    );
  }

  // Build a compact product card widget to display product details
  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => ProductSearchService.launchProductUrl(product.link),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Slightly rounded corners
        ),
        elevation: 4.0,
        child: Column(
          children: [
            // Display the product image at the top of the card
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: product.imageUrl.isNotEmpty
                  ? Image.network(
                      product.imageUrl,
                      height: 120.0, // Fixed height for the image
                      width: double.infinity,
                      fit: BoxFit.fitWidth, // Ensure the image is fully shown
                    )
                  : Container(
                      height: 120.0,
                      color: Colors.grey[200],
                      child:
                          Center(child: Icon(Icons.image, color: Colors.grey)),
                    ),
            ),
            // Display the title of the product
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  height: 1.3, // Spacing between lines of text
                ),
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis, // Ensure text does not overflow
              ),
            ),
            // More Info button at the bottom of the card
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ElevatedButton(
                onPressed: () =>
                    ProductSearchService.launchProductUrl(product.link),
                child: Text("More Info"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
        )],
        ),
      ),
    );
  }
}
