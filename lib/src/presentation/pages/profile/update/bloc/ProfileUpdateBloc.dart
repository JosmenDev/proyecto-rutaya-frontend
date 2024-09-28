import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  final formKey = GlobalKey<FormState>();

  ProfileUpdateBloc() : super(ProfileUpdateState()) {
    on<ProfileUpdateInitEvent>((event, emit) {
      emit(state.copyWith(
        name: BlocFormItem(value: event.user?.name ?? ''),
        phone: BlocFormItem(value: event.user?.phone ?? ''),
        formKey: formKey,
      ));
    });
    on<NameChanged>((event, emit) {
      emit(state.copyWith(
        name: BlocFormItem(
            value: event.name.value,
            error: event.name.value.isEmpty ? 'Ingresa nombre' : null),
        formKey: formKey,
      ));
    });

    on<PhoneChanged>((event, emit) {
      emit(state.copyWith(
        phone: BlocFormItem(
            value: event.phone.value,
            error: event.phone.value.isEmpty ? 'Ingresa teléfono' : null),
        formKey: formKey,
      ));
    });

    on<FormSubmit>((event, emit) {
      print('Name: ${state.name.value}');
      print('Phone: ${state.phone.value}');
    });
  }
}
