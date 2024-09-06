import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/Backbutton.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultInput.dart';

class RegisterContent extends StatelessWidget {
  const RegisterContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
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
                      onChanged: (text) {},
                      size: size,
                      color: gris,
                      text: 'Nombre de usuario',
                      type: TextInputType.text),
                  SizedBox(height: size.height * 0.02),
                  DefaultInput(
                      onChanged: (text) {},
                      size: size,
                      color: gris,
                      text: 'Telefono',
                      type: TextInputType.phone),
                  SizedBox(height: size.height * 0.02),
                  DefaultInput(
                      onChanged: (text) {},
                      size: size,
                      color: gris,
                      text: 'Email',
                      type: TextInputType.emailAddress),
                  SizedBox(height: size.height * 0.02),
                  DefaultInput(
                    onChanged: (text) {},
                    size: size,
                    color: gris,
                    text: 'Password',
                    type: TextInputType.text,
                    obscureText: true,
                  ),
                  Defaultbutton(
                      onPressed: () {},
                      size: size,
                      color: celeste,
                      direction: 'login',
                      text: 'Iniciar Sesion')
                ],
              ))
        ],
      ),
      Positioned(
          top: size.height *
              0.05, // Ajusta el botón según el tamaño de la pantalla
          left: 16.0,
          child: Backbutton(color: Colors.black)),
    ]);
  }
}
