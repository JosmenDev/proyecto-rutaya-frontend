import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/Backbutton.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultInput.dart';

// ignore: must_be_immutable
class RegisterContent extends StatelessWidget {
  RegisterState state;

  RegisterContent(this.state);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: state.formKey,
      child: Stack(children: [
        Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Crea tu cuenta',
              style: TextStyle(
                fontSize: size.height * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, // Ajusta el padding horizontal
                  vertical: size.height * 0.03, // Ajusta el padding vertical
                ),
                child: Column(
                  children: [
                    // FlexibleSpaceBar(),
                    SizedBox(height: size.height * 0.05),
                    DefaultInput(
                        onChanged: (text) {
                          context.read<RegisterBloc>().add(
                              NameChanged(name: BlocFormItem(value: text)));
                        },
                        validator: (error) {
                          return state.name.error;
                        },
                        size: size,
                        color: gris,
                        text: 'Nombre de usuario',
                        type: TextInputType.text),
                    SizedBox(height: size.height * 0.02),
                    DefaultInput(
                        onChanged: (text) {
                          context.read<RegisterBloc>().add(
                              PhoneChanged(phone: BlocFormItem(value: text)));
                        },
                        validator: (error) {
                          return state.phone.error;
                        },
                        size: size,
                        color: gris,
                        text: 'Telefono',
                        type: TextInputType.phone),
                    SizedBox(height: size.height * 0.02),
                    DefaultInput(
                        onChanged: (text) {
                          context.read<RegisterBloc>().add(
                              EmailChanged(email: BlocFormItem(value: text)));
                        },
                        validator: (error) {
                          return state.email.error;
                        },
                        size: size,
                        color: gris,
                        text: 'Email',
                        type: TextInputType.emailAddress),
                    SizedBox(height: size.height * 0.02),
                    DefaultInput(
                      onChanged: (text) {
                        context.read<RegisterBloc>().add(PasswordChanged(
                            password: BlocFormItem(value: text)));
                      },
                      validator: (error) {
                        return state.password.error;
                      },
                      size: size,
                      color: gris,
                      text: 'Password',
                      type: TextInputType.text,
                      obscureText: true,
                    ),
                    Defaultbutton(
                        size: size,
                        onPressed: () {
                          if (state.formKey!.currentState!.validate()) {
                            context.read<RegisterBloc>().add(FormSubmit());
                          } else {
                            print('Formulario no válido');
                          }
                        },
                        color: celeste,
                        direction: 'login',
                        text: 'Crear Usuario')
                  ],
                ))
          ],
        ),
        Positioned(
            top: size.height *
                0.05, // Ajusta el botón según el tamaño de la pantalla
            left: 16.0,
            child: Backbutton(color: Colors.black)),
      ]),
    );
  }
}
