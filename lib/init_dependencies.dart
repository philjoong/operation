
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:operation/blocs/tactical_board_bloc.dart';
import 'package:operation/repository/strategyRepository.dart';
import 'package:operation/service/strategy_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'blocs/startBloc.dart';
import 'cases/strategyUseCase.dart';
import 'blocs/auth_bloc.dart';
import 'repository/user_repository.dart';

GetIt getIt = GetIt.instance();

Future<void> initDependencies() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('databox');
  getIt.registerSingleton<Box>(box);

  getIt.registerSingleton<FirebaseAuthDataSource>(
    FirebaseAuthDataSource(firebase_auth.FirebaseAuth.instance, GoogleSignIn()),);
  getIt.registerLazySingleton<FirestoreDataSource>(
    () => FirestoreDataSource(FirebaseFirestore.instance),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      authDataSource: getIt<FirebaseAuthDataSource>(), 
      firestoreDataSource: getIt<FirestoreDataSource>(),
    ),
  );
  getIt.registerSingleton<TacticalBoardBloc>(
    TacticalBoardBloc(getIt<UserRepository>()),);
  getIt.registerSingleton<AuthBloc>(
    AuthBloc(getIt<UserRepository>(), getIt<TacticalBoardBloc>()),);
}