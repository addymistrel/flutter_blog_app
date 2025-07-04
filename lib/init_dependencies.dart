import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:flutter_blog_app/core/network/connection_checker.dart';
import 'package:flutter_blog_app/core/utils/image_upload_service.dart';
import 'package:flutter_blog_app/core/utils/time_service.dart';
import 'package:flutter_blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_blog_app/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_blog_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_blog_app/features/blog/data/datasource/blog_remote_data_source.dart';
import 'package:flutter_blog_app/features/blog/data/repositories/blog_repository.dart';
import 'package:flutter_blog_app/features/blog/domain/repositories/i_blog_repository.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_blog_app/firebase_options.dart';
import 'package:flutter_blog_app/secrets/app_secrets.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initTimeService();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _initFirebaseServices();
  _initNetworkService();
  _initAuth();
  _initBlog();
  _initAppCoreServices();
  _initColudinaryService();
}

void _initAppCoreServices() {
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

void _initNetworkService() {
  serviceLocator
    ..registerFactory(() => InternetConnection())
    ..registerFactory<IConnectionChecker>(
      () => ConnectionChecker(serviceLocator()),
    );
}

void _initAuth() {
  //Data Source
  serviceLocator
    ..registerFactory<IAuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<IAuthRepository>(
      () => AuthRepository(serviceLocator(), serviceLocator()),
    )
    //Usecases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  //Data Sources
  serviceLocator
    ..registerFactory<IBlogRemoteDataSource>(
      () => BlogRemoteDataSource(serviceLocator(), serviceLocator()),
    )
    //Repository
    ..registerFactory<IBlogRepository>(
      () => BlogRepository(serviceLocator(), serviceLocator()),
    )
    //Usecases
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    //Bloc
    ..registerLazySingleton(
      () =>
          BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()),
    );
}

void _initColudinaryService() {
  var cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://${AppSecrets.cloudinaryApiKey}:${AppSecrets.coludinaryApiSecret}@${AppSecrets.cloudinaryCloudName}',
  );

  cloudinary.config.urlConfig.secure = true;
  serviceLocator.registerLazySingleton<Cloudinary>(() => cloudinary);
  serviceLocator.registerFactory(() => ImageUploadService(serviceLocator()));
}
