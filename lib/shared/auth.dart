import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:loudam/shared/strings.dart';

final String facebookAccessToken = Strings.facebookAccessToken;

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();
final TwitterLogin twitterLogin = new TwitterLogin(
  consumerKey: Strings.twitterConsumerKey,
  consumerSecret: Strings.twitterConsumerSecret,
);

Future<FirebaseUser> loginWithGoogle() async {
  GoogleSignInAccount currentUser = googleSignIn.currentUser;
  if (currentUser == null) {
    currentUser = await googleSignIn.signInSilently();
  }
  if (currentUser == null) {
    currentUser = await googleSignIn.signIn();
  }
  var auth = await currentUser.authentication;
  var user = await firebaseAuth.signInWithGoogle(
    accessToken: auth.accessToken,
    idToken: auth.idToken,
  );

  return user;
}

Future<FirebaseUser> loginWithFacebook() async {
  return await firebaseAuth.signInWithFacebook(
    accessToken: facebookAccessToken,
  );
}

Future<FirebaseUser> loginWithTwitter() async {
  var result = await twitterLogin.authorize();
  if (result.status == TwitterLoginStatus.cancelledByUser) {
    throw new Exception("Authorize cancelled.");
  } else if (result.status == TwitterLoginStatus.error) {
    throw new Exception(result.errorMessage);
  }

  var session = result.session;
  return await firebaseAuth.signInWithTwitter(
    authToken: session?.token,
    authTokenSecret: session?.secret,
  );
}

Future<Null> logout() async {
  await firebaseAuth.signOut();
  await googleSignIn.signOut();
  await twitterLogin.logOut();
}
