import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String email;
  final String nik;
  final String password;
  final String phone;
  final String role;

  RegisterSubmitted({
    required this.username,
    required this.email,
    required this.nik,
    required this.password,
    required this.phone,
    required this.role,
  });

  @override
  List<Object?> get props => [username, email, nik, password, phone, role];
}
