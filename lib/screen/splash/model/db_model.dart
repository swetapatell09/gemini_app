class DbModel {
  int? id, status;
  String? result;

  DbModel({this.id, this.result, this.status});

  factory DbModel.mapToModel(Map m1) {
    return DbModel(
      id: m1['id'],
      result: m1['result'],
      status: m1['status'],
    );
  }
}
