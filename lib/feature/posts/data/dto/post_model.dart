import 'package:my_new_learning_app/feature/posts/domain/entity/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> postJson) {
    return PostModel(
      userId: postJson['userId'],
      id: postJson['id'],
      title: postJson['title'],
      body: postJson['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return ({
      'userId': userId,
      'id': id,
      'title': title,
      'body': body, 
    });
  }
}
