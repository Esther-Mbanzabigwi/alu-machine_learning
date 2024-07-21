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
      home: PredictionPage(),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final _tvController = TextEditingController();
  String _result = '';

  Future<void> _predict() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final url =
        'https://regg-api-vgpo.onrender.com/docs#/default/make_prediction_predict_post';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'TV': int.parse(_tvController.text)}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        _result = 'Predicted Price: ${result['predicted_price']}';
      });
    } else {
      setState(() {
        _result = 'Error: ${response.reasonPhrase}';
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tvController,
                decoration: InputDecoration(labelText: 'TV Advertising Budget'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final number = int.tryParse(value);
                  if (number == null || number <= 0 || number >= 500) {
                    return 'Please enter a value between 1 and 499';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _predict,
                child: Text('Predict'),
              ),
              SizedBox(height: 16.0),
              Text(_result, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tvController.dispose();
    super.dispose();
  }
}
