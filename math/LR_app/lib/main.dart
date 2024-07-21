import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PredictionPage(),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  bool _isLoading = false;

  Future<void> _predict() async {
    final tvValue = int.tryParse(_controller.text);
    if (tvValue == null || tvValue <= 0) {
      setState(() {
        _result = 'Please enter a valid TV value.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    final url =
        'https://regg-api-vgpo.onrender.com/predict'; // Replace with your actual API URL
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'TV': tvValue}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          _result = 'Predicted Price: ${jsonResponse['predicted_price']}';
        });
      } else {
        setState(() {
          _result = 'Error: ${response.reasonPhrase}';
        });
        debugPrint('Error response: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
      debugPrint('Exception: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Sales Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter TV Marketing Expense',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _predict,
              child: _isLoading ? CircularProgressIndicator() : Text('Predict'),
            ),
            SizedBox(height: 16.0),
            Text(
              _result,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
