// lib/services/product_search_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // To launch URLs when product is tapped

class ProductSearchService {
  static const apiKey =
      'Your Key Api Key'; // Replace with your Google API key
  static const cx =
      'Custom Search Engine Id'; // Replace with your Custom Search Engine ID

  // Fetch products based on a keyword (query)
  static Future<List<Map<String, dynamic>>> fetchProducts(
      String keyword) async {
    final url =
        'https://www.googleapis.com/customsearch/v1?q=$keyword&key=$apiKey&cx=$cx';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['items'] ?? []);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Open the product URL in a browser
  static Future<void> launchProductUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
