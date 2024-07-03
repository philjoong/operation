import 'package:flutter_bloc/flutter_bloc.dart';
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

  AuthBloc(this.userRepository) : super(AuthInitial()) {
    on<SignInWithGoogle>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await userRepository.getUser();
        if (user != null) {
          emit(AuthAuthenticated(user));
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
        // Apple 로그인 로직 추가
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      emit(AuthLoading());
      try {
        // 로그아웃 로직 추가
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}