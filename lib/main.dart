// lib/main.dart

import 'package:flutter/material.dart';
import 'services/keyword_service.dart';
import 'screens/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KeywordInputScreen(),
    );
  }
}

class KeywordInputScreen extends StatefulWidget {
  @override
  _KeywordInputScreenState createState() => _KeywordInputScreenState();
}

class _KeywordInputScreenState extends State<KeywordInputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  List<String> keywords = [];

  void _extractKeywords() async {
    final inputText = _controller.text;
    if (inputText.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final extractedKeywords = await KeywordExtractionService.extract(inputText);

    setState(() {
      keywords = extractedKeywords;
      isLoading = false;
    });

    // Navigate to product search screen with extracted keywords
    if (keywords.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductListScreen(keywords: keywords),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Text for Keyword Extraction")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter Text'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : _extractKeywords,
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text('Extract Keywords'),
            ),
          ],
        ),
      ),
    );
  }
}
