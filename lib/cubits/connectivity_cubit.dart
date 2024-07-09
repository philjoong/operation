import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityState { connected, disconnected, unknown }

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity;

  ConnectivityCubit(this._connectivity) : super(ConnectivityState.unknown) {
    _monitorConnectivity();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      emit(ConnectivityState.connected);
    } else {
      emit(ConnectivityState.disconnected);
    }
  }

  void _monitorConnectivity() {
    _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        emit(ConnectivityState.connected);
      } else {
        emit(ConnectivityState.disconnected);
      }
    });
  }
}
