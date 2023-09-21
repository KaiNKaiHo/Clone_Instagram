import 'package:clone_again/screen/add_post_screen.dart';
import 'package:clone_again/screen/feed_screen.dart';
import 'package:clone_again/screen/profile_screen.dart';
import 'package:clone_again/screen/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
