import 'package:operation/blocs/auth_bloc.dart';
import 'package:operation/model/tactics_model.dart';
import '../model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRepository {
  Future<UserModel?> getUserWithGoogle();
  Future<UserModel?> getUserWithApple();
  Future<List<UnitPosition>> getUserTactics(String userId);
  Future<void> signOut();
}

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuthDataSource authDataSource;
  final FirestoreDataSource firestoreDataSource;

  UserRepositoryImpl({required this.firestoreDataSource, required this.authDataSource});

  @override
  Future<UserModel?> getUserWithGoogle() async {
    final user = await authDataSource.signInWithGoogle();
    if (user != null) {
      final userData = await firestoreDataSource.getUser(user.id);
      if (userData != null) {
        return userData;
      } else {
        await firestoreDataSource.addUser(user);
        return user;
      }
    }
    return null;
  }

  @override
  Future<UserModel?> getUserWithApple() async {
    final user = await authDataSource.signInWithApple();
    if (user != null) {
      final userData = await firestoreDataSource.getUser(user.id);
      if (userData != null) {
        return userData;
      } else {
        await firestoreDataSource.addUser(user);
        return user;
      }
    }
    return null;
  }

  @override
  Future<List<UnitPosition>> getUserTactics(String userId) async {
    return firestoreDataSource.getUserTactics(userId);
  }

  @override
  Future<void> signOut() async {
    await authDataSource.signOut();
  }
}

class FirestoreDataSource {
  final FirebaseFirestore firestore;

  FirestoreDataSource(this.firestore);

  Future<UserModel?> getUser(String userId) async {
    final doc = await firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<void> addUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).set(user.toJson());
  }

  Future<List<UnitPosition>> getUserTactics(String userId, {String? tacticId}) async {
    final querySnapshot;
    if (tacticId != null) {
      querySnapshot = await firestore.collection('tactics')
          .where('userId', isEqualTo: userId)
          .where('tacticId', isEqualTo: tacticId)
          .get();
    } else {
      querySnapshot = await firestore.collection('tactics')
          .where('userId', isEqualTo: userId)
          .get();
    }

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.map((doc) => UnitPosition.fromJson(doc.data())).toList();
    }
    return [];
  }
}


class FirebaseAuthDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  FirebaseAuthDataSource(this.firebaseAuth, this.googleSignIn);

  Future<UserModel?> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    final firebaseUser = userCredential.user;

    return firebaseUser != null
        ? UserModel(id: firebaseUser.uid, name: firebaseUser.displayName!, email: firebaseUser.email!)
        : null;
  }

  Future<UserModel?> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
    );

    final oauthCredential = firebase_auth.OAuthProvider('apple.com').credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );

    final userCredential = await firebaseAuth.signInWithCredential(oauthCredential);
    final firebaseUser = userCredential.user;

    return firebaseUser != null
        ? UserModel(id: firebaseUser.uid, name: firebaseUser.displayName!, email: firebaseUser.email!)
        : null;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    // 애플 로그인은 별도의 로그아웃 필요 없음 (애플 OAuth 제한사항)
  }
}