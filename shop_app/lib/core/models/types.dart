// 分类数据模型
// 一级数据层
class TypeModel {
  int id;
  String name;
  List<TypeData> data;
  String img;

  TypeModel({this.id, this.name, this.data, this.img});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    List<TypeData> type = List<TypeData>();
    if (json['data'] != null) {
      json['data'].forEach((v) {
        type.add(TypeData.fromJson(v));
      });
    }
    return TypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      img: json['img'] as String,
      data: type,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// 二级数据层
class TypeData {
  int id;
  int preId;
  String name;

  TypeData({this.id, this.name, this.preId});

  factory TypeData.fromJson(Map<String, dynamic> json) => TypeData(
        id: json['id'] as int,
        name: json['name'] as String,
        preId: json['preId'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'preId': this.preId,
        'name': this.name,
      };
}
