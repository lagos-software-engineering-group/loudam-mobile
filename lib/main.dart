import 'package:flutter/material.dart';
import 'package:loudam/screens/home.dart';
import 'package:loudam/screens/incident_detail.dart';
import 'package:loudam/screens/login.dart';
import 'package:loudam/shared/data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'LoudAm',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        // brightness: Brightness.dark,
        primarySwatch: Colors.teal,
      ),
      home: new LoginScreen(),
      onGenerateRoute: handleRoute,
    );
  }

  Route<dynamic> handleRoute(RouteSettings settings) {
    final pathSegments = settings.name.split('/');

    switch (pathSegments[0]) {
      case "home":
        return new MaterialPageRoute(
          settings: settings,
          builder: (context) => new HomeScreen(title: "LoudAm"),
        );
      case "incident-detail":
        Incident item = incidents.firstWhere((i) => i.id == pathSegments[1]);
        return new MaterialPageRoute(
          settings: settings,
          builder: (context) => new IncidentDetailScreen(incident: item),
        );
    }

    // Default to Login Screen:
    return new MaterialPageRoute(
      settings: settings,
      builder: (context) => new LoginScreen(),
    );
  }
}
