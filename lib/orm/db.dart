import 'package:dart_shelf_crud_example/orm/models.dart';

class Db {
  final DbDriver driver;

  Db(this.driver);

  Future<void> insert(RawInsertModel model) async {
    var sql = model.toSQL();
    await driver.execute(sql);
  }

  Future<R> query<R>(RawSelectModel<R> model) async {
    var rows = await driver.execute(model.toSQL());
    return model.marshal(rows);
  }
}

abstract class DbDriver {
  Future<List<List<Object?>>> execute(String sql);
}
