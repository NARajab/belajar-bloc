import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final user = await _authService.signIn(email: email, password: password);

      if (user == null) {
        throw Exception("User not found");
      }

      if (!user.emailVerified) {
        throw Exception("Email belum diverifikasi. Silakan verifikasi terlebih dahulu.");
      }

      return LoginResponseModel.fromFirebase(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
        case 'user-not-found':
          throw Exception('Email atau password salah.');
        default:
          throw Exception(e.message ?? 'Terjadi kesalahan.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
  }
}
