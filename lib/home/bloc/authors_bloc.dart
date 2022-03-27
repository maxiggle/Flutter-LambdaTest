import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../models/post.dart';

part 'authors_event.dart';
part 'authors_state.dart';

class AuthorsBloc extends Bloc<AuthorsEvent, AuthorsState> {
  AuthorsBloc({required this.httpClient}) : super(const AuthorsState()) {
    on<PostFetched>(
      _onPostFetched,
    );
  }
  final http.Client httpClient;
  Future<void> _onPostFetched(
      AuthorsEvent event, Emitter<AuthorsState> emit) async {
    try {
      if (state.authorsStatus == AuthorsStatus.initial) {
        final post = await _fetchPost();
        return emit(state.copyWith(
          authorsStatus: AuthorsStatus.successful,
          posts: List.of(state.posts)..addAll(post),
        ));
      }
    } catch (e) {
      emit(state.copyWith(authorsStatus: AuthorsStatus.failed));
    }
  }

  Future<List<Post>> _fetchPost() async {
    final response = await httpClient.get(
      Uri.parse('https://quotable.io/authors'),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      final resultJson = body['results'] as List<dynamic>;
      final results = resultJson.map((e) => Post.fromMap(e)).toList();

      return results;
    }
    throw Exception('error fetching posts');
  }
}
