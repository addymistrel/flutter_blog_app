import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/common/constants/blog_constants.dart';
import 'package:flutter_blog_app/core/theme/app_pallete.dart';
import 'package:flutter_blog_app/core/utils/pick_image.dart';
import 'package:flutter_blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:flutter_blog_app/routes/settings/page_routes.dart';
import 'package:go_router/go_router.dart';

class AddNewBlogPage extends StatefulWidget {
  static route(BuildContext context) =>
      context.push(AddNewBlogPageRoute().path);

  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await PickImage.pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Image.file(image!, fit: BoxFit.cover),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                        options: const RoundedRectDottedBorderOptions(
                          radius: Radius.circular(10),
                          color: AppPallete.borderColor,
                          strokeCap: StrokeCap.round,
                          dashPattern: [10, 4],
                        ),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open, size: 40),
                              SizedBox(height: 15),
                              Text(
                                "Select you image",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: BlogConstants.blogCategories
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedTopics.contains(e)) {
                                  selectedTopics.remove(e);
                                } else {
                                  selectedTopics.add(e);
                                }
                              });
                            },
                            child: Chip(
                              label: Text(e),
                              color: selectedTopics.contains(e)
                                  ? const WidgetStatePropertyAll(
                                      AppPallete.gradient1,
                                    )
                                  : null,
                              side: selectedTopics.contains(e)
                                  ? null
                                  : BorderSide(color: AppPallete.borderColor),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 10),
              BlogEditor(controller: titleController, hintText: "Blog Title"),
              const SizedBox(height: 10),
              BlogEditor(
                controller: contentController,
                hintText: "Blog Content",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
