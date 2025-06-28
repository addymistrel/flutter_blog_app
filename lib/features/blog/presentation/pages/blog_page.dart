import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter_blog_app/routes/settings/page_routes.dart';
import 'package:go_router/go_router.dart';

class BlogPage extends StatelessWidget {
  static route(BuildContext context) => context.push(BlogPageRoute().path);

  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Blog App")),
        actions: [
          IconButton(
            onPressed: () => AddNewBlogPage.route(context),
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
    );
  }
}
