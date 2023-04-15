import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Common/widget/appbar.dart';
import '../models/post_model.dart';
import '../models/post_response_model.dart';
import '../repository/order_repository.dart';

class MyPostOrderDetailPage extends ConsumerWidget {
  final String postId;
  final Store store;
  final int orderNum;

  const MyPostOrderDetailPage(
      {Key? key,
      required this.postId,
      required this.store,
      required this.orderNum})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: '내 주문 상세 내역',
        isCenter: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    store.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.delete),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[300],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {},
                          child: Text('가게보기'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 12,
              thickness: 4,
            ),
            SizedBox(
              height: 8,
            ),
            FutureBuilder<PostDetailOrder>(
                future:
                    ref.watch(orderRepositoryProvider).getMyPostOrder(postId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final myOrderData = snapshot.data!;
                    int totalSumPrice = myOrderData.orderLines
                        .fold(0, (pre, element) => pre + element.totalPrice);
                    int expectDeliverFee = store.fee ~/ orderNum;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              final orderMenu = myOrderData.orderLines[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      orderMenu.menu.name +
                                          ' × ${orderMenu.quantity}개',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' · 기본 : ${orderMenu.menu.price}원',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    if (orderMenu.menu.groups != null &&
                                        orderMenu.menu.groups!.isNotEmpty)
                                      Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (var group
                                                in orderMenu.menu.groups!)
                                              if (group.options.isNotEmpty)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      ' · ${group.name} : ',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                    RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 3,
                                                      text: TextSpan(
                                                        text: group.options.fold(
                                                            '',
                                                            (previousValue,
                                                                    element) =>
                                                                previousValue! +
                                                                element.name +
                                                                '[${element.price}원]  '),
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                          ]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${orderMenu.totalPrice}원',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                            itemCount: snapshot.data!.orderLines.length),
                        Divider(
                          height: 12,
                          thickness: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '총 주문 금액',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  Text(
                                    '${totalSumPrice}원',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '현재 기준 1인당 예상 배달비',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  Text(
                                    '$expectDeliverFee원',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 20,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '예상 본인 부담 금액',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    '${totalSumPrice + expectDeliverFee}원',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('에러'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}