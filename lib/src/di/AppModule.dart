import 'package:indriver_clone_flutter/src/data/api/ApiConfig.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/local/SharefPref.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/AgencyRoutesService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/AuthService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/ClientRequestService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/FrecuenciesService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/RoutesService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/StopsService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/TimesService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/TripService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/UsersService.dart';
import 'package:indriver_clone_flutter/src/data/repository/AuthRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/data/repository/ClienteRequestRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/data/repository/GeolocatorRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/data/repository/RoutesRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/data/repository/SocketRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/data/repository/UsersRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/repository/AuthRepository.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestRepository.dart';
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';
import 'package:indriver_clone_flutter/src/domain/repository/RoutesRepository.dart';
import 'package:indriver_clone_flutter/src/domain/repository/SocketRepository.dart';
import 'package:indriver_clone_flutter/src/domain/repository/UsersRepository.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/SaveUserSessionUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/getUserSessionUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/CreateClientRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/GetByClientRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/GetByClientTripsHistoryUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/UpdateRouteSelectUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/UpdateStatusClientRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/getTimeAndDistanceUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/CreateMarketUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/FindPositionUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetMarkerUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPlacemarkDataUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPolylineUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPolylineWalkingUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPositionStreamUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/routes-suggested/GetRoutesSuggetedUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/routes-suggested/RoutesUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/socket/ConnectSocketUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/socket/DisconnectSocketUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/socket/SocketUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/users/UpdateUserUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart';

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
  Socket get socket => io(
      'http://${ApiConfig.API_PROJECT}',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build());

  @injectable
  SocketRepository get socketRepository => SocketRepositoryImpl(socket);

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

  // Rutas

  @injectable
  AgencyRoutesService get agencyRoutesService => AgencyRoutesService();

  @injectable
  StopsService get stopsService => StopsService();

  @injectable
  TimesService get timesService => TimesService();

  @injectable
  FrequenciesService get frequenciesService => FrequenciesService();

  @injectable
  TripService get tripService => TripService();

  @injectable
  RoutesService get routesService =>
      RoutesService(agencyRoutesService, stopsService);

  @injectable
  RoutesRepository get routesRepository => RoutesRepositoryImpl(routesService);

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
  SocketUseCases get socketUseCases => SocketUseCases(
        connect: ConnectSocketUseCase(socketRepository),
        disconnect: DisconnectSocketUseCase(socketRepository),
      );

  @injectable
  GeolocatorUseCases get geolocatorUseCases => GeolocatorUseCases(
        findPosition: FindPositionUseCase(geoLocatorRepository),
        createMarket: CreateMarketUseCase(geoLocatorRepository),
        getMarker: GetMarkerUseCase(geoLocatorRepository),
        getPlacemarkData: GetPlacemarkDataUseCase(geoLocatorRepository),
        getPolyLine: GetPolyLineUseCase(geoLocatorRepository),
        getPositionStream: GetPositionStreamUseCase(geoLocatorRepository),
        getPolyLineWalking: GetPolyLineWalkingUseCase(geoLocatorRepository),
      );

  @injectable
  ClientRequestUseCases get clientRequestUseCases => ClientRequestUseCases(
        createClientRequest:
            CreateClientRequestUseCase(clientRequestRepository),
        getTimeAndDistance: GetTimeAndDistanceUseCase(clientRequestRepository),
        updateRouteSelect: UpdateRouteSelectUseCase(clientRequestRepository),
        getByClientRequest: GetByClientRequestUseCase(clientRequestRepository),
        updateStatusClientRequest:
            UpdateStatusClientRequestUseCase(clientRequestRepository),
        getByClientTripsHistory:
            GetByClientTripsHistoryUseCase(clientRequestRepository),
      );

  // **Registrar RoutesUseCases**
  @injectable
  RoutesUseCases get routesUseCases => RoutesUseCases(
        getRoutesSuggetedUseCase: GetRoutesSuggestedUseCase(routesRepository),
      );
}
