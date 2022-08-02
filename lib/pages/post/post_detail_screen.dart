import 'package:eclipse_test/components/error_text_widget.dart';
import 'package:eclipse_test/components/rounded_bottom_sheet.dart';
import 'package:eclipse_test/constants/eclipse_text_style.dart';
import 'package:eclipse_test/logic/models/post/create_comment.dart';
import 'package:eclipse_test/logic/models/post/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/comment/comment_bloc.dart';
import "../../utils/text_extensions.dart";

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final commentBloc = CommentBloc();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final commentController = TextEditingController();

  void openBottomSheet() {
    showRoundedBottomSheet(
      context,
      Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1 / 2,
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  label: Text('Name'),
                ),
                autofocus: true,
              ),
              const TextField(
                decoration: InputDecoration(
                  label: Text('Email'),
                ),
                autofocus: true,
              ),
              const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  label: Text('Comment'),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        commentBloc.add(CreateCommentEvent(
                          comment: CreateComment(
                              name: nameController.text,
                              email: emailController.text,
                              body: commentController.text),
                          id: widget.post.id,
                        ));

                        Navigator.pop(context);
                      },
                      child: const Text('Send')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    commentBloc.add(GetComments(id: widget.post.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    widget.post.title.capitalize(),
                    style: EclipseTextStyle.title,
                  ),
                ),
                subtitle: Text(
                  widget.post.body.capitalize(),
                  style: EclipseTextStyle.subtitle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<CommentBloc, CommentState>(
              bloc: commentBloc,
              listener: (context, state) {
                if (state is CreateCommentLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Comment posted')));

                  commentBloc.add(GetComments(id: widget.post.id));
                }
              },
              builder: (context, state) {
                if (state is CommentInitial) {
                  return const CircularProgressIndicator.adaptive();
                }

                if (state is CommentLoaded) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.postComments.length,
                      itemBuilder: (context, i) {
                        final postComment = state.postComments[i];

                        return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Comment:',
                                  style: EclipseTextStyle.categoryTitle,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  postComment.body,
                                  style: EclipseTextStyle.categoryValue,
                                ),
                                _CustomListTile(
                                  category: 'Name:',
                                  value: postComment.name,
                                ),
                                _CustomListTile(
                                  category: 'Email:',
                                  value: postComment.email,
                                ),
                              ],
                            ));
                      },
                      separatorBuilder: (_, i) => const SizedBox(height: 10),
                    ),
                  );
                }

                return const ErrorTextWidget();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String category;

  final String value;

  const _CustomListTile({required this.category, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              category,
              style: EclipseTextStyle.categoryTitle,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                style: EclipseTextStyle.categoryValue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
