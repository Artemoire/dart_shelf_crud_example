import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:dart_shelf_crud_example/models/book.dart';

List<Book> _globalBooks = [];

Response listBooks(Request req) {
  return Response.ok(jsonEncode(_globalBooks),
      headers: {'Content-Type': 'application/json'});
}

Future<Response> addBook(Request req) async {
  final bodyString = await req.readAsString();
  final book = Book.fromJson(jsonDecode(bodyString));

  _globalBooks.add(book);

  return Response.ok(
      jsonEncode({
        'status': 'success',
      }),
      headers: {'Content-Type': 'application/json'});
}
