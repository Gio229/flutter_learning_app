import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_new_learning_app/core/config/constants.dart';
import 'package:my_new_learning_app/feature/posts/domain/usecase/get_all_posts.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entity/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPost getAllPost;
  PostBloc({required this.getAllPost}) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final resultPosts = await getAllPost();
        emit(_stateToEmit(resultPosts));
      }
    });
  }

// ----------

//

  PostState _stateToEmit(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => ErrorPostsState(message: _mapMessageFailure(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  String _mapMessageFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
