import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog_app/core/utils/time_service.dart';
import 'package:flutter_blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_blog_app/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_blog_app/features/auth/domain/repositories/i_auth_repository.dart';
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
}

void _initTimeService() {
  final timeservice = TimeService();
  timeservice.syncTimeWithServer();

  serviceLocator.registerSingleton<TimeService>(timeservice);
}

void _initFirebaseServices() {
  serviceLocator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  serviceLocator.registerLazySingleton<FirebaseStorage>(
    () => FirebaseStorage.instance,
  );
}

void _initAuth() {
  serviceLocator.registerFactory<IAuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<IAuthRepository>(
    () => AuthRepository(serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignUp: serviceLocator()),
  );
}
