import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_learning_app/core/presentation/widgets/form_post_widget.dart';
import 'package:my_new_learning_app/core/presentation/widgets/loading_widget.dart';
import 'package:my_new_learning_app/feature/posts/domain/entity/post.dart';
import 'package:my_new_learning_app/feature/posts/presentation/blocs/crud_post/crud_post_bloc.dart';
import 'package:my_new_learning_app/feature/posts/presentation/pages/posts_page.dart';

class AddUpdatePostPage extends StatelessWidget {
  final bool isUpdatePage;
  final Post? post;
  const AddUpdatePostPage({super.key, required this.isUpdatePage, this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePage ? 'Update' : 'Add'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: BlocConsumer<CrudPostBloc, CrudPostState>(
          builder: (context, state) {
            if (state is LoadingCrudState) {
              return const LoadingWidget();
            }
            return FormPostWidget(isUpdatePage: isUpdatePage);
          },
          listener: (context, state) {
            if (state is ErrorCrudState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is SuccessCrudState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.teal,
                duration: const Duration(seconds: 2),
              ));
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const PostsPage()),
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
