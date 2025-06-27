import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog_app/core/constants/user_constants.dart';
import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/utils/time_service.dart';
import 'package:flutter_blog_app/features/auth/data/models/user_model.dart';
import 'package:flutter_blog_app/init_dependencies.dart';

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
  final FirebaseFirestore _firebaseFirestore;
  final TimeService _timeService;

  AuthRemoteDataSource(
    this._firebaseAuth,
    this._firebaseFirestore,
    this._timeService,
  );

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

      final UserModel userModel = UserModel(
        uid: userCredentials.user!.uid,
        name: name,
        email: email,
        createdAt: _timeService.getAccurateNow(),
        updatedAt: _timeService.getAccurateNow(),
      );

      await _firebaseFirestore
          .collection(UserConstants.userTableName)
          .doc(userCredentials.user!.uid)
          .set(userModel.toJson());

      return userCredentials.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw ServerException("Firebase Error : ${e.toString()}");
    } catch (e) {
      throw ServerException("Server Error: ${e.toString()}");
    }
  }
}
