// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:indriver_clone_flutter/src/data/dataSource/local/SharefPref.dart'
    as _i216;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/AgencyRoutesService.dart'
    as _i806;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/AuthService.dart'
    as _i231;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/ClientRequestService.dart'
    as _i769;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/FrecuenciesService.dart'
    as _i133;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/RoutesService.dart'
    as _i324;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/StopsService.dart'
    as _i987;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/TimesService.dart'
    as _i597;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/TripService.dart'
    as _i229;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/UsersService.dart'
    as _i920;
import 'package:indriver_clone_flutter/src/di/AppModule.dart' as _i534;
import 'package:indriver_clone_flutter/src/domain/repository/AuthRepository.dart'
    as _i554;
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestRepository.dart'
    as _i22;
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart'
    as _i323;
import 'package:indriver_clone_flutter/src/domain/repository/RoutesRepository.dart'
    as _i711;
import 'package:indriver_clone_flutter/src/domain/repository/SocketRepository.dart'
    as _i416;
import 'package:indriver_clone_flutter/src/domain/repository/UsersRepository.dart'
    as _i377;
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart'
    as _i231;
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestUseCases.dart'
    as _i232;
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart'
    as _i234;
import 'package:indriver_clone_flutter/src/domain/useCases/routes-suggested/RoutesUseCases.dart'
    as _i196;
import 'package:indriver_clone_flutter/src/domain/useCases/socket/SocketUseCases.dart'
    as _i337;
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart'
    as _i602;
import 'package:injectable/injectable.dart' as _i526;
import 'package:socket_io_client/socket_io_client.dart' as _i414;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i216.SharefPref>(() => appModule.sharefPref);
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i414.Socket>(() => appModule.socket);
    gh.factory<_i416.SocketRepository>(() => appModule.socketRepository);
    gh.factory<_i231.AuthService>(() => appModule.authService);
    gh.factory<_i920.UsersService>(() => appModule.usersService);
    gh.factory<_i554.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i769.ClientRequestService>(
        () => appModule.clientRequestService);
    gh.factory<_i377.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i323.GeolocatorRepository>(
        () => appModule.geoLocatorRepository);
    gh.factory<_i806.AgencyRoutesService>(() => appModule.agencyRoutesService);
    gh.factory<_i987.StopsService>(() => appModule.stopsService);
    gh.factory<_i597.TimesService>(() => appModule.timesService);
    gh.factory<_i133.FrequenciesService>(() => appModule.frequenciesService);
    gh.factory<_i229.TripService>(() => appModule.tripService);
    gh.factory<_i324.RoutesService>(() => appModule.routesService);
    gh.factory<_i711.RoutesRepository>(() => appModule.routesRepository);
    gh.factory<_i22.ClientRequestRepository>(
        () => appModule.clientRequestRepository);
    gh.factory<_i231.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i602.UsersUseCases>(() => appModule.usersUseCases);
    gh.factory<_i337.SocketUseCases>(() => appModule.socketUseCases);
    gh.factory<_i234.GeolocatorUseCases>(() => appModule.geolocatorUseCases);
    gh.factory<_i232.ClientRequestUseCases>(
        () => appModule.clientRequestUseCases);
    gh.factory<_i196.RoutesUseCases>(() => appModule.routesUseCases);
    return this;
  }
}

class _$AppModule extends _i534.AppModule {}
