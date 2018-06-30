import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loudam/shared/auth.dart';

class UserProfileScreen extends StatefulWidget {
  final FirebaseUser user;

  UserProfileScreen({Key key, this.user});

  @override
  State<UserProfileScreen> createState() => new _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          _showUser(context),
          _showLogout(context),
          _showStats(context),
          _showHeader("Posts"),
          _showPosts(context),
          _showHeader("Following"),
          _showFollowing(context),
        ],
      ),
    );
  }

  Widget _showHeader(String title) {
    return new SliverPadding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 8.0,
        bottom: 6.0,
      ),
      sliver: new SliverToBoxAdapter(
        child: new Text(
          title,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }

  Widget _showLogout(BuildContext context) {
    return new SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      sliver: new SliverToBoxAdapter(
        child: new FlatButton(
          child: new Text("LOGOUT"),
          onPressed: () async {
            await logout();
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed("/");
          },
        ),
      ),
    );
  }

  Widget _showUser(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return SliverAppBar(
      expandedHeight: 300.0,
      pinned: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: new Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            new Container(
              color: theme.canvasColor,
              height: 116.0,
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  widget.user.displayName,
                  style: textTheme.headline,
                ),
                new Text(
                  widget.user.email,
                  style: textTheme.body1.copyWith(
                    color: theme.primaryColorDark,
                  ),
                ),
                new SizedBox(height: 16.0),
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: new NetworkImage(widget.user.photoUrl),
                  radius: 48.0,
                ),
                new SizedBox(height: 70.0),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _showStats(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return new SliverFixedExtentList(
      itemExtent: 130.0,
      delegate: new SliverChildListDelegate(<Widget>[
        new Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "3",
                      style: theme.display1,
                    ),
                    new Text("Incidents")
                  ],
                ),
              ),
              new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "1",
                      style: theme.display1,
                    ),
                    new Text("Following")
                  ],
                ),
              ),
              new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "0",
                      style: theme.display1,
                    ),
                    new Text("Supporting")
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _showPosts(BuildContext context) {
    return new SliverGrid(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return new Container(
            color: Colors.teal[100 * (index % 7) + 100],
          );
        },
        childCount: 6,
      ),
    );
  }

  Widget _showFollowing(BuildContext context) {
    return new SliverPadding(
      padding: const EdgeInsets.only(bottom: 32.0),
      sliver: new SliverFixedExtentList(
        itemExtent: 80.0,
        delegate: new SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.5),
              child: new Container(
                color: Colors.teal[100 * (index % 5) + 100],
              ),
            );
          },
          childCount: 4,
        ),
      ),
    );
  }
}
