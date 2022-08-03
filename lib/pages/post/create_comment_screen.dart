import 'package:eclipse_test/logic/bloc/comment/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/models/post/create_comment.dart';

class CreateCommentScreen extends StatefulWidget {
  const CreateCommentScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<CreateCommentScreen> createState() => _CreateCommentScreenState();
}

class _CreateCommentScreenState extends State<CreateCommentScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final commentController = TextEditingController();

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    commentController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1 / 2,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              autofocus: true,
              controller: nameController,
            ),
            TextField(
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
              controller: emailController,
            ),
            TextField(
              maxLines: 4,
              decoration: const InputDecoration(
                label: Text('Comment'),
              ),
              controller: commentController,
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
                      context.read<CommentBloc>().add(
                            CreateCommentEvent(
                              comment: CreateComment(
                                  name: nameController.text,
                                  email: emailController.text,
                                  body: commentController.text),
                              id: widget.id,
                            ),
                          );

                      Navigator.pop(context);
                    },
                    child: const Text('Send')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
