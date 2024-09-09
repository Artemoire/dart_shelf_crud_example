class Book {
  final String title;

  Book(this.title);

  Map<String, dynamic> toJson() => {'title': title};

  Book.fromJson(Map<String, dynamic> json) : title = json['title'] as String;

  @override
  String toString() => 'Book($title)';
}
