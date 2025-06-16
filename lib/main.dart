import 'package:flutter/material.dart';
import 'package:frontend_endpoint/webhookTester.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Webhook Validator',
      home: WebhookTester(),
    );
  }
}


