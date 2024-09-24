import 'dart:io';

import 'package:dart_shelf_crud_example/db_instance.dart';
import 'package:dart_shelf_crud_example/handlers/book_handler.dart';
import 'package:dart_shelf_crud_example/orm/postgres.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/books', listBooks)
  ..post('/books', addBook);

void main(List<String> args) async {
  final conn = await Connection.open(
      Endpoint(
        host: 'localhost',
        database: 'postgres',
        username: 'user',
        password: 'pass',
        port: 5432,
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable));

  await conn.execute('''CREATE TABLE IF NOT EXISTS books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL
);
''');

  (database.driver as PostgresDbDriver).connect(conn);

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
