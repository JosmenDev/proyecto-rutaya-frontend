import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';

class ProfileInfoState extends Equatable {
  final User? user;

  ProfileInfoState({this.user});

  ProfileInfoState copyWith({
    User? user,
  }) {
    return ProfileInfoState(
      user: user,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
