import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';

abstract class ProfileUpdateEvent {}

class ProfileUpdateInitEvent extends ProfileUpdateEvent {
  final User? user;
  ProfileUpdateInitEvent({required this.user});
}

class NameChanged extends ProfileUpdateEvent {
  final BlocFormItem name;
  NameChanged({required this.name});
}

class PhoneChanged extends ProfileUpdateEvent {
  final BlocFormItem phone;
  PhoneChanged({required this.phone});
}

class UpdateUserSession extends ProfileUpdateEvent {
  final User user;
  UpdateUserSession({required this.user});
}

class PickImage extends ProfileUpdateEvent {}

class TakePhoto extends ProfileUpdateEvent {}

class FormSubmit extends ProfileUpdateEvent {}
