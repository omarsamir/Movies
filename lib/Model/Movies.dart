import 'dart:io' show Platform;

class Movies {
  int page = 0;
  int totalResults = 0;
  int totalPages = 0;
  List<Results> results = List<Results>();

  Movies({this.page, this.totalResults, this.totalPages, this.results});

  Movies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int voteCount = 0;
  int id = 0;
  bool video = false;
  double voteAverage = 0.0;
  String title = "";
  double popularity;
  String posterPath = "";
  String originalLanguage = "";
  String originalTitle = "";
  List<int> genreIds = List<int>();
  String backdropPath = "";
  bool adult = false;
  String overview = "";
  String releaseDate = "";
  String platform = Platform.isAndroid?"Android":"iOS";

  Results(
      {this.voteCount,
      this.id,
      this.video,
      this.voteAverage,
      this.title,
      this.popularity,
      this.posterPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.backdropPath,
      this.adult,
      this.overview,
      this.releaseDate});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['vote_count'] != null){
      voteCount = json['vote_count'];
    }
    if(json['id'] != null){
      id = json['id'];
    }
    
    if(json['video'] != null){
       video = json['video'];
    }

    if(json['vote_average'] != null){
      voteAverage = json['vote_average'].toDouble();
    }
    
    if(json['title'] != null){
       title = json['title'];
    }
   
    if(json['popularity'] != null){
      popularity = json['popularity'].toDouble();;
    }
    
    if(json['poster_path'] != null){
      posterPath = json['poster_path'];
    }
    
    
    if(json['original_language'] != null){
      originalLanguage = json['original_language'];
    }
    
    if(json['original_title'] != null){
      originalTitle = json['original_title'];
    }
    
    if(json['genre_ids'] != null){
      genreIds = json['genre_ids'].cast<int>();
    }
    
    if(json['backdrop_path'] != null){
       backdropPath = json['backdrop_path'];
    }
   
    if(json['adult'] != null){
       adult = json['adult'];
    }
   
    if(json['overview'] != null){
      overview = json['overview'];
    }
    
    if(json['release_date'] != null){
      releaseDate = json['release_date'];
    }
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_count'] = this.voteCount;
    data['id'] = this.id;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['title'] = this.title;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['backdrop_path'] = this.backdropPath;
    data['adult'] = this.adult;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['platform'] = this.platform;
    return data;
  }
}