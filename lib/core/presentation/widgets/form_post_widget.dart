import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_new_learning_app/core/presentation/widgets/crud_button_action_widget.dart';

import '../../../feature/posts/domain/entity/post.dart';

class FormPostWidget extends StatefulWidget {
  final bool isUpdatePage;
  final Post? post;
  const FormPostWidget({
    super.key,
    this.post,
    required this.isUpdatePage,
  });

  @override
  State<FormPostWidget> createState() => _FormPostWidgetState();
}

class _FormPostWidgetState extends State<FormPostWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  String title = '';
  String body = '';

  @override
  void initState() {
    if (widget.isUpdatePage) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              title = value;
            },
            controller: _titleController,
            validator: ((value) => value!.isEmpty ? 'Can\'t be null' : null),
            decoration: InputDecoration(
              hintText: 'Title',
              fillColor: Colors.teal,
              filled: true,
              hintStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Gap(20),
          TextFormField(
            minLines: 2,
            maxLines: 4,
            onChanged: (value) {
              body = value;
            },
            controller: _bodyController,
            validator: ((value) => value!.isEmpty ? 'Can\'t be null' : null),
            decoration: InputDecoration(
              hintText: 'Body',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Gap(30),
          CRUDButtonActionWidget(
            action: widget.isUpdatePage ? 'update' : 'add',
            title: widget.isUpdatePage ? 'Update' : 'Add Post',
            isValid: isValid,
            post: widget.post ??
                Post(
                  id: 101,
                  title: title,
                  body: body,
                  userId: 1,
                ),
          ),
        ]),
      ),
    );
  }

  bool isValid() {
    return _formKey.currentState!.validate();
  }
}
