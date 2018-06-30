import 'package:flutter/material.dart';
import 'package:loudam/shared/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();

    firebaseAuth.onAuthStateChanged
        .firstWhere((user) => user != null)
        .then((user) => Navigator.of(context).pushReplacementNamed("home"));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Builder(
        builder: (BuildContext context) => new Column(
              children: <Widget>[
                new Flexible(
                  flex: 2,
                  child: new Container(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                new Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 48.0,
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new SizedBox(
                          width: double.infinity,
                          child: new RaisedButton.icon(
                            icon: new Image.asset(
                              "res/icons/google.png",
                              color: Colors.white,
                              height: 16.0,
                            ),
                            label: new Text("SIGN IN WITH GOOGLE"),
                            color: Colors.red[600],
                            textColor: Colors.white,
                            onPressed: () => loginWithGoogle(),
                          ),
                        ),
                        new SizedBox(height: 16.0),
                        new SizedBox(
                          width: double.infinity,
                          child: new RaisedButton.icon(
                            icon: new Image.asset(
                              "res/icons/facebook.png",
                              color: Colors.white,
                              height: 16.0,
                            ),
                            label: new Text("SIGN IN WITH FACEBOOK"),
                            color: Colors.blue[800],
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                        new SizedBox(height: 16.0),
                        new SizedBox(
                          width: double.infinity,
                          child: new RaisedButton.icon(
                            icon: new Image.asset(
                              "res/icons/twitter.png",
                              color: Colors.white,
                              height: 16.0,
                            ),
                            label: new Text("SIGN IN WITH TWITTER"),
                            color: Colors.lightBlue[400],
                            textColor: Colors.white,
                            onPressed: () async {
                              try {
                                await loginWithTwitter();
                              } catch (err) {
                                Scaffold.of(context).showSnackBar(new SnackBar(
                                      content: new Text("${err.message}"),
                                    ));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
      ),
    );
  }
}
