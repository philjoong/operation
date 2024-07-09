
import 'package:hive_flutter/hive_flutter.dart';
import 'package:operation/model/tactics_model.dart';
import 'package:operation/model/user.dart';
import 'user_repository.dart';

class LocalUserRepositoryImpl implements UserRepository {
  final Box box;

  LocalUserRepositoryImpl(this.box);

  @override
  Future<UserModel> getUser(String id) async {
    // var userData = box.get(id);
    // if (userData != null) {
    //   return UserModel.fromJson(userData);
    // }
    // throw Exception('User not found');
    throw UnimplementedError();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    // Hive에 데이터를 저장하는 로직 구현
    // await box.put(user.id, user.toJson());
    throw UnimplementedError();
  }
  
  @override
  Future<List<UnitPosition>> getUserTactics(String userId) {
    // TODO: implement getUserTactics
    throw UnimplementedError();
  }
  
  @override
  Future<UserModel?> getUserWithApple() {
    // TODO: implement getUserWithApple
    throw UnimplementedError();
  }
  
  @override
  Future<UserModel?> getUserWithGoogle() {
    // TODO: implement getUserWithGoogle
    throw UnimplementedError();
  }
  
  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
  
  @override
  Future<void> saveUserTactics(UnitPosition players) {
    // TODO: implement saveUserTactics
    throw UnimplementedError();
  }

  // 나머지 UserRepository 메소드들도 Hive를 사용하여 구현
}

