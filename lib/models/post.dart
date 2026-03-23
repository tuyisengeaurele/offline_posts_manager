class Post {
  final int? id;
  final String title;
  final String content;
  final String author;
  final String createdAt;

  Post({
    this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'createdAt': createdAt,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('title') ||
        !map.containsKey('content') ||
        !map.containsKey('author') ||
        !map.containsKey('createdAt')) {
      throw FormatException('Invalid or corrupted post data');
    }

    return Post(
      id: map['id'] as int?,
      title: map['title']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      author: map['author']?.toString() ?? '',
      createdAt: map['createdAt']?.toString() ?? '',
    );
  }
}
