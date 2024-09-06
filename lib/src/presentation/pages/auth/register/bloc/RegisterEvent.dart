import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';

abstract class RegisterEvent {}

class RegisterInitEvent extends RegisterEvent {}

class NameChanged extends RegisterEvent {
  final BlocFormItem name;
  NameChanged({required this.name});
}

class PhoneChanged extends RegisterEvent {
  final BlocFormItem phone;
  PhoneChanged({required this.phone});
}

class EmailChanged extends RegisterEvent {
  final BlocFormItem email;
  EmailChanged({required this.email});
}

class PasswordChanged extends RegisterEvent {
  final BlocFormItem password;
  PasswordChanged({required this.password});
}

class FormSubmit extends RegisterEvent {}

class FormReset extends RegisterEvent {}
