import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/common/constants/blog_constants.dart';
import 'package:flutter_blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter_blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter_blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter_blog_app/features/blog/presentation/pages/blog_view_page.dart';
import 'package:flutter_blog_app/routes/settings/page_route_config.dart';
import 'package:go_router/go_router.dart';

final class LoginPageRoute implements PageRouteConfig {
  @override
  final String path = "/login";
  @override
  final String name = "login";

  @override
  Widget buildPage(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

final class SignUpPageRoute implements PageRouteConfig {
  @override
  final String path = "/signup";
  @override
  final String name = "signup";

  @override
  Widget buildPage(BuildContext context, GoRouterState state) {
    return const SignupPage();
  }
}

final class BlogPageRoute implements PageRouteConfig {
  @override
  final String path = "/blog";
  @override
  final String name = "blog";

  @override
  Widget buildPage(BuildContext context, GoRouterState state) {
    final refreshKey =
        state.uri.queryParameters[BlogConstants.refreshQueryIdentifier];
    return BlogPage(
      key: ValueKey(refreshKey ?? BlogConstants.staticMemeberKey),
    );
  }
}

final class AddNewBlogPageRoute implements PageRouteConfig {
  @override
  final String path = "/addNewBlog";
  @override
  final String name = "addNewBlog";

  @override
  Widget buildPage(BuildContext context, GoRouterState state) {
    return AddNewBlogPage();
  }
}

final class BlogViewPageRoute implements PageRouteConfig {
  @override
  final String path = "/blogView";
  @override
  final String name = "blogView";

  @override
  Widget buildPage(BuildContext context, GoRouterState state) {
    return BlogViewPage(blog: state.extra as BlogEntity);
  }
}
