import 'package:eclipse_test/components/error_text_widget.dart';
import 'package:eclipse_test/logic/bloc/post/post_bloc.dart';
import 'package:eclipse_test/logic/models/post/post.dart';
import 'package:eclipse_test/pages/post/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/text_extensions.dart';
import '../../constants/eclipse_text_style.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final postBloc = PostBloc();

  @override
  void initState() {
    postBloc.add(GetPostList());

    super.initState();
  }

  void onTapTop(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetail(
          post: post,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
              child: BlocBuilder<PostBloc, PostState>(
            bloc: postBloc,
            builder: (context, state) {
              if (state is PostInitial) {
                return const CircularProgressIndicator.adaptive();
              }

              if (state is PostListLoaded) {
                return ListView.separated(
                  itemCount: state.postList.length,
                  itemBuilder: (context, i) {
                    final post = state.postList[i];
                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        onTap: (() => onTapTop(post)),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            post.title.capitalize(),
                            style: EclipseTextStyle.title,
                          ),
                        ),
                        subtitle: Text(
                          post.body.capitalize(),
                          style: EclipseTextStyle.subtitle,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, i) => const SizedBox(height: 10),
                );
              }

              return const ErrorTextWidget();
            },
          )),
        ),
      ),
    );
  }
}
