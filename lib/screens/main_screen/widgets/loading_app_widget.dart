import 'package:flutter/material.dart';

class LoadingAppWidget extends StatelessWidget {
  const LoadingAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Загрузка приложения',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(width: 30),
          CircularProgressIndicator(
            color: Colors.purple,
            backgroundColor: Colors.grey.withValues(alpha: 0.5),
            strokeWidth: 5.0,
          ),
        ],
      ),
    );
  }
}
