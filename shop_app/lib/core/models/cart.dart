// 购物车数据模型
class CartModel {
  String id;
  int count;
  String img;
  String name;
  double price;
  bool isSelect;

  CartModel({
    this.id,
    this.img,
    this.name,
    this.count,
    this.price,
    this.isSelect,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      id: json['id'] as String,
      img: json['img'] as String,
      count: json['count'] as int,
      name: json['name'] as String,
      price: json['price'] as double,
      isSelect: json['isSelect'] as bool);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'img': this.img,
        'name': this.name,
        'count': this.count,
        'price': this.price,
        'isSelect': this.isSelect
      };
}
