import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
//import 'package:http/http.dart' as http;
import 'package:my_new_learning_app/core/config/constants.dart';

import '../../../../core/errors/exceptions.dart';
import '../dto/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  //final http.Client client;
  final Dio client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final response = await client.post("$BASE_URL/posts/",
      data: postModel.toJson()
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete("$BASE_URL/posts/${postId.toString()}");

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      final List decodedJson = response.data ;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final response = await client.patch("$BASE_URL/posts/$postId");

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
