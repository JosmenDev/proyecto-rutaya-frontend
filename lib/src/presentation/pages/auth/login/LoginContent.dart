// Atajo stless
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:indriver_clone_flutter/main.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/Backbutton.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultInput.dart';

// ignore: must_be_immutable
class LoginContent extends StatelessWidget {
  LoginState state;

  LoginContent(this.state);

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño del dispositivo
    final size = MediaQuery.of(context).size;
    return Form(
      key: state.formKey,
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // Stack permite crear apilamiento entre widget
                Stack(
                  children: [
                    Image(
                      width: double.infinity, //tamaño posible a lo ancho
                      image: AssetImage('assets/img/fondo-login.jpg'),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height:
                          300, // Asegúrate que la altura sea la misma que la imagen
                      color: celeste
                          .withOpacity(0.54), // Color celeste con opacidad
                    ),
                    Positioned(
                        top: size.height *
                            0.05, // Ajusta el botón según el tamaño de la pantalla
                        left: 16.0,
                        child: Backbutton(color: Colors.white)),
                  ],
                ),
                Transform.translate(
                  // realizo el traslado un hacia arriba
                  offset: Offset(0.0, -20.0),
                  child: Container(
                    // le doy el ancho completo de la pagina
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            size.width * 0.05, // Ajusta el padding horizontal
                        vertical:
                            size.height * 0.03, // Ajusta el padding vertical
                      ),
                      child: Column(
                        children: [
                          // Image(
                          //     image: AssetImage('assets/img/logo-fondo-blanco.svg')),

                          SvgPicture.asset(
                            'assets/img/logo-fondo-blanco.svg',
                            // width: 148,
                            width: size.width * 0.6,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.02),
                            child: Text("Bienvenido de Nuevo",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * 0.020,
                                )),
                          ),
                          SizedBox(height: size.height * 0.04),
                          DefaultInput(
                              onChanged: (text) {
                                context.read<LoginBloc>().add(EmailChanged(
                                      email: BlocFormItem(value: text),
                                    ));
                              },
                              validator: (value) {
                                return state.email.error;
                              },
                              size: size,
                              color: gris,
                              text: 'Email',
                              type: TextInputType.emailAddress),
                          SizedBox(height: size.height * 0.02),
                          DefaultInput(
                            onChanged: (text) {
                              context.read<LoginBloc>().add(PasswordChanged(
                                    password: BlocFormItem(value: text),
                                  ));
                            },
                            validator: (value) {
                              return state.email.error;
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
                                  context.read<LoginBloc>().add(FormSubmit());
                                } else {
                                  print('Formulario no válido');
                                }
                              },
                              color: celeste,
                              direction: 'login',
                              text: 'Iniciar Sesion'),
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Si no tienes cuenta ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: gris_oscuro),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'register');
                                  },
                                  child: Text(
                                    'Registrate',
                                    style: TextStyle(color: celeste),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
