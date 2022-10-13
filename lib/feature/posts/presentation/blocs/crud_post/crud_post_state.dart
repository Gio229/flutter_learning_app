part of 'crud_post_bloc.dart';

abstract class CrudPostState extends Equatable {
  const CrudPostState();

  @override
  List<Object> get props => [];
}

class CrudPostInitial extends CrudPostState {}

class LoadingCrudState extends CrudPostState {}

class ErrorCrudState extends CrudPostState {
  final String message;

  const ErrorCrudState({required this.message});
  
  @override
  List<Object> get props => [message];
}

class SuccessCrudState extends CrudPostState {
  final String message;

  const SuccessCrudState(this.message);

  @override
  List<Object> get props => [message];
}
