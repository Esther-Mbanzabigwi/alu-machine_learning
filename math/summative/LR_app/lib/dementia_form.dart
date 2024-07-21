import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dementia_result.dart';

class DementiaForm extends StatefulWidget {
  const DementiaForm({super.key});

  @override
  State<DementiaForm> createState() => _DementiaFormState();
}

class _DementiaFormState extends State<DementiaForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController diabeticController = TextEditingController();
  final TextEditingController alcoholLevelController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController bloodOxygenLevelController =
      TextEditingController();
  final TextEditingController bodyTemperatureController =
      TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController mriDelayController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cognitiveTestScoresController =
      TextEditingController();

  String educationLevel = 'Diploma/Degree';
  String dominantHand = 'Right';
  String gender = 'Male';
  String smokingStatus = 'Never Smoked';
  String apoee4 = 'Negative';
  String physicalActivity = 'Moderate Activity';
  String depressionStatus = 'No';
  String medicationHistory = 'No';
  String nutritionDiet = 'Balanced Diet';
  String sleepQuality = 'Good';
  String chronicHealthConditions = 'Diabetes';

  Future<void> handleFormSubmission() async {
    if (_formKey.currentState!.validate()) {
      final dementiaModel = {
        'diabetic': diabeticController.text.toLowerCase() == 'yes' ? '1' : '0',
        'alcoholLevel': double.tryParse(alcoholLevelController.text) ?? 0,
        'heartRate': double.tryParse(heartRateController.text) ?? 0,
        'bloodOxygenLevel':
            double.tryParse(bloodOxygenLevelController.text) ?? 0,
        'bodyTemperature': double.tryParse(bodyTemperatureController.text) ?? 0,
        'weight': double.tryParse(weightController.text) ?? 0,
        'mriDelay': double.tryParse(mriDelayController.text) ?? 0,
        'age': double.tryParse(ageController.text) ?? 0,
        'educationLevel': educationLevel,
        'dominantHand': dominantHand,
        'Gender': gender,
        'Smoking_Status': smokingStatus,
        'APOE_ε4': apoee4,
        'Physical_Activity': physicalActivity,
        'Depression_Status': depressionStatus,
        'Cognitive_Test_Scores':
            double.tryParse(cognitiveTestScoresController.text) ?? 0,
        'Medication_History': medicationHistory,
        'Nutrition_Diet': nutritionDiet,
        'Sleep_Quality': sleepQuality,
        'Chronic_Health_Conditions': chronicHealthConditions,
      };

      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dementiaModel),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DementiaResult(prediction: responseData['prediction']),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to predict dementia.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dementia Prediction Form'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: diabeticController,
                decoration:
                    const InputDecoration(labelText: 'Diabetic (Yes/No)'),
              ),
              TextFormField(
                controller: alcoholLevelController,
                decoration: const InputDecoration(labelText: 'Alcohol Level'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: heartRateController,
                decoration: const InputDecoration(labelText: 'Heart Rate'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: bloodOxygenLevelController,
                decoration:
                    const InputDecoration(labelText: 'Blood Oxygen Level'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: bodyTemperatureController,
                decoration:
                    const InputDecoration(labelText: 'Body Temperature'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: mriDelayController,
                decoration: const InputDecoration(labelText: 'MRI Delay'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: cognitiveTestScoresController,
                decoration:
                    const InputDecoration(labelText: 'Cognitive Test Scores'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              DropdownButtonFormField<String>(
                value: educationLevel,
                decoration: const InputDecoration(labelText: 'Education Level'),
                items: [
                  'Diploma/Degree',
                  'No School',
                  'Primary School',
                  'Secondary School'
                ]
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    educationLevel = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: dominantHand,
                decoration: const InputDecoration(labelText: 'Dominant Hand'),
                items: ['Left', 'Right']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    dominantHand = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['Female', 'Male']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: smokingStatus,
                decoration: const InputDecoration(labelText: 'Smoking Status'),
                items: ['Current Smoker', 'Former Smoker', 'Never Smoked']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    smokingStatus = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: apoee4,
                decoration: const InputDecoration(labelText: 'APOE ε4'),
                items: ['Negative', 'Positive']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    apoee4 = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: physicalActivity,
                decoration:
                    const InputDecoration(labelText: 'Physical Activity'),
                items: ['Mild Activity', 'Moderate Activity', 'Sedentary']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    physicalActivity = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: depressionStatus,
                decoration:
                    const InputDecoration(labelText: 'Depression Status'),
                items: ['No', 'Yes']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    depressionStatus = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: medicationHistory,
                decoration:
                    const InputDecoration(labelText: 'Medication History'),
                items: ['No', 'Yes']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    medicationHistory = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: nutritionDiet,
                decoration: const InputDecoration(labelText: 'Nutrition Diet'),
                items: ['Balanced Diet', 'Low-Carb Diet', 'Mediterranean Diet']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    nutritionDiet = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: sleepQuality,
                decoration: const InputDecoration(labelText: 'Sleep Quality'),
                items: ['Good', 'Poor']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    sleepQuality = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: chronicHealthConditions,
                decoration: const InputDecoration(
                    labelText: 'Chronic Health Conditions'),
                items: ['Diabetes', 'Heart Disease', 'Hypertension', 'None']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    chronicHealthConditions = value!;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: handleFormSubmission,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
