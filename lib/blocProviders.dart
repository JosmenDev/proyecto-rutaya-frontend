import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/injection.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/routes-suggested/RoutesUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/socket/SocketUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/routesSuggested/bloc/RoutesBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/routesSuggested/bloc/RoutesEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/bloc/TripHistoryBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(
      create: (context) =>
          LoginBloc(locator<AuthUseCases>())..add(LoginInitEvent())),
  BlocProvider<RegisterBloc>(
      create: (context) =>
          RegisterBloc(locator<AuthUseCases>())..add(RegisterInitEvent())),
  BlocProvider<BlocSocketIO>(
      create: (context) =>
          BlocSocketIO(locator<SocketUseCases>(), locator<AuthUseCases>())),
  BlocProvider<ClientHomeBloc>(
      create: (context) => ClientHomeBloc(locator<AuthUseCases>())),
  BlocProvider<ProfileInfoBloc>(
      create: (context) =>
          ProfileInfoBloc(locator<AuthUseCases>())..add(GetUserInfo())),
  BlocProvider<ProfileUpdateBloc>(
      create: (context) =>
          ProfileUpdateBloc(locator<UsersUseCases>(), locator<AuthUseCases>())),
  BlocProvider<ClientMapSeekerBloc>(
      create: (context) => ClientMapSeekerBloc(locator<GeolocatorUseCases>())
        ..add(ClientMapSeekerInitEvent())),
  BlocProvider<ClientMapBookingInfoBloc>(
      create: (context) => ClientMapBookingInfoBloc(
          locator<GeolocatorUseCases>(),
          locator<ClientRequestUseCases>(),
          locator<AuthUseCases>())),
  BlocProvider<RoutesBloc>(
    create: (context) =>
        RoutesBloc(locator<RoutesUseCases>(), locator<ClientRequestUseCases>()),
  ),
  BlocProvider<MapTripBloc>(
    create: (context) => MapTripBloc(
        context.read<BlocSocketIO>(),
        locator<ClientRequestUseCases>(),
        locator<GeolocatorUseCases>(),
        locator<AuthUseCases>()),
  ),
  BlocProvider<TripHistoryBloc>(
    create: (context) => TripHistoryBloc(
        locator<ClientRequestUseCases>(), locator<AuthUseCases>()),
  ),
];
