class Story {
  int? id;
  String title;
  String imageUrl;
  String author;
  String genre;
  String content;

  Story({
    this.id,
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.genre,
    required this.content,
  });

  // Convert ke Map untuk Sqflite
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'imageUrl': imageUrl,
      'author': author,
      'genre': genre,
      'content': content,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Convert dari Map ke objek Story
  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      author: map['author'],
      genre: map['genre'],
      content: map['content'],
    );
  }
}
