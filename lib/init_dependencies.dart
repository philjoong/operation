import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:operation/blocs/tactical_board_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:operation/cubits/connectivity_cubit.dart';
import 'blocs/auth_bloc.dart';
import 'repository/user_repository.dart';

GetIt getIt = GetIt.instance();

Future<void> initDependencies() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('databox');
  getIt.registerSingleton<Box>(box);

  final connectivityCubit = ConnectivityCubit(Connectivity());
  getIt.registerSingleton<ConnectivityCubit>(connectivityCubit);

  await connectivityCubit.checkConnectivity();

  var connectivityState = connectivityCubit.state;

  if (connectivityState == ConnectivityState.connected) {
    getIt.registerSingleton<FirebaseAuthDataSource>(
      FirebaseAuthDataSource(
          firebase_auth.FirebaseAuth.instance, GoogleSignIn()),
    );
    getIt.registerLazySingleton<FirestoreDataSource>(
      () => FirestoreDataSource(FirebaseFirestore.instance),
    );
    getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        authDataSource: getIt<FirebaseAuthDataSource>(),
        firestoreDataSource: getIt<FirestoreDataSource>(),
      ),
    );
  } else {
    getIt.registerLazySingleton<UserRepository>(
      () => LocalUserRepositoryImpl(box),
    );
  }
  getIt.registerSingleton<TacticalBoardBloc>(
    TacticalBoardBloc(getIt<UserRepository>()),
  );
  getIt.registerSingleton<AuthBloc>(
    AuthBloc(getIt<UserRepository>(), getIt<TacticalBoardBloc>()),
  );
}
