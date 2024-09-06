import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final formKey = GlobalKey<FormState>();
  LoginBloc() : super(LoginState()) {
    // aqui, ya podemos registrar los eventos
    on<LoginInitEvent>((event, emit) {
      // Dentro de este evento, vamos a emitir un cambio de estado
      emit(state.copyWith(formKey: formKey));
      // emit llama a state y con esto puedo acceder a todos los atributos o parametros
      // Agrego copyWith para cambiar los valores
    });

    on<EmailChanged>((event, emit) {
      // event.email LO QUE EL USUARIO ESTA ESCRIBIENDO
      emit(state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isEmpty ? 'Ingresa el email' : null,
        ),
        formKey: formKey,
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error: event.password.value.isEmpty
              ? 'Ingrese el password'
              : event.password.value.length < 6
                  ? 'Minimo 6 caracteres'
                  : null,
        ),
        formKey: formKey,
      ));
    });

    on<FormSubmit>((event, emit) {
      print('Email: ${state.email}');
      print('Password: ${state.password}');
    });
  }
}
