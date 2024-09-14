import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';

abstract class LoginEvent {}

// Evento inicial para inicializar el formulario
class LoginInitEvent extends LoginEvent {}

// Saber que el email esta cambiando
class EmailChanged extends LoginEvent {
  final BlocFormItem email;
  // le pasamos la clase del contructor
  EmailChanged({required this.email});
}

// Saber que el password esta cambiando
class PasswordChanged extends LoginEvent {
  final BlocFormItem password;
  PasswordChanged({required this.password});
}

//
class SaveUserSession extends LoginEvent {
  final AuthResponse authResponse;
  SaveUserSession({required this.authResponse});
}

// Evento cuando lancemos la informacion del formulario
class FormSubmit extends LoginEvent {}
