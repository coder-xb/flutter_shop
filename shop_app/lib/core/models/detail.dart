// 商品详情数据模型
// 一级数据层
class DetailModel {
  DetailInfo info;
  DetailModel({this.info});

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
      info: json['info'] != null ? DetailInfo.fromJson(json['info']) : null);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'info': this.info != null ? this.info : null};
}

// 二级数据层
class DetailInfo {
  String id;
  String img;
  int amount;
  String name;
  double price;
  String shopId;
  double oriPrice;
  String serialId;
  String detail;

  DetailInfo({
    this.id,
    this.img,
    this.name,
    this.price,
    this.amount,
    this.shopId,
    this.detail,
    this.oriPrice,
    this.serialId,
  });

  factory DetailInfo.fromJson(Map<String, dynamic> json) => DetailInfo(
        id: json['id'] as String,
        img: json['img'] as String,
        name: json['name'] as String,
        amount: json['amount'] as int,
        price: json['price'] as double,
        shopId: json['shopId'] as String,
        detail: json['detail'] as String,
        oriPrice: json['oriPrice'] as double,
        serialId: json['serialId'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'img': this.img,
        'name': this.name,
        'price': this.price,
        'amount': this.amount,
        'shopId': this.shopId,
        'detail': this.detail,
        'oriPrice': this.oriPrice,
        'serialId': this.serialId,
      };
}
