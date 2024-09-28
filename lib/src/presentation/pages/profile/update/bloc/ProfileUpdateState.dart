import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';

class ProfileUpdateState extends Equatable {
  final int id;
  final BlocFormItem name;
  final BlocFormItem phone;
  final Resource? response;
  final GlobalKey<FormState>? formkey;

  ProfileUpdateState({
    this.id = 0,
    this.name = const BlocFormItem(error: 'Ingresa el nombre'),
    this.phone = const BlocFormItem(error: 'Ingresa el teléfono'),
    this.formkey,
    this.response,
  });

  toUser() => User(
        name: name.value,
        phone: phone.value,
      );

  ProfileUpdateState copyWith({
    int? id,
    BlocFormItem? name,
    BlocFormItem? phone,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return ProfileUpdateState(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      formkey: formKey,
      response: response,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, phone, response];
}
