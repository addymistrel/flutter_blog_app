import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/core/common/entities/user_entity.dart';
import 'package:flutter_blog_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<UserEntity, NoParams> {
  final IAuthRepository _authRepository;
  CurrentUser(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await _authRepository.currentUser();
  }
}
