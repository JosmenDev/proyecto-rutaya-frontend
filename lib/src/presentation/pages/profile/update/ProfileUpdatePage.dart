import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/ProfileUpdateContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  User? user;

  @override
  void initState() {
    //Primer evento al dispararse   - una sola vez
    // TODO: implement initState
    super.initState();
    print('Metodo Init State');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print('Metodo init state bilding');
      context.read<ProfileUpdateBloc>().add(ProfileUpdateInitEvent(user: user));
    });
  }

  @override
  Widget build(BuildContext context) {
    // segundo - CROL + S
    print('Metodo build');
    user = ModalRoute.of(context)?.settings.arguments as User;
    return Scaffold(
      body: BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            Fluttertoast.showToast(
              msg: response.message,
              toastLength: Toast.LENGTH_LONG,
            );
          } else if (response is Success) {
            User user = response.data as User;
            Fluttertoast.showToast(
              msg: 'Actualización exitosa',
              toastLength: Toast.LENGTH_LONG,
            );
            context
                .read<ProfileUpdateBloc>()
                .add(UpdateUserSession(user: user));
            Future.delayed(Duration(seconds: 1), () {
              context.read<ProfileInfoBloc>().add(GetUserInfo());
            });
          }
        },
        child: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
          builder: (context, state) {
            final response = state.response;
            if (response is Loading) {
              return Stack(
                children: [
                  ProfileUpdateContent(state, user),
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            }
            return ProfileUpdateContent(state, user);
          },
        ),
      ),
    );
  }
}
