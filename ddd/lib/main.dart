import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _flexAnal = 1;
  int _flexRazrab = 1;
  int _flexTest = 1;

  void _viewAnal() {
    if (_flexAnal == 10) {
      setState(() {
        _flexAnal = 1;
      });
    } else {
      setState(() {
        _flexAnal = 10;
      });
    }
  }

  void _viewRazrab() {
    if (_flexRazrab == 10) {
      setState(() {
        _flexRazrab = 1;
      });
    } else {
      setState(() {
        _flexRazrab = 10;
      });
    }
  }

  void _viewTest() {
    if (_flexTest == 10) {
      setState(() {
        _flexTest = 1;
      });
    } else {
      setState(() {
        _flexTest = 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: _flexAnal,
                  child: Container(
                    height: double.infinity,
                    color: Colors.pink,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(123, 158, 158, 158)),
                      ),
                      onPressed: _viewAnal,
                      child: const Text(
                        'Аналитика',
                        style: TextStyle(
                          fontSize: 30,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: _flexRazrab,
                  child: Container(
                    height: double.infinity,
                    color: Colors.black,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(123, 158, 158, 158)),
                      ),
                      onPressed: _viewRazrab,
                      child: const Text(
                        'Разработка',
                        style: TextStyle(
                          fontSize: 30,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: _flexTest,
                  child: Container(
                    height: double.infinity,
                    color: Colors.yellow,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(123, 158, 158, 158)),
                      ),
                      onPressed: _viewTest,
                      child: const Text(
                        'Тесты',
                        style: TextStyle(
                          fontSize: 30,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Row(
              children: [
                Expanded(
                  flex: _flexAnal,
                  child: Container(color: Colors.grey),
                ),
                Expanded(
                  flex: _flexRazrab,
                  child: Container(color: Colors.blue),
                ),
                Expanded(
                  flex: _flexTest,
                  child: Container(color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
