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
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/AuthService.dart'
    as _i231;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/UsersService.dart'
    as _i920;
import 'package:indriver_clone_flutter/src/di/AppModule.dart' as _i534;
import 'package:indriver_clone_flutter/src/domain/repository/AuthRepository.dart'
    as _i554;
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart'
    as _i323;
import 'package:indriver_clone_flutter/src/domain/repository/UsersRepository.dart'
    as _i377;
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart'
    as _i231;
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart'
    as _i234;
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart'
    as _i602;
import 'package:injectable/injectable.dart' as _i526;

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
    gh.factory<_i231.AuthService>(() => appModule.authService);
    gh.factory<_i920.UsersService>(() => appModule.usersService);
    gh.factory<_i554.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i377.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i323.GeolocatorRepository>(
        () => appModule.geoLocatorRepository);
    gh.factory<_i231.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i602.UsersUseCases>(() => appModule.usersUseCases);
    gh.factory<_i234.GeolocatorUseCases>(() => appModule.geolocatorUseCases);
    return this;
  }
}

class _$AppModule extends _i534.AppModule {}
