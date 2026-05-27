import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/domain/auth_cubit.dart';
import 'features/booking/domain/booking_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CarePulseApp());
}

class CarePulseApp extends StatelessWidget {
  const CarePulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
  providers: [
    BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
    BlocProvider<BookingCubit>(create: (context) => BookingCubit()),  
  ],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CureCare',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const LoginScreen(),
  ),
);
  }
}
