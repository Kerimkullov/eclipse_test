import 'package:eclipse_test/components/error_text_widget.dart';
import 'package:eclipse_test/logic/bloc/post/post_bloc.dart';
import 'package:eclipse_test/logic/models/post/post.dart';
import 'package:eclipse_test/pages/post/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/text_extensions.dart';
import '../../constants/eclipse_text_style.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key, required this.userId}) : super(key: key);

  final int userId;

  void onTapTop(Post post, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailScreen(
          post: post,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<PostBloc, PostState>(
        bloc: PostBloc()..add(GetPostList(userId: userId)),
        builder: (context, state) {
          if (state is PostInitial) {
            return const CircularProgressIndicator.adaptive();
          }

          if (state is PostListLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                final post = state.postList[i];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    onTap: (() => onTapTop(post, context)),
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
      ),
    );
  }
}
