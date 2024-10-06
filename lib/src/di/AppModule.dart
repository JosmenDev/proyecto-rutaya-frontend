import 'package:indriver_clone_flutter/src/data/dataSource/local/SharefPref.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/AuthService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/ClientRequestService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/UsersService.dart';
import 'package:indriver_clone_flutter/src/data/repository/AuthRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/data/repository/ClienteRequestRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/data/repository/GeolocatorRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/data/repository/UsersRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/repository/AuthRepository.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestRepository.dart';
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';
import 'package:indriver_clone_flutter/src/domain/repository/UsersRepository.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/SaveUserSessionUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/getUserSessionUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/getTimeAndDistanceUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/CreateMarketUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/FindPositionUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetMarkerUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPlacemarkDataUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPolylineUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/users/UpdateUserUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @injectable
  SharefPref get sharefPref => SharefPref();

  @injectable
  Future<String> get token async {
    String token = '';
    final userSession = await sharefPref.read('user');
    // print(userSession);
    if (userSession != null) {
      AuthResponse authResponse = AuthResponse.fromJson(userSession);
      token = authResponse.token;
    }
    // print(token);
    return token;
  }

  @injectable
  AuthService get authService => AuthService();

  @injectable
  UsersService get usersService => UsersService(token);

  @injectable
  AuthRepository get authRepository =>
      AuthRepositoryImpl(authService, sharefPref);

  @injectable
  ClientRequestService get clientRequestService => ClientRequestService();

  @injectable
  UsersRepository get usersRepository => UsersRepositoryImpl(usersService);

  @injectable
  GeolocatorRepository get geoLocatorRepository => GeolocatorRepositoryImpl();

  @injectable
  ClientRequestRepository get clientRequestRepository =>
      ClienteRequestRepositoryImpl(clientRequestService);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
        login: LoginUseCase(authRepository),
        register: RegisterUseCase(authRepository),
        saveUserSession: SaveUserSessionUseCase(authRepository),
        getUserSession: GetUserSessionUseCase(authRepository),
        logout: LogoutUseCase(authRepository),
      );

  @injectable
  UsersUseCases get usersUseCases =>
      UsersUseCases(update: UpdateUserUseCase(usersRepository));

  @injectable
  GeolocatorUseCases get geolocatorUseCases => GeolocatorUseCases(
        findPosition: FindPositionUseCase(geoLocatorRepository),
        createMarket: CreateMarketUseCase(geoLocatorRepository),
        getMarker: GetMarkerUseCase(geoLocatorRepository),
        getPlacemarkData: GetPlacemarkDataUseCase(geoLocatorRepository),
        getPolyLine: GetPolyLineUseCase(geoLocatorRepository),
      );

  @injectable
  ClientRequestUseCases get clientRequestUseCases => ClientRequestUseCases(
        getTimeAndDistance: GetTimeAndDistanceUseCase(clientRequestRepository),
      );
}
