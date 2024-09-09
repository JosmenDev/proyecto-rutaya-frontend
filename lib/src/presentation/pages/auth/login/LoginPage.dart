import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginState.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // Cambio de estado, cuando modificamos algo, el _LoginPageState cambia de estado y eso es visible en pantalla
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // _bloc = BlocProvider.of<LoginBloc>(context);
    // Parte que ve el usuario
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            print('Error Data: ${response.message}');
          } else if (response is Success) {
            print('Succes Dta: ${response.data}');
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final response = state.response;
            // para mostrar al usuario que se está ejecutando su operacion
            if (response is Loading) {
              return Stack(
                children: [
                  LoginContent(state),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            }
            return LoginContent(state);
          },
        ),
      ),
    );
  }
}
