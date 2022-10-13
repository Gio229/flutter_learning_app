import 'package:dartz/dartz.dart';
import 'package:my_new_learning_app/feature/posts/domain/repository/posts_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entity/post.dart';

class AddPost {
  final PostsRepository postsRepository;

  AddPost(this.postsRepository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postsRepository.addPost(post);
  }
}
