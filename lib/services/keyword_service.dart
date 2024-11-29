// lib/services/keyword_extraction_service.dart

import 'package:google_generative_ai/google_generative_ai.dart';

class KeywordExtractionService {
  static const apiKey =
      'Your Key'; // Replace with your actual API key

  static Future<List<String>> extract(String text) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );

    final prompt = '''
    Given the following conversation, identify and extract only the product keywords that one person is interested in. Avoid long phrases and focus solely on individual product names or short, specific product types.
    "$text"
    ''';
    final content = [Content.text(prompt)];

    try {
      final response = await model.generateContent(content);
      String keywords = response.text!;
      return keywords.split(','); // Assuming keywords are comma-separated
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

}
