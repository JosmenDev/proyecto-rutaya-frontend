import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';

// instalo dependencia de equatable
class LoginState extends Equatable {
  // cuando se escribe en un formalio se cambia de estado
  // como hay dos campos, se tiene dos variables
  // campo extra para el manejo de formario
  // PRIMERO DEFINIMOS VARIABLES Y COLOCANDOLE UN VALOR POR DEFECTO
  final GlobalKey<FormState>? formKey;
  final BlocFormItem email;
  final BlocFormItem password;
  final Resource? response;

  const LoginState({
    this.email = const BlocFormItem(error: 'Ingresa el Email'),
    this.password = const BlocFormItem(error: 'Ingresa el password'),
    this.formKey,
    this.response,
  });

  // Metodo que retonar una instancia del Login
  // cada campo obligatorio tiene que ser con un condicional
  LoginState copyWith({
    BlocFormItem? email,
    BlocFormItem? password,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return LoginState(
      // Recibe el nuevo valor o un valor vacio
      email: email ?? this.email,
      password: password ?? this.password,
      formKey: formKey,
      response: response,
    );
  }

  @override
  // TODO:arreglo donde se especifica las variables que van a cambiar de estado
  List<Object?> get props => [email, password, response];
}
