import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/blocProviders.dart';
import 'package:indriver_clone_flutter/injection.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/home/ClientHomePage.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/ClientMapBookingInfoPage.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/ProfileUpdatePage.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // englobo mi materialApp por el BlocProvider y lo importo
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
          builder: FToastBuilder(),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            'login': (BuildContext context) => LoginPage(),
            'register': (BuildContext context) => RegisterPage(),
            'client/home': (BuildContext context) => ClientHomePage(),
            'profile/update': (BuildContext context) => ProfileUpdatePage(),
            'client/map/booking': (BuildContext context) =>
                ClientMapBookingInfoPage()
          }),
    );
  }
}

// ignore_for_file: avoid_print
