import 'package:flutter/material.dart';
import 'package:loudam/shared/data.dart';

class IncidentScreen extends StatefulWidget {
  IncidentScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _IncidentScreenState();
}

class _IncidentScreenState extends State<IncidentScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: incidents
            .map((Incident i) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: new Card(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new InkWell(
                          child: new Container(
                            height: 100.0,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(i.imageUrls[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () => Navigator.of(context).pushNamed("incident-detail/${i.id}"),
                        ),
                        new ListTile(
                          title: new Text(i.title),
                          subtitle: new Text(i.summary),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
