import 'package:socket_io_client/socket_io_client.dart';

abstract class SocketRepository {
  Socket connect();
  Socket disconnect();
}
