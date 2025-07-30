import 'package:firebase_auth/firebase_auth.dart';

class LoginResponseModel {
  final String uid;
  final String email;
  final bool isEmailVerified;

  LoginResponseModel({
    required this.uid,
    required this.email,
    required this.isEmailVerified,
  });

  factory LoginResponseModel.fromFirebase(User user) {
    return LoginResponseModel(
      uid: user.uid,
      email: user.email ?? '',
      isEmailVerified: user.emailVerified,
    );
  }
}
