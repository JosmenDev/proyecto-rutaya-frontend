import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';

class ProfileInfoContent extends StatelessWidget {
  final User? user;

  ProfileInfoContent(this.user);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _headerProfile(context),
            Spacer(),
            _actionProfile('EDITAR PERFIL', Icons.edit, () {
              Navigator.pushNamed(context, 'profile/update', arguments: user);
            }),
            _actionProfile('CERRAR SESION', Icons.settings_power, () {}),
            SizedBox(
              height: 35,
            )
          ],
        ),
        _cardUserInfo(context, user), // Pasar el user aquí
      ],
    );
  }
}

Widget _cardUserInfo(BuildContext context, User? user) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20, top: 100),
    width: MediaQuery.of(context).size.width,
    height: 250,
    child: Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: 115,
            margin: EdgeInsets.only(top: 15, bottom: 15),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipOval(
                child:
                    user != null && user.image != null && user.image!.isNotEmpty
                        ? FadeInImage.assetNetwork(
                            placeholder:
                                'assets/img/user-image.png', // Imagen predeterminada
                            image: user.image!,
                            fit: BoxFit.cover,
                            fadeInDuration: Duration(seconds: 1),
                          )
                        : Image.asset(
                            'assets/img/user-image.png', // Imagen predeterminada si no hay imagen
                            fit: BoxFit.cover,
                          ),
              ),
            ),
          ),
          Text(
            user?.name ?? '', // Utilizar el user pasado
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            user?.email ?? '',
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          Text(
            user?.phone ?? '',
            style: TextStyle(
              color: Colors.grey[700],
            ),
          )
        ],
      ),
    ),
  );
}

Widget _actionProfile(String option, IconData icon, Function() function) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      margin: EdgeInsets.only(left: 35, right: 20, top: 15),
      child: ListTile(
        title: Text(
          option,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: celeste,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget _headerProfile(BuildContext context) {
  return Container(
    alignment: Alignment.topCenter,
    padding: EdgeInsets.only(top: 40),
    height: MediaQuery.of(context).size.height * 0.3,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: celeste,
    ),
    child: Text(
      'PERFIL DE USUARIO',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    ),
  );
}
