import 'package:my_new_learning_app/core/errors/exceptions.dart';
import 'package:my_new_learning_app/feature/posts/data/datasources/post_local_datasource.dart';
import 'package:my_new_learning_app/feature/posts/data/datasources/post_remote_datasource.dart';
import 'package:my_new_learning_app/feature/posts/domain/entity/post.dart';

import 'package:my_new_learning_app/core/errors/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repository/posts_repository.dart';
import '../dto/post_model.dart';

typedef AddOrDeleteOrUpdatePost = Future<Unit> Function();

class PostRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    PostModel postModel = PostModel(
        id: post.id, title: post.title, body: post.body, userId: post.userId);

    return await handleRequest(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await handleRequest(() => remoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final posts = await remoteDataSource.getAllPosts();
        localDataSource.cashePosts(posts);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      final posts = await localDataSource.getCashedPost();
      if (posts.isNotEmpty) {
        return Right(posts);
      }
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModel postModel = PostModel(
        id: post.id, title: post.title, body: post.body, userId: post.userId);
    return await handleRequest(() => remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> handleRequest(
      AddOrDeleteOrUpdatePost addOrDeleteOrUpdatePost) async {
    if (await networkInfo.isConnected) {
      try {
        await addOrDeleteOrUpdatePost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
