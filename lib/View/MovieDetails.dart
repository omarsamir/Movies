import 'package:flutter/material.dart';
import 'package:my_first_app/Model/Movies.dart';
import 'package:my_first_app/Support_files/Constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/animation.dart';
import 'package:my_first_app/View/LogoApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieDetails extends StatefulWidget {
  Results movie = new Results();
  @override
  MovieDetailsState createState() => MovieDetailsState(movie);
  MovieDetails(Results movie) {
    this.movie = movie;
  }
}

class MovieDetailsState extends State<MovieDetails>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Results movie = new Results();
  double _viewWidth = 0;
  MovieDetailsState(Results movie) {
    this.movie = movie;
  }

  @override
  void initState() {
    super.initState();
    // Uncomment to activate firestore persisting
    // addDescriptionToFireStore(); 
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewWidth = MediaQuery.of(context).size.width;
return DefaultTabController(
      length: 3,
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
               Tab(
                icon: Icon(Icons.public),
                text: "Movie Animation",
              ),
            ],
          ),
          title: Text("Movie Details"),
        ),
        body: TabBarView(
          children: [
            scrollableMoviesSummary(),
            movieDescription(),
            // flutterLogoAnimation()
            LogoApp()
            // AnimatedLogo2()
          ],
        ),
      ),
    );
  }


Widget flutterLogoAnimation() {
  return Center(            
        child: Container(            
          margin: EdgeInsets.symmetric(vertical: 10),                                                     
        height: animation.value,            
        width: animation.value,            
          child: FlutterLogo(),            
        ),            
      );
}

  Widget scrollableMoviesSummary() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  movieSummary(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget movieSummary() {
    var movieImage = Image(
      image: NetworkImage(Constants.moviesImagesURL + movie.posterPath,
          scale: 1.0),
      height: 200,
      width: 200,
      fit: BoxFit.fill,
    );
    return SingleChildScrollView(
      child: Row(
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
              Text('Original language: ' + movie.originalLanguage),
              Padding(padding: EdgeInsets.all(5.0)),
              Text('Release date: ' + movie.releaseDate)
            ],
          ),
        ],
      ),
    );
  }


void addDescriptionToFireStore(){
  CollectionReference dbMovies = Firestore.instance.collection('Movies');

Firestore.instance.runTransaction((Transaction tx) async {
  print("ADD Movie : " + this.movie.title + "To Firestore");
  await dbMovies.add(this.movie.toJson());
});
}


  Widget movieDescription() {
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
