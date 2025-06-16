import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WebhookTester extends StatefulWidget {
  @override
  _WebhookTesterState createState() => _WebhookTesterState();
}

class _WebhookTesterState extends State<WebhookTester> {
  final TextEditingController _urlController = TextEditingController(text: "https://apitask-production-3696.up.railway.app/webhook");
  final TextEditingController _emailController = TextEditingController();

  String _response = '';
  bool _loading = false;

  Future<void> _validate() async {
    final String url = _urlController.text.trim();
    final String email = _emailController.text.trim();

    if (url.isEmpty || email.isEmpty) {
      setState(() {
        _response = 'Please enter both URL and email.';
      });
      return;
    }

    final validationUrl =
        'https://yhxzjyykdsfkdrmdxgho.supabase.co/functions/v1/junior-dev?url=$url&email=$email';

    setState(() {
      _loading = true;
      _response = '';
    });

    try {
      final res = await http.get(Uri.parse(validationUrl));
      setState(() {
        _response = res.body;
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Webhook Validator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'Webhook URL'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Your Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _validate,
              child: _loading ? CircularProgressIndicator() : Text('Validate'),
            ),
            SizedBox(height: 20),
            Text('Response:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_response),
              ),
            ),
          ],
        ),
      ),
    );
  }
}