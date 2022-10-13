part of 'crud_post_bloc.dart';

abstract class CrudPostEvent extends Equatable {
  const CrudPostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends CrudPostEvent {
  final Post post;

  const AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends CrudPostEvent {
  final int id;

  const DeletePostEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdatePostEvent extends CrudPostEvent {
  final Post post;

  const UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}
