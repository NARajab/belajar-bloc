import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../../repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      try {
        final loginResponse = await authRepository.login(event.email, event.password);

        if (!loginResponse.isEmailVerified) {
          emit(const LoginFailure(error: 'Email belum diverifikasi. Silakan verifikasi terlebih dahulu.'));
          return;
        }

        emit(const LoginSuccess(message: 'Login berhasil'));
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}

