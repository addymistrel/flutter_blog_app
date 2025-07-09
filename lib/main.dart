import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:flutter_blog_app/core/theme/app_theme.dart';
import 'package:flutter_blog_app/core/utils/biometric_service.dart';
import 'package:flutter_blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_blog_app/init_dependencies.dart';
import "package:flutter_blog_app/routes/app_router.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _authenticated = false;

  @override
  void initState() {
    super.initState();
    _handleBiometricAuth();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  Future<void> _handleBiometricAuth() async {
    final success = await BiometricService.authenticate();

    if (!mounted) return;

    if (success) {
      setState(() => _authenticated = true);
      context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    } else {
      // You can also use SystemNavigator.pop(); to close app
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text("Authentication Failed"),
          content: Text("You need to authenticate to use the app."),
          actions: [
            TextButton(
              onPressed: () => _handleBiometricAuth(),
              child: Text("Retry"),
            ),
            TextButton(
              onPressed: () => SystemNavigator.pop(),
              child: Text("Exit"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_authenticated) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: AppTheme.darkThemeMode,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) => state is AppUserLoggedIn,
      builder: (context, isLoggedIn) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: AppTheme.darkThemeMode,
        routerConfig: appRouter(isLoggedIn),
      ),
    );
  }
}
