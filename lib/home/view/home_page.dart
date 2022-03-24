import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../bloc/authors_bloc.dart';
import '../widgets/bottom_loader.dart';
import '../widgets/post_list_item.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Code Magic')),
      body: BlocProvider(
        create: (_) =>
            AuthorsBloc(httpClient: http.Client())..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}

class PostsList extends StatefulWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorsBloc, AuthorsState>(
      builder: (context, state) {
        switch (state.authorsStatus) {
          case AuthorsStatus.failed:
            return const Center(child: Text('failed to fetch posts'));
          case AuthorsStatus.successful:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                thickness: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                    ? BottomLoader()
                    : PostListItem(post: state.posts[index]);
              },
              itemCount: state.posts.length,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
