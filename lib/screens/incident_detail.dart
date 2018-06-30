import 'package:flutter/material.dart';
import 'package:loudam/shared/data.dart';
import 'package:loudam/shared/strings.dart';
import 'package:map_view/map_view.dart';

class IncidentDetailScreen extends StatefulWidget {
  final Incident incident;

  IncidentDetailScreen({Key key, this.incident}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _IncidentDetailScreenState();
}

class _IncidentDetailScreenState extends State<IncidentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          _showImages(context),
          _showContent(context),
        ],
      ),
    );
  }

  Widget _showImages(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.0,
      pinned: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.bookmark_border),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(widget.incident.imageUrls[0]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  ImageProvider _showMap(BuildContext context) {
    var mapsProvider = new StaticMapProvider(Strings.mapsApiKey);
    var url = mapsProvider.getStaticUri(
      widget.incident.location,
      15,
      height: 100,
    );
    return new NetworkImage(url.toString());
  }

  Widget _showContent(BuildContext context) {
    return new SliverList(
      delegate: new SliverChildListDelegate(
        <Widget>[
          new ListTile(
            leading: new CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: new NetworkImage(widget.incident.authorPhotoUrl),
              radius: 24.0,
            ),
            title: new Text(widget.incident.title),
            subtitle: new Text(widget.incident.summary),
            contentPadding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
          ),
          ListTileTheme.merge(
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(widget.incident.details),
                ),
                new ListTile(
                  title: new Text("Posted on ${widget.incident.posted} by ${widget.incident.authorName}"),
                ),
                new ListTile(
                  title: new Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: _showMap(context),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: const EdgeInsets.only(bottom: 24.0),
                    height: 80.0,
                  ),
                ),
              ],
            ),
            contentPadding: const EdgeInsets.fromLTRB(80.0, 0.0, 24.0, 0.0),
            dense: true,
          )
        ],
      ),
    );
  }
}
