import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, 'login'); // Reemplaza con tu pantalla principal
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0CC0DF), // Fondo de color personalizado
      body: Center(
        child: Image.asset(
          'assets/img/logo_inicio_xl.png',
          width: MediaQuery.of(context).size.width *
              0.7, // Ajustar tamaño de la imagen
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
