import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:english_words/english_words.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_first_app/Model/Movies.dart';
import 'package:my_first_app/Support_files/Constants.dart';
import 'MovieDetails.dart';
import 'package:my_first_app/Managers/APIClient.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomePage extends StatefulWidget {
  @override
  FirstPage createState() => FirstPage();
}

class FirstPage extends State<HomePage> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  double _viewWidth = 0;
  APIClient apiClient = APIClient();
  List<Results> movies = new List<Results>();
  bool needToLoadNewPage = true;
  int page = 0;

  @override
  Widget build(BuildContext context) {
    _viewWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('All Movies'),
        ),
        body: ModalProgressHUD(
            child: Container(
              child: _buildSuggestions(),
            ),
            inAsyncCall: needToLoadNewPage),
      ),
    );
  }

  Future _loadMoreMovies() async {
    if (needToLoadNewPage) {
      page++;
      apiClient.fetchMovies(page).then((val) {
         movies += val.results;
        setState(() {
          needToLoadNewPage = false;
        });
      });
    }
  }

  Widget _buildSuggestions() {
    _loadMoreMovies();
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
         if (needToLoadNewPage == false){   
            // needToLoadNewPage = true;
           setState(() {
             needToLoadNewPage = true;
           });   
          }
        }
      },
      child: ListView.builder(
          padding: const EdgeInsets.all(5.0),
          itemBuilder: /*1*/ (context, i) {
            if (i < (movies.length - 1) &&
                movies != null &&
                i < movies.length) {
              print("START RESULT NUM: #" +
                  i.toString() +
                  " Movie : " +
                  movies[i].title);
              return _buildRow(movies[i]);
            }
          }),
    );
  }

  Widget _buildRow(Results movie) {

var poster ;
if(movie.posterPath != null){
    poster =  NetworkImage(Constants.MOVIES_IMAGES_URL + movie.posterPath,
          scale: 1.0);
} else {
    poster = AssetImage("images/fa-image.png");
}
    var image = new Image(
      image: poster,
      height: 100,
      width: 100,
      fit: BoxFit.fill,
    );
    var movieTitle = Container(
      // padding: EdgeInsets.all(10.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: _viewWidth * 0.30,
          maxWidth: _viewWidth * 0.55,
          minHeight: 30.0,
          maxHeight: 30.0,
        ),
        child: AutoSizeText(
          movie.title,
          style: TextStyle(fontSize: 15.0),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );

    var movieDescription = Container(
      // padding: EdgeInsets.all(10.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: _viewWidth * 0.30,
          maxWidth: _viewWidth * 0.55,
          minHeight: 30.0,
          maxHeight: 130.0,
        ),
        child: AutoSizeText(
          movie.overview,
          style: TextStyle(fontSize: 15.0),
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ),
      ),
    );

    var movieDate = Text(
      '15-07-2019',
      style: new TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
    );
    var columnPaddingM = Padding(
      padding: EdgeInsets.all(2.0),
    );
    var columnPaddingL = Padding(
      padding: EdgeInsets.all(10.0),
    );
    var movieDetailsColumn = Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        movieTitle,
        columnPaddingM,
        movieDescription,
        columnPaddingM,
        movieDate,
        columnPaddingM,
      ],
    );
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print("object TTTTT");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MovieDetails(movie)),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              image,
              columnPaddingL,
              movieDetailsColumn,
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
