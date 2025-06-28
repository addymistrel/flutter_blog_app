import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:flutter_blog_app/core/utils/time_service.dart';
import 'package:flutter_blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_blog_app/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_blog_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_blog_app/firebase_options.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initTimeService();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _initAuth();
  _initFirebaseServices();
  _initAppCOreServices();
}

void _initAppCOreServices() {
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initTimeService() {
  final timeservice = TimeService();
  timeservice.syncTimeWithServer();

  serviceLocator.registerSingleton<TimeService>(timeservice);
}

void _initFirebaseServices() {
  serviceLocator
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
    ..registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
}

void _initAuth() {
  serviceLocator
    ..registerFactory<IAuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory<IAuthRepository>(() => AuthRepository(serviceLocator()))
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
