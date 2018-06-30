import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IncidentData {
  String title, summary, details;
  List<String> imageUrls;

  IncidentData({
    this.title,
    this.summary,
    this.details,
    this.imageUrls,
  });
}

class ReportScreen extends StatefulWidget {
  final FirebaseUser user;

  ReportScreen({Key key, this.user});

  @override
  State<StatefulWidget> createState() => new _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = new GlobalKey<FormState>();
  final _data = new IncidentData();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme.caption.copyWith(
          color: Colors.white,
        );
    return new Scaffold(
      appBar: new AppBar(
        title: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: Theme.of(context).platform == TargetPlatform.iOS
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: <Widget>[
            new Text("Ogombo Road"),
            new InkWell(
              onTap: () {},
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text("Change location", style: theme),
                  new Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.camera_alt),
            onPressed: () {},
          )
        ],
      ),
      body: new SafeArea(
        child: _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return new Container(
      child: new Form(
        key: _formKey,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: new Column(
                  children: <Widget>[
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        validator: (value) => value.isEmpty
                            ? "Provide a title for this incident"
                            : null,
                        onSaved: (String value) => _data.title = value),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Summary',
                        ),
                        maxLines: 2,
                        validator: (value) => value.isEmpty
                            ? "Provide a summary of this incident"
                            : null,
                        onSaved: (String value) => _data.summary = value),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        onSaved: (String value) => _data.details = value),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: new SizedBox(
                width: double.infinity,
                child: new RaisedButton(
                  child: new Text("SUBMIT"),
                  onPressed: () => _handleSubmit(context),
                  textColor: Theme.of(context).canvasColor,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_data);
    }
  }
}
