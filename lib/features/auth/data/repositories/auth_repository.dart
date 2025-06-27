import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;

  const AuthRepository(this._remoteDataSource);

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
      final user = await fn();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
