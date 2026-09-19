import 'package:flutter/material.dart';

import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const TailoredEatsApp());
}

class TailoredEatsApp extends StatelessWidget {
  const TailoredEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tailored Eats',
      home: const Scaffold(body: Center(child: Text('Tailored Eats'))),
    );
  }
}
