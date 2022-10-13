import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_learning_app/core/presentation/widgets/loading_widget.dart';
import 'package:my_new_learning_app/feature/posts/presentation/blocs/post/post_bloc.dart';
import 'package:my_new_learning_app/feature/posts/presentation/pages/add_update_post_page.dart';
import 'package:my_new_learning_app/feature/posts/presentation/widgets/posts_page/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostListWidget(posts: state.posts),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: const Center(
              child: Text('Add a new post or refresh the screen'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddUpdatePostPage(
                isUpdatePage: false,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostBloc>(context).add(RefreshPostsEvent());
  }
}
