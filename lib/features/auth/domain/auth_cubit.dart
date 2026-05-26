import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../data/auth_mock_data.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // --- (Sign In) ---
  void login({required String email, required String password}) async {
    emit(AuthLoading()); 

    await Future.delayed(const Duration(seconds: 1));

    //  Data Layer
    final isSuccess = AuthMockData.loginCheck(email: email, password: password);

    if (isSuccess) {
      emit(const AuthSuccess("Welcome back to CureCare!")); 
    } else {
      emit(const AuthError("Invalid email or password.")); 
    }
  }

  // --- (Sign Up) ---
  void signup({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading()); //Loading

    await Future.delayed(const Duration(seconds: 1));

    try {
      AuthMockData.registerUser(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      emit(const AuthSuccess("Account created successfully!")); 
    } catch (e) {
      emit(const AuthError("Registration failed. Please try again.")); 
    }
  }
}