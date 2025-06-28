import 'package:flutter_blog_app/routes/settings/router_functions.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter(bool isLoggedIn) {
  return GoRouter(
    initialLocation: isLoggedIn
        ? RouterFunctions.authenticatedRoute
        : RouterFunctions.defaultRoute,
    routes: RouterFunctions.getAllRoutes(),
  );
}
