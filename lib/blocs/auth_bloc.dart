import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operation/blocs/tactical_board_bloc.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';

abstract class AuthEvent {}

class SignInWithGoogle extends AuthEvent {}

class SignInWithApple extends AuthEvent {}

class SignOut extends AuthEvent {}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated(this.user);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  final TacticalBoardBloc tacticalBoardBloc;

  AuthBloc(this.userRepository, this.tacticalBoardBloc) : super(AuthInitial()) {
    on<SignInWithGoogle>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await userRepository.getUserWithGoogle();
        if (user != null) {
          emit(AuthAuthenticated(user));
          tacticalBoardBloc.add(LoadTacticalBoard(user.id));
        } else {
          emit(AuthError("Google sign-in failed"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignInWithApple>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await userRepository.getUserWithApple();
        if (user != null) {
          emit(AuthAuthenticated(user));
          tacticalBoardBloc.add(LoadTacticalBoard(user.id));
        } else {
          emit(AuthError("Apple sign-in failed"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      emit(AuthLoading());
      try {
        await userRepository.signOut();
        emit(AuthInitial());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}