import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog_app/core/error/exceptions.dart';

abstract interface class IAuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSource(this._firebaseAuth);

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredentials.user == null) {
        throw const ServerException("User is null !");
      }

      await userCredentials.user?.updateDisplayName(name);
      return userCredentials.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw ServerException("Firebase Error : ${e.toString()}");
    } catch (e) {
      throw ServerException("Server Error: ${e.toString()}");
    }

    // TODO: implement signUpWithEmailPassword
    throw UnimplementedError();
  }
}
