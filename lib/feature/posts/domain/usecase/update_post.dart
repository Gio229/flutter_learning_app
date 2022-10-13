import 'package:dartz/dartz.dart';
import 'package:my_new_learning_app/feature/posts/domain/repository/posts_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entity/post.dart';

class UpdatePost {
  final PostsRepository postsRepository;

  UpdatePost(this.postsRepository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postsRepository.updatePost(post);
  }
}
