import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username == '2100016039' && password == 'responsi_B') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _bmi;
  String? _category;
  Color? _categoryColor;

  void _calculateBMI() {
    final double? weight = double.tryParse(_weightController.text);
    final double? height = double.tryParse(_heightController.text)! / 100;

    if (weight != null && height != null && height > 0) {
      setState(() {
        _bmi = weight / (height * height);

        if (_bmi! < 18.5) {
          _category = 'Underweight';
          _categoryColor = Colors.yellow;
        } else if (_bmi! < 25) {
          _category = 'Normal';
          _categoryColor = Colors.green;
        } else {
          _category = 'Overweight';
          _categoryColor = Colors.red;
        }
      });
    } else {
      setState(() {
        _bmi = null;
        _category = null;
        _categoryColor = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                Text('kg'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _heightController,
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                Text('cm'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text('Hitung'),
            ),
            SizedBox(height: 20),
            if (_bmi != null)
              Column(
                children: <Widget>[
                  Text(
                    'BMI: ${_bmi!.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Category: $_category',
                    style: TextStyle(fontSize: 24, color: _categoryColor),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
