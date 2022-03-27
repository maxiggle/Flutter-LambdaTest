import 'package:code_magic_test/home/bloc/authors_bloc.dart';
import 'package:code_magic_test/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class App extends MaterialApp {
  App()
      : super(
            debugShowCheckedModeBanner: false,
            home: BlocProvider(
              create: (_) => AuthorsBloc(httpClient: http.Client()),
              child: const PostsPage(),
            ));
}
