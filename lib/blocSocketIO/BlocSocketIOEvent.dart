import 'package:flutter/material.dart';

abstract class BlocSocketIOEvent {}

class ConnectSocketIO extends BlocSocketIOEvent {}
class DisconnectSocketIO extends BlocSocketIOEvent {}
class ListenDriverAssignedSocketIO extends BlocSocketIOEvent {}