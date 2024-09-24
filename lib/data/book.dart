import 'package:dart_shelf_crud_example/orm/models.dart';

class Books {
  static const String tableName = 'books';
  static const String idColumn = 'id';
  static const String titleColumn = 'title';
}

class InsertBook implements RawInsertModel {
  final String title;

  InsertBook(this.title);
  
  @override
  String toSQL() => "INSERT INTO ${Books.tableName} (${Books.titleColumn}) VALUES ('$title');";
}

class SelectBook {
  final int id;
  final String title;

  SelectBook({required this.id, required this.title});

  Map<String, dynamic> toJson() => {'id': id, 'title': title};
}

class QueryAllBooks implements RawSelectModel<List<SelectBook>> {

  @override
  List<SelectBook> marshal(List<List<Object?>> rows) {
     return rows.map((row) {
      return SelectBook(
        id: row[0] as int,
        title: row[1] as String,
      );
    }).toList();
  }

  @override
  String toSQL() => "SELECT ${Books.idColumn}, ${Books.titleColumn} FROM ${Books.tableName}";

}