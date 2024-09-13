import 'package:countmaster/database/databasehelper.dart';
import 'package:countmaster/screens/loginpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;
  final int value;

  HomePage({required this.username, required this.value});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _incrementValue() async {
    setState(() {
      _value++;
    });
    await DatabaseHelper().updateValue(widget.username, _value);
  }

  void _logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          const Text('Logout', style: TextStyle(fontSize: 20)),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Text(
              'Hello, ${widget.username}!',
              style: const TextStyle(fontSize: 25),
            ),
            Text(
              'Value: $_value',
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _incrementValue,
              child: const Text(
                'Click',
                style: TextStyle(fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
