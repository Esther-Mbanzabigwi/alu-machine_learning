import 'package:flutter/material.dart';

class DementiaResult extends StatelessWidget {
  final double prediction;
  late final bool isDementia;

  DementiaResult({super.key, required this.prediction}) {
    // Set isDementia based on prediction
    isDementia = prediction >= 0.9;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prediction Result',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity, // Ensures the container takes full width
          child: Container(
            padding: const EdgeInsets.all(16.0), // Optional: add some padding
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 173, 126, 255),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  isDementia ? 'You have dementia' : 'You do not have dementia',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Image.asset(isDementia ? 'assets/bad.png' : 'assets/good.png'),
                const SizedBox(height: 20),
                Text(
                  isDementia
                      ? 'Don\'t worry, consult with your doctor for further advice.'
                      : 'Great news! Stay aware of dementia signs and maintain a healthy lifestyle.',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('Go to Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




                // ] else ...[
                //   const Text(
                //     'You do not have dementia',
                //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                //   ),
                //   const SizedBox(height: 20),
                //   Image.asset('assets/cover_image.png'),
                //   const SizedBox(height: 20),
                //   const Text(
                //     'Great news! Stay aware of dementia signs and maintain a healthy lifestyle.',
                //     style: TextStyle(fontSize: 16),
                //     textAlign: TextAlign.center,
                //   ),