import 'package:flutter_blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter() {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signUp',
        builder: (context, state) => const SignupPage(),
      ),
    ],
  );
}
