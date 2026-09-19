import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'features/auth/presentation/bloc/auth_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const TailoredEatsApp());
}

class TailoredEatsApp extends StatelessWidget {
  const TailoredEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tailored Eats',
        home: const LoginPage(),
      ),
    );
  }
}
