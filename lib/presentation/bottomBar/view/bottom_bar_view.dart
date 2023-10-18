// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class BottomBarView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomBarView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (pageList.length == 1 && pageList.contains(0)) {
          SystemNavigator.pop();
        } else {
          pageList.removeLast();
          navigationShell.goBranch(
            pageList.last,
            initialLocation: pageList.last == navigationShell.currentIndex,
          );
        }
        return Future.value(false);
      },
      child: Scaffold(
        key: UniqueKey(),
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shoppe'),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Test'),
          ],
          onTap: _onTap,
        ),
      ),
    );
  }

  void _onTap(index) {
    if (pageList.length <= 2) {
      if (pageList.contains(index)) {
        pageList.remove(index);
      }
    } else {
      pageList.removeAt(1);
    }
    pageList.add(index);
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

var pageList = [0];
