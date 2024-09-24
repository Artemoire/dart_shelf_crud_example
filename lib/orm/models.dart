abstract class RawInsertModel {
  String toSQL();
}

abstract class RawSelectModel<T> {
  String toSQL();
  T marshal(List<List<Object?>> rows);
}