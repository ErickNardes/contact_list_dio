import 'package:contact_list_dio/app/contacts/presenter/pages/add_contact_page.dart';
import 'package:contact_list_dio/app/contacts/presenter/pages/contact_page.dart';
import 'package:flutter/material.dart';

class BaseAppPage extends StatefulWidget {
  const BaseAppPage({super.key});

  @override
  State<BaseAppPage> createState() => _BaseAppPageState();
}

class _BaseAppPageState extends State<BaseAppPage> {
  final pageController = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            ContactPage(),
            AddContactPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey,
            onTap: (value) {
              index = value;
              pageController.jumpToPage(value);
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Add',
                icon: Icon(Icons.person),
              ),
            ]));
  }
}
