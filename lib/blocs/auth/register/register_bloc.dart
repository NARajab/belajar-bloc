import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';
import '../../../services/autentications/register_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterServices registerServices;

  RegisterBloc(this.registerServices) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());

      final response = await registerServices.register(
        event.username,
        event.email,
        event.nik,
        event.password,
        event.phone,
        event.role,
      );

      if (response['status'] == 'success') {
        emit(RegisterSuccess(response['message']));
      } else {
        emit(RegisterFailure(response['message']));
      }
    });
  }
}
