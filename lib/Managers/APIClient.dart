 import 'dart:convert';
import 'package:my_first_app/Model/Movies.dart';
import 'package:http/http.dart' as http;
 import 'package:my_first_app/Support_files/Constants.dart';

class APIClient {
 Future<Movies> fetchMovies(int page) async {
   print("Fetch movies of page: #" + page.toString());
    var url = Constants.moviesBaseurl + page.toString();
    var response = await http.get(url);
     Map<String, dynamic> data = json.decode(response.body);
      var movies = Movies.fromJson(data);
    return movies;
  }

}
 