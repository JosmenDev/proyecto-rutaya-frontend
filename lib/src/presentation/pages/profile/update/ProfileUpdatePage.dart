import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';
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
      body: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
        builder: (context, state) {
          return ProfileUpdateContent(state, user);
        },
      ),
    );
  }
}
