import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indriver_clone_flutter/main.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/home/bloc/ClientHomeState.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/ProfileInfoPage.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  List<Widget> pageList = <Widget>[
    ProfileInfoPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        toolbarHeight: size.height * 0.07,
        title: Row(
          children: [
            // Espacio a la izquierda
            Spacer(),

            // Logo centrado en el Row
            Expanded(
              flex: 2, // Ajusta el flex para que ocupe más espacio
              child: Center(
                child: SvgPicture.asset(
                  'assets/img/logo-fondo-celeste.svg',
                  height: size.height *
                      0.04, // Ajusta el tamaño del logo según sea necesario
                  fit: BoxFit
                      .contain, // Ajuste para que el logo ocupe el espacio sin deformarse
                ),
              ),
            ),

            // Espacio entre el logo y el texto "Trujillo"
            Spacer(),

            // Texto "Trujillo" con espacio al lado derecho
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0), // Añade espacio en el lado derecho
              child: Text(
                'Trujillo',
                style: TextStyle(
                  fontSize: 18, // Ajusta el tamaño del texto
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        },
      ),
      drawer: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: celeste,
                  ),
                  child: Text(
                    'Menú del Cliente',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text('Perfil de Usuario'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context
                        .read<ClientHomeBloc>()
                        .add(ChangeDrawePage(pageIndex: 0));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Cerrar Sesión'),
                  // selected: state.pageIndex == 0,
                  onTap: () {
                    context.read<ClientHomeBloc>().add(Logout());
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (route) => false);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
