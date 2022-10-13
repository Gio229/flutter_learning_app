import 'package:dartz/dartz.dart';
import 'package:my_new_learning_app/feature/posts/domain/repository/posts_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entity/post.dart';

class GetAllPost {
  final PostsRepository postsRepository;

  GetAllPost(this.postsRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await postsRepository.getAllPosts();
  }
}
