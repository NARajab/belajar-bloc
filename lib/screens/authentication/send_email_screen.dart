import 'package:flutter/material.dart';

class SendEmailScreen extends StatelessWidget {
  const SendEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SendEmailScreen'),
        backgroundColor: const Color(0xFF304FFE),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Send Email Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
