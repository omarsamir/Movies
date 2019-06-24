import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  @override
  MovieDetailsState createState() => MovieDetailsState();
}

class MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    var image = new Image(
      image: AssetImage('images/glass.jpg'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
          // image,
        ],
      ),
    );
  }
}
