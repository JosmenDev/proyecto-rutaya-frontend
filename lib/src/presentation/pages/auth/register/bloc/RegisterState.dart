import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';

class RegisterState extends Equatable {
  final GlobalKey<FormState>? formKey;
  final BlocFormItem name;
  final BlocFormItem phone;
  final BlocFormItem email;
  final BlocFormItem password;
  final Resource? response;

  const RegisterState({
    this.name = const BlocFormItem(error: 'Ingresa el nombre de usuario'),
    this.phone = const BlocFormItem(error: 'Ingresa el telefono'),
    this.email = const BlocFormItem(error: 'Ingresa el email'),
    this.password = const BlocFormItem(error: 'Ingresa el password'),
    this.formKey,
    this.response,
  });

  toUser() => User(
        name: name.value,
        phone: phone.value,
        email: email.value,
        password: password.value,
      );

  RegisterState copyWith({
    BlocFormItem? name,
    BlocFormItem? phone,
    BlocFormItem? email,
    BlocFormItem? password,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return RegisterState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      formKey: formKey,
      response: response,
    );
  }

  @override
  List<Object?> get props => [name, phone, email, password, response];
}
