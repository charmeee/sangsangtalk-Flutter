import 'package:sangsangtalk/Delivery/models/post_model.dart';

//post /post
class PostOrder extends PostOption {
  List<Order> orders;
  String storeId;

  PostOrder(
      {required this.orders,
      required this.storeId,
      required String place,
      required String orderTime,
      required int minMember,
      required int maxMember})
      : super(
            place: place,
            orderTime: orderTime,
            minMember: minMember,
            maxMember: maxMember);

  PostOrder.fromJson(Map<String, dynamic> json)
      : orders = List<Order>.from(json['orders'].map((x) => Order.fromJson(x))),
        storeId = json['store_id'],
        super.fromJson(json);
}