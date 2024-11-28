// lib/services/keyword_extraction_service.dart

import 'package:google_generative_ai/google_generative_ai.dart';

class KeywordExtractionService {
  static const apiKey =
      'AIzaSyArlF9xnwq8KTxwFRRD6rkJAqYNU_-fWD4'; // Replace with your actual API key

  static Future<String> extract(String text) async {
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
      // log(response.text!);
      // print("keywords : " + response.text!);
      // Improved logic to parse the response and extract keywords
      String keywords = response.text!;
      return keywords;
    } catch (e) {
      print('Error: $e');
      return "";
    }
  }

  // Helper function to extract keywords from the response
  // static List<String> _extractKeywordsFromResponse(String responseText) {
  //   List<String> lines = responseText.split('\n');

  //   List<String> keywords = lines
  //       .where((line) =>
  //           line.trim().startsWith('*')) // Only keep lines starting with '*'
  //       .map((line) =>
  //           line.replaceFirst('*', '').trim()) // Remove '*' and trim whitespace
  //       .toList();
  //   print("Another Keywords:---" + keywords.toString());
  //   return keywords;
  // }
}
