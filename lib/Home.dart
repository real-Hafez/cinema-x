import 'package:cinema_x/SearchPage/screen/Search_Screen.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/HomePage/screen/Home_Screen.dart';
import 'package:cinema_x/backdrop_poster_for_popular_and_For_you_movies_and_series/models/popular/popular_tmdb.dart';
import 'package:cinema_x/backdrop_poster_for_popular_and_For_you_movies_and_series/service/popular_service.dart';
import 'package:cinema_x/profileScreen/screen/profile_Screen.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  bool _isBottomBarVisible = true;
  late ScrollController _homeScrollController;
  late ScrollController _searchScrollController;
  final ValueNotifier<bool> _bottomBarVisibilityNotifier = ValueNotifier(true);
  final ValueNotifier<bool> _isSearchingNotifier = ValueNotifier(false);
  late Future<List<popular>> _popularMoviesAndSeries;

  @override
  void initState() {
    super.initState();
    _homeScrollController = ScrollController();
    _searchScrollController = ScrollController();
    _popularMoviesAndSeries = popularService.fetchPopular();

    _homeScrollController.addListener(() {
      _handleScroll(_homeScrollController);
    });

    _searchScrollController.addListener(() {
      _handleScroll(_searchScrollController);
    });
  }

  void _handleScroll(ScrollController scrollController) {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isBottomBarVisible) {
        setState(() {
          _isBottomBarVisible = false;
          _bottomBarVisibilityNotifier.value = false;
        });
      }
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isBottomBarVisible) {
        setState(() {
          _isBottomBarVisible = true;
          _bottomBarVisibilityNotifier.value = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              HomeScreen(
                scrollController: _homeScrollController,
              ),
              FutureBuilder<List<popular>>(
                future: _popularMoviesAndSeries,
                builder: (context, moviesSnapshot) {
                  if (moviesSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (moviesSnapshot.hasError) {
                    return const Center(
                      child: Text(
                        'There was an error. Make sure you have an internet connection.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    );
                  } else if (moviesSnapshot.hasData) {
                    final popularMoviesList = moviesSnapshot.data!;
                    return SearchScreen(
                      Popular: popularMoviesList,
                      bottomBarVisibilityNotifier: _bottomBarVisibilityNotifier,
                      isSearchingNotifier: _isSearchingNotifier,
                      scrollController: _searchScrollController,
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
              const ProfileScreen(),
            ],
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _bottomBarVisibilityNotifier,
            builder: (context, isVisible, child) {
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: isVisible ? 0.9 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(Icons.home, 'Home', 0),
                        _buildNavItem(Icons.search, 'Search', 1),
                        _buildNavItem(Icons.person, 'Profile', 2),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: AnimatedScale(
        scale: isSelected ? 1.3 : 1.0,
        duration: const Duration(milliseconds: 450),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
            Text(
              title,
              style: TextStyle(color: isSelected ? Colors.blue : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _homeScrollController.dispose();
    _searchScrollController.dispose();
    _bottomBarVisibilityNotifier.dispose();
    _isSearchingNotifier.dispose();
    super.dispose();
  }
}
