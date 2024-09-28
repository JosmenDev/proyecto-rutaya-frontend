import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';

class ProfileUpdateState extends Equatable {
  final BlocFormItem name;
  final BlocFormItem phone;
  final GlobalKey<FormState>? formkey;

  ProfileUpdateState({
    this.name = const BlocFormItem(error: 'Ingresa el nombre'),
    this.phone = const BlocFormItem(error: 'Ingresa el teléfono'),
    this.formkey,
  });

  ProfileUpdateState copyWith({
    BlocFormItem? name,
    BlocFormItem? phone,
    GlobalKey<FormState>? formKey,
  }) {
    return ProfileUpdateState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      formkey: formKey,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, phone];
}
