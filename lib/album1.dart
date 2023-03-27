class Album {
  final String id;
  final String name;
  final String url;
  final double width;
  final double height;
  final int box_count;
  final int captions;
  final bool success;

  const Album ({
    required this.id,
    required this.name,
    required this.url,
    required this.width,
    required this.height,
    required this.box_count,
    required this.captions,
    required this.success,
  });

  factory Album.fromJson(dynamic json,int i) {
    return Album(
      id: json['data']["memes"][i]["id"],
      name: json['data']["memes"][i]["name"],
      url: json['data']["memes"][i]["url"],
      width: json['data']["memes"][i]["width"],
      height: json['data']["memes"][i]["height"],
      box_count: json['data']["memes"][i]["box_count"],
      captions: json['data']["memes"][i]["captions"],
      success: json['success'],
    );
  }
}