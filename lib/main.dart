import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_learning_app/feature/posts/presentation/blocs/crud_post/crud_post_bloc.dart';
import 'package:my_new_learning_app/feature/posts/presentation/blocs/post/post_bloc.dart';
import 'package:my_new_learning_app/feature/posts/presentation/pages/posts_page.dart';
import 'core/config/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<PostBloc>()
            ..add(
              GetAllPostsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => di.sl<CrudPostBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const PostsPage(),
      ),
    );
  }
}
