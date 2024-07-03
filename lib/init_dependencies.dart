
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:operation/repository/strategyRepository.dart';
import 'package:operation/service/strategy_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import 'blocs/startBloc.dart';
import 'cases/strategyUseCase.dart';
import 'blocs/auth_bloc.dart';
import 'repository/user_repository.dart';

GetIt getIt = GetIt.instance();

Future<void> initDependencies() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<StrategyService>(
          () => StrategyServiceImpl(dio: getIt()));
  getIt.registerLazySingleton<StrategyRepository>(
          ()=> StrategyRepositoryImpl(strategyService: getIt()));
  getIt.registerLazySingleton<StrategyUseCase>(
          ()=> StrategyUseCase(strategyRepository: getIt()));


  getIt.registerSingleton<FirebaseAuthDataSource>(
    FirebaseAuthDataSource(firebase_auth.FirebaseAuth.instance, GoogleSignIn()),);
  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(getIt<FirebaseAuthDataSource>()),);
  getIt.registerSingleton<AuthBloc>(
    AuthBloc(getIt<UserRepository>()),);
  getIt.registerLazySingleton<FirestoreDataSource>(
    () => FirestoreDataSource(FirebaseFirestore.instance),
  );
}