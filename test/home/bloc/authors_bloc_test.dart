import 'package:bloc_test/bloc_test.dart';
import 'package:code_magic_test/home/bloc/authors_bloc.dart';
import 'package:code_magic_test/home/models/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

Uri _postsUrl() {
  return Uri.https('quotable.io', '/authors');
}

void main() {
  group('AuthorsBloc', () {
    const mockPosts = [
      Post(
        id: "_id",
        bio: "bio",
        dateAdded: "dateAdded",
        dateModified: "dateModified",
        description: "description",
        name: "slug",
        slug: 'qwerty',
        link: "link",
        quoteCount: 2,
      )
    ];

    late http.Client httpClient;

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    setUp(() {
      httpClient = MockClient();
    });

    test('initial state is AuthorsState()', () {
      expect(AuthorsBloc(httpClient: httpClient).state, const AuthorsState());
    });

    group('Should tell if a post was fetched', () {
      blocTest<AuthorsBloc, AuthorsState>(
        'emits successful status when http fetches initial posts',
        setUp: () {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response(
              '[{"id": "id","description": "Authors description", "name": "name";,"slug": "slug", "link": "link",}]',
              200,
            );
          });
        },
        build: () => AuthorsBloc(httpClient: httpClient),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => const <AuthorsState>[
          AuthorsState(
            authorsStatus: AuthorsStatus.successful,
            posts: mockPosts,
          )
        ],
        verify: (_) {
          verify(() => httpClient.get(_postsUrl())).called(1);
        },
      );

      blocTest<AuthorsBloc, AuthorsState>(
        'drops new events when processing current event',
        setUp: () {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response(
              '[{ "id": "id","description": "Authors description", "name": "name";,"slug": "slug", "link": "link", }]',
              200,
            );
          });
        },
        build: () => AuthorsBloc(httpClient: httpClient),
        act: (bloc) => bloc
          ..add(PostFetched())
          ..add(PostFetched()),
        expect: () => const <AuthorsState>[
          AuthorsState(
            authorsStatus: AuthorsStatus.successful,
            posts: mockPosts,
          )
        ],
        verify: (_) {
          verify(() => httpClient.get(any())).called(1);
        },
      );

      blocTest<AuthorsBloc, AuthorsState>(
        'throttles events',
        setUp: () {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response(
              '[{ "id": 1, "title": "post title", "body": "post body" }]',
              200,
            );
          });
        },
        build: () => AuthorsBloc(httpClient: httpClient),
        act: (bloc) async {
          bloc.add(PostFetched());
          await Future<void>.delayed(Duration.zero);
          bloc.add(PostFetched());
        },
        expect: () => const <AuthorsState>[
          AuthorsState(
            authorsStatus: AuthorsStatus.successful,
            posts: mockPosts,
          )
        ],
        verify: (_) {
          verify(() => httpClient.get(any())).called(1);
        },
      );

      blocTest<AuthorsBloc, AuthorsState>(
        'emits failure status when http fetches posts and throw exception',
        setUp: () {
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response('', 500),
          );
        },
        build: () => AuthorsBloc(httpClient: httpClient),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => <AuthorsState>[
          const AuthorsState(authorsStatus: AuthorsStatus.failed)
        ],
        verify: (_) {
          verify(() => httpClient.get(_postsUrl())).called(1);
        },
      );
    });
  });
}
