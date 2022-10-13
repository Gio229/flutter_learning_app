import 'package:dartz/dartz.dart';
import 'package:my_new_learning_app/feature/posts/domain/repository/posts_repository.dart';

import '../../../../core/errors/failures.dart';

class DeletePost {
  final PostsRepository postsRepository;

  DeletePost(this.postsRepository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await postsRepository.deletePost(id);
  }
}
