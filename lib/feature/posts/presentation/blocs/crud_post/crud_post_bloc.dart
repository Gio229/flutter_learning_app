import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_new_learning_app/core/config/constants.dart';
import 'package:my_new_learning_app/feature/posts/domain/usecase/add_post.dart';
import 'package:my_new_learning_app/feature/posts/domain/usecase/delete_post.dart';
import 'package:my_new_learning_app/feature/posts/domain/usecase/update_post.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entity/post.dart';

part 'crud_post_event.dart';
part 'crud_post_state.dart';

class CrudPostBloc extends Bloc<CrudPostEvent, CrudPostState> {
  final AddPost addPost;
  final DeletePost deletePost;
  final UpdatePost updatePost;

  CrudPostBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(CrudPostInitial()) {
    on<CrudPostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingCrudState());
        final result = await addPost(event.post);
        emit(emitState(result, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingCrudState());
        final result = await updatePost(event.post);
        emit(emitState(result, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingCrudState());
        final result = await deletePost(event.id);
        emit(emitState(result, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  CrudPostState emitState(Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) => ErrorCrudState(message: _mapFailureMessage(failure)),
        (r) => SuccessCrudState(message));
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Try again';
    }
  }
}
