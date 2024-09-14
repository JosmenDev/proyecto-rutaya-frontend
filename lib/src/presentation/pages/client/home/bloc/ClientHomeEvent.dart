abstract class ClientHomeEvent {}

class ChangeDrawePage extends ClientHomeEvent {
  final int pageIndex;
  ChangeDrawePage({required this.pageIndex});
}

class Logout extends ClientHomeEvent {}
