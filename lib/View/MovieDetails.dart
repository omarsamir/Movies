import 'package:flutter/material.dart';
import 'package:my_first_app/Model/Movies.dart';
import 'package:my_first_app/Support_files/Constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MovieDetails extends StatefulWidget {
  Results movie = new Results();
  @override
  MovieDetailsState createState() => MovieDetailsState(movie);
  MovieDetails(Results movie) {
    this.movie = movie;
  }
}

class MovieDetailsState extends State<MovieDetails> {
  Results movie = new Results();
  double _viewWidth = 0;
  MovieDetailsState(Results movie) {
    this.movie = movie;
  }

  @override
  Widget build(BuildContext context) {
    _viewWidth = MediaQuery.of(context).size.width;
    var image = new Image(
      image: AssetImage('images/glass.jpg'),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.movie),
                text: "Movie Summary",
              ),
              Tab(
                icon: Icon(Icons.public),
                text: "Movie Description",
              ),
            ],
          ),
          title: Text("Movie Details"),
        ),
        body: TabBarView(
          children: [
            movieSummary(),
            movieDescription(),
          ],
        ),
      ),
    );
  }

  Widget movieSummary() {
    var movieImage = Image(
      image: NetworkImage(Constants.MOVIES_IMAGES_URL + movie.posterPath,
          scale: 1.0),
      height: 200,
      width: 200,
      fit: BoxFit.fill,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(12.0)),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(12.0)),
            movieImage,
            Padding(padding: EdgeInsets.all(5.0)),
            AutoSizeText(
              movie.title,
              style: TextStyle(fontSize: 15.0),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            Text('Original Language: '+ movie.originalLanguage)
          ],
        ),
      ],
    );
  }

  Widget movieDescription (){
    var movieDescription = Container(
      // padding: EdgeInsets.all(10.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: _viewWidth * 0.0,
          maxWidth: _viewWidth * 0.95,
          
        ),
        child: AutoSizeText(
          movie.overview,
          style: TextStyle(fontSize: 15.0),
          overflow: TextOverflow.ellipsis,
          maxLines: 30,
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(2.0)),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0)),
            movieDescription,
          ],
        ),
      ],
    );
  }
}
