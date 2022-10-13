import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_learning_app/feature/posts/domain/entity/post.dart';
import 'package:my_new_learning_app/feature/posts/presentation/blocs/crud_post/crud_post_bloc.dart';

class CRUDButtonActionWidget extends StatelessWidget {
  final Post post;
  final bool Function() isValid;
  final String action;
  final String title;
  const CRUDButtonActionWidget({
    super.key,
    required this.action,
    required this.title,
    required this.isValid,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (isValid()) {
          switch (action) {
            case 'add':
              BlocProvider.of<CrudPostBloc>(context)
                  .add(AddPostEvent(post: post));
              break;
            case 'delete':
              BlocProvider.of<CrudPostBloc>(context)
                  .add(DeletePostEvent(id: post.id));
              break;
            case 'update':
              BlocProvider.of<CrudPostBloc>(context)
                  .add(UpdatePostEvent(post: post));
              break;
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _buttonColor(action),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(title),
    );
  }

  Color _buttonColor(String action) {
    switch (action) {
      case 'add':
        return Colors.teal;
      case 'delete':
        return Colors.redAccent;
      case 'update':
        return Colors.blueAccent;
      default:
        return Colors.black12;
    }
  }
}
