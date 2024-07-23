import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentPerformanceForm(),
    );
  }
}

class StudentPerformanceForm extends StatefulWidget {
  @override
  _StudentPerformanceFormState createState() => _StudentPerformanceFormState();
}

class _StudentPerformanceFormState extends State<StudentPerformanceForm> {
  final _formKey = GlobalKey<FormState>();

  final _hoursStudiedController = TextEditingController();
  final _previousScoresController = TextEditingController();
  final _extracurricularActivitiesController = TextEditingController();
  final _sleepHoursController = TextEditingController();
  final _sampleQuestionPapersPracticedController = TextEditingController();

  Future<void> _submitData() async {
    final url = 'http://127.0.0.1:8000/predict';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'hours_studied': double.parse(_hoursStudiedController.text),
        'previous_scores': double.parse(_previousScoresController.text),
        'extracurricular_activities': _extracurricularActivitiesController.text,
        'sleep_hours': double.parse(_sleepHoursController.text),
        'sample_question_papers_practiced':
            int.parse(_sampleQuestionPapersPracticedController.text),
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final prediction = responseData['prediction'];

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Prediction'),
          content: Text('The predicted performance index is $prediction'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    } else {
      throw Exception('Failed to load prediction');
    }
  }

  @override
  void dispose() {
    _hoursStudiedController.dispose();
    _previousScoresController.dispose();
    _extracurricularActivitiesController.dispose();
    _sleepHoursController.dispose();
    _sampleQuestionPapersPracticedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Performance Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _hoursStudiedController,
                decoration: InputDecoration(labelText: 'Hours Studied'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter hours studied';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _previousScoresController,
                decoration: InputDecoration(labelText: 'Previous Scores'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter previous scores';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _extracurricularActivitiesController,
                decoration: InputDecoration(
                    labelText: 'Extracurricular Activities (Yes/No)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter extracurricular activities';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sleepHoursController,
                decoration: InputDecoration(labelText: 'Sleep Hours'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sleep hours';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sampleQuestionPapersPracticedController,
                decoration: InputDecoration(
                    labelText: 'Sample Question Papers Practiced'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sample question papers practiced';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitData();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
