import 'dart:convert';

import 'package:dart_shelf_crud_example/data/book.dart';
import 'package:dart_shelf_crud_example/db_instance.dart';
import 'package:shelf/shelf.dart';

Future<Response> listBooks(Request req) async {
  return Response.ok(jsonEncode(await database.query(QueryAllBooks())),
      headers: {'Content-Type': 'application/json'});
}

Future<Response> addBook(Request req) async {
  final title = await req.readAsString();

  await database.insert(InsertBook(title));

  return Response.ok(
      jsonEncode({
        'status': 'success',
      }),
      headers: {'Content-Type': 'application/json'});
}
