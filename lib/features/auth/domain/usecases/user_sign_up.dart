import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/core/common/entities/user_entity.dart';
import 'package:flutter_blog_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<UserEntity, UserSignUpParams> {
  final IAuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
