import 'package:flutter/material.dart';
import 'package:sean_tes_it_mobile_programmer/ui/pages/favorite_user_page.dart';
import 'package:sean_tes_it_mobile_programmer/ui/pages/home_user_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F8FF),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'GitHub Users',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1565C0),
                  Color(0xFF1E88E5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TabBar(
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Color(0xFF1565C0),
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(text: 'Home'),
                  Tab(text: 'Favorite'),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            HomeUserTab(),
            FavoriteUserPage(),
          ],
        ),
      ),
    );
  }
}
