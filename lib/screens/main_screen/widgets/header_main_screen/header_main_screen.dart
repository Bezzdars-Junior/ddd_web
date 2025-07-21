import 'package:flutter/material.dart';

class HeaderMainScreen extends StatelessWidget {
  const HeaderMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 87, 40, 153),
            Color.fromARGB(255, 145, 66, 255),
          ],
        ),
      ),
      child: const Center(
        child: Row(
          children: [
            SizedBox(width: 20),
            Text(
              'Список проектов',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
