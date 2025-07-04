import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/core/network/connection_checker.dart';
import 'package:flutter_blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_blog_app/core/common/entities/user_entity.dart';
import 'package:flutter_blog_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;
  final IConnectionChecker _connectionChecker;

  const AuthRepository(this._remoteDataSource, this._connectionChecker);

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      final user = await _remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("User not logged in !"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await _remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await _remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity> Function() fn,
  ) async {
    try {
      var isConnected = await _connectionChecker.isConnected;
      if (!isConnected) {
        return left(Failure("No Internet Connection !"));
      }

      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
