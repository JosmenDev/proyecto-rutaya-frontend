import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  AuthUseCases authUseCases;
  UsersUseCases usersUseCases;
  final formKey = GlobalKey<FormState>();

  ProfileUpdateBloc(this.usersUseCases, this.authUseCases)
      : super(ProfileUpdateState()) {
    on<ProfileUpdateInitEvent>((event, emit) {
      emit(state.copyWith(
        id: event.user?.id,
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

    on<PickImage>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // saber si el usuario selecciono una imagen valida
        emit(
          state.copyWith(
            image: File(image.path),
            formKey: formKey,
          ),
        );
      }
    });

    on<TakePhoto>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        // saber si el usuario selecciono una imagen valida
        emit(
          state.copyWith(
            image: File(image.path),
            formKey: formKey,
          ),
        );
      }
    });

    on<UpdateUserSession>((event, emit) async {
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      authResponse.user.name = event.user.name;
      authResponse.user.phone = event.user.phone;
      authResponse.user.image = event.user.image;
      await authUseCases.saveUserSession.run(authResponse);
    });

    on<FormSubmit>((event, emit) async {
      print('Name: ${state.name.value}');
      print('Phone: ${state.phone.value}');
      emit(state.copyWith(
        response: Loading(),
        formKey: formKey,
      ));
      Resource response =
          await usersUseCases.update.run(state.id, state.toUser(), state.image);
      emit(state.copyWith(
        response: response,
        formKey: formKey,
      ));
    });
  }
}
