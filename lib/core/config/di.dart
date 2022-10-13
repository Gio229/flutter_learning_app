import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_new_learning_app/core/network/network_info.dart';
import 'package:my_new_learning_app/feature/posts/domain/usecase/get_all_posts.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:http/http.dart' as http;

import '../../feature/posts/data/datasources/post_local_datasource.dart';
import '../../feature/posts/data/datasources/post_remote_datasource.dart';
import '../../feature/posts/data/repository/post_repository_impl.dart';
import '../../feature/posts/domain/repository/posts_repository.dart';
import '../../feature/posts/domain/usecase/add_post.dart';
import '../../feature/posts/domain/usecase/delete_post.dart';
import '../../feature/posts/domain/usecase/update_post.dart';
import '../../feature/posts/presentation/blocs/crud_post/crud_post_bloc.dart';
import '../../feature/posts/presentation/blocs/post/post_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(() => PostBloc(getAllPost: sl()));
  sl.registerFactory(
    () => CrudPostBloc(
      addPost: sl(),
      deletePost: sl(),
      updatePost: sl(),
    ),
  );

  //UseCase
  sl.registerLazySingleton(() => GetAllPost(sl()));
  sl.registerLazySingleton(() => AddPost(sl()));
  sl.registerLazySingleton(() => DeletePost(sl()));
  sl.registerLazySingleton(() => UpdatePost(sl()));

// Repository
  sl.registerLazySingleton<PostsRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sl()));

  //! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  //sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
