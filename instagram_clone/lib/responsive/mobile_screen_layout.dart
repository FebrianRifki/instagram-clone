import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    return user == null
        ? const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : Scaffold(
            body: PageView(
              children: homeScreenItems,
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: onPageChanged,
            ),
            bottomNavigationBar: CupertinoTabBar(
              backgroundColor: mobileBackgroundColor,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: _page == 0 ? primaryColor : secondaryColor,
                    ),
                    label: '',
                    backgroundColor: primaryColor),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search,
                        color: _page == 1 ? primaryColor : secondaryColor),
                    backgroundColor: primaryColor),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle,
                        color: _page == 2 ? primaryColor : secondaryColor),
                    label: '',
                    backgroundColor: primaryColor),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite,
                        color: _page == 3 ? primaryColor : secondaryColor),
                    label: '',
                    backgroundColor: primaryColor),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person,
                        color: _page == 4 ? primaryColor : secondaryColor),
                    label: '',
                    backgroundColor: primaryColor)
              ],
              onTap: (value) => navigationTapped(value),
            ),
          );
  }
}
