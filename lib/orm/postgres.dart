import 'package:dart_shelf_crud_example/orm/db.dart';
import 'package:postgres/postgres.dart';

class PostgresDbDriver implements DbDriver {
  late final Connection _conn;

  PostgresDbDriver();

  connect(Connection conn) {
    _conn = conn;
  }

  @override
  Future<List<List<Object?>>> execute(String sql) {    
    return _conn.execute(sql);
  }

}
