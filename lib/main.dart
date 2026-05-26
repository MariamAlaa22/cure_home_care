import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/domain/auth_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CarePulseApp());
}

class CarePulseApp extends StatelessWidget {
  const CarePulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'CureCare',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0052CC),
            primary: const Color(0xFF0052CC),
          ),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
