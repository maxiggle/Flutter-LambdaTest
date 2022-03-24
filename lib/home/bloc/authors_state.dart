part of 'authors_bloc.dart';

enum AuthorsStatus { initial, successful, failed }

class AuthorsState extends Equatable {
  final AuthorsStatus authorsStatus;
  final List<Post> posts;

  const AuthorsState({
    this.posts = const [],
    this.authorsStatus = AuthorsStatus.initial,
  });

  AuthorsState copyWith({
    AuthorsStatus? authorsStatus,
    List<Post>? posts,
  }) {
    return AuthorsState(
      authorsStatus: authorsStatus ?? this.authorsStatus,
      posts: posts ?? this.posts,
    );
  }

  @override
  String toString() {
    return 'AuthorsState{authorsStatus: $authorsStatus, posts: $posts}';
  }

  @override
  List<Object> get props => [];
}
