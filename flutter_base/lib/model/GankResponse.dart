class GankResponse {
  bool error;
  List<dynamic> results;

  GankResponse(this.error, this.results);

  GankResponse.fromJson(Map<String, dynamic> json) {
    this.error = json['error'];
    this.results = json['results'];
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'results': results,
      };
}
