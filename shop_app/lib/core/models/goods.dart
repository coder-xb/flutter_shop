// 商品列表项数据模型
class GoodsModel {
  String id;
  String img;
  double price;
  String title;
  double oriPrice;

  GoodsModel({this.id, this.price, this.oriPrice, this.title,this.img});

  factory GoodsModel.fromJson(Map<String, dynamic> json) => GoodsModel(
      id: json['id'] as String,
      img: json['img'] as String,
      price: json['price'] as double,
      title: json['title'] as String,
      oriPrice: json['oriPrice'] as double
    );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': this.id,
    'img': this.img,
    'price': this.price,
    'title': this.title,
    'oriPrice': this.oriPrice
  };
}
