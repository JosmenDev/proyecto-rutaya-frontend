import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/blocFormItem.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultInput.dart';

class ProfileUpdateContent extends StatelessWidget {
  User? user;
  ProfileUpdateState state;

  // Constructor que recibe el user
  ProfileUpdateContent(this.state, this.user);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _headerProfile(context),
            Spacer(),
            _actionProfile(context, 'ACTUALIZAR USUARIO', Icons.check, state),
            SizedBox(
              height: 35,
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          // Pasamos el user al widget _cardUserInfo
          child: _cardUserInfo(context, user, state),
        ),
        DefaultIconBack(
          margin: EdgeInsets.only(
            top: 60,
            left: 30,
          ),
        )
      ],
    );
  }
}

// Modifica _cardUserInfo para aceptar el parámetro user
Widget _cardUserInfo(
    BuildContext context, User? user, ProfileUpdateState state) {
  final size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20, top: 100),
    width: size.width,
    height: size.height * 0.37,
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
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/img/user-image.png',
                  image:
                      'https://www.bnl.gov/today/body_pics/2017/06/StephanHruszkewycz-hr.jpg',
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(seconds: 1),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Ajusta el padding según necesites
            child: DefaultInput(
              onChanged: (text) {
                context
                    .read<ProfileUpdateBloc>()
                    .add(NameChanged(name: BlocFormItem(value: text)));
              },
              validator: (value) {
                return state.name.error;
              },
              size: size,
              color: gris,
              text: 'Nombre de Usuario',
              initialValue: user?.name, // Aquí usamos el nombre del user
              type: TextInputType.text,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Ajusta el padding según necesites
            child: DefaultInput(
              onChanged: (text) {
                context
                    .read<ProfileUpdateBloc>()
                    .add(PhoneChanged(phone: BlocFormItem(value: text)));
              },
              validator: (value) {
                return state.phone.error;
              },
              size: size,
              color: gris,
              text: 'Teléfono',
              initialValue: user?.phone,
              type: TextInputType.phone,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _actionProfile(BuildContext context, String option, IconData icon,
    ProfileUpdateState state) {
  return GestureDetector(
    onTap: () {
      if (state.formkey!.currentState != null) {
        if (state.formkey!.currentState!.validate()) {
          context.read<ProfileUpdateBloc>().add(FormSubmit());
        }
      } else {
        context.read<ProfileUpdateBloc>().add(FormSubmit());
      }
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
    child: Container(
      margin: EdgeInsets.only(top: 30),
      child: Text(
        'ACTUALIZAR PERFIL',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ),
  );
}
