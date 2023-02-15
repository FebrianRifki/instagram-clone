import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _commentController = TextEditingController();
    final User user = Provider.of<UserProvider>(context).getUser!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: ((context, index) => CommentCard(
                    snap: (snapshot.data! as dynamic).docs[index],
                  )));
        }),
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
              radius: 18,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                    hintText: 'Comment as ${user.username}',
                    border: InputBorder.none),
              ),
            )),
            InkWell(
              onTap: () async {
                await FireStoreMethods().postComment(
                    widget.snap['postId'],
                    _commentController.text,
                    user.uid,
                    user.username,
                    user.photoUrl);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
