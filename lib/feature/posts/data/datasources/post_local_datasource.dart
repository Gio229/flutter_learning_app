import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:my_new_learning_app/core/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../dto/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCashedPost();
  Future<Unit> cashePosts(List<PostModel> postModels);
}

class PostLocalDataSourceImpl extends PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<Unit> cashePosts(List<PostModel> postModels) {
    final postModelsToJson = postModels.map((post) => post.toJson()).toList();
    sharedPreferences.setString(CACHED_POSTS, jsonEncode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCashedPost() {
    final postModelsFromJson = sharedPreferences.getString(CACHED_POSTS);
    if (postModelsFromJson != null) {
      List decodeJsonData = jsonDecode(postModelsFromJson);
      List<PostModel> postModels = (decodeJsonData
          .map<PostModel>((post) => PostModel.fromJson(post))
          .toList());
      return Future.value(postModels);
    } else {
      throw CacheException();
    }
  }
}
