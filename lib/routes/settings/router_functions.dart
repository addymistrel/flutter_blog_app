import 'package:flutter_blog_app/routes/settings/page_route_config.dart';
import 'package:flutter_blog_app/routes/settings/page_routes.dart';
import 'package:go_router/go_router.dart';

final class RouterFunctions {
  static get defaultRoute => LoginPageRoute().path;
  static get authenticatedRoute => AddNewBlogPageRoute().path;

  static List<GoRoute> getAllRoutes() {
    final List<PageRouteConfig> pageRoutes = [
      BlogPageRoute(),
      LoginPageRoute(),
      SignUpPageRoute(),
      AddNewBlogPageRoute(),
    ];

    return pageRoutes
        .map(
          (route) => GoRoute(
            path: route.path,
            name: route.name,
            builder: (context, state) => route.page,
          ),
        )
        .toList();
  }
}
