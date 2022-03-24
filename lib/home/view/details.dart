import 'package:code_magic_test/home/bloc/authors_bloc.dart';
import 'package:code_magic_test/home/widgets/details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../models/post.dart';

class DetailedPage extends StatelessWidget {
  DetailedPage({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    final String _url = '${post.link}';
    void _launchURL() async {
      if (!await launch(_url)) throw 'Could not launch $_url';
    }

    return BlocProvider(
      create: (_) => AuthorsBloc(httpClient: http.Client()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detailed Page'),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 50),
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  top: 100,
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0xffF5F5F5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          CustomDetailsWidget(
                            label: 'Name :',
                            description: '${post.name}',
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          CustomDetailsWidget(
                            label: 'Quote count :',
                            description: '${post.quoteCount}',
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          CustomDetailsWidget(
                            label: 'Description :',
                            description: '${post.description}',
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          CustomDetailsWidget(
                            label: 'Bio :',
                            description: '${post.bio}',
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          InkWell(
                            onTap: _launchURL,
                            child: CustomDetailsWidget(
                              label: 'Read more :',
                              description: '${post.link}',
                            ),
                          )
                        ],
                      )),
                ),
                Positioned(
                    right: 0,
                    left: 0,
                    child: CircleAvatar(
                        radius: (70),
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                              'https://images.quotable.dev/profile/400/${post.slug}.jpg'),
                        ))),
              ],
            )),
      ),
    );
  }
}
