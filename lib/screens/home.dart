import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loudam/screens/follows.dart';
import 'package:loudam/screens/incidents.dart';
import 'package:loudam/screens/profile.dart';
import 'package:loudam/screens/report.dart';
import 'package:loudam/shared/auth.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseUser currentUser;
  int _currentPage = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();

    firebaseAuth.currentUser().then((user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 2.0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: this.currentUser != null
              ? new InkWell(
                  onTap: () => _showSettings(context),
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(currentUser.photoUrl),
                    maxRadius: 6.0,
                  ))
              : new CircleAvatar(
                  maxRadius: 6.0,
                ),
        ),
        title: new Text(this._currentPage == 0 ? "Recent" : "Following"),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _currentPage,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            title: new Text("Recent"),
            icon: new Icon(Icons.comment),
          ),
          new BottomNavigationBarItem(
            title: new Text("Following"),
            icon: new Icon(Icons.bookmark),
          ),
        ],
        onTap: (int page) {
          _pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 150),
            curve: Curves.ease,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        elevation: 0.0,
        child: new Icon(
          Icons.add,
          size: 36.0,
        ),
        onPressed: () => _showCreateReport(context),
      ),
      body: new PageView(
        controller: _pageController,
        children: <Widget>[
          new IncidentScreen(),
          new FollowsScreen(),
        ],
        onPageChanged: (int page) {
          setState(() => this._currentPage = page);
        },
      ),
    );
  }

  _showSettings(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new UserProfileScreen(user: this.currentUser),
        ));
  }

  _showCreateReport(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new ReportScreen(user: this.currentUser),
        ));
  }
}
