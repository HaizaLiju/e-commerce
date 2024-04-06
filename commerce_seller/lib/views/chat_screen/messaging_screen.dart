import 'package:commerce/const/const.dart';
import 'package:commerce/services/store_service.dart';

import 'package:commerce/views/chat_screen/chat_screen.dart';
import 'package:commerce/views/widgets/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: "My Message".text.color(Colors.grey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: StoreService.getAllMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No messages yet!".text.color(Colors.grey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => ChatScreen(), arguments: [
                                    data[index]['friend_name'],
                                    data[index]['fromId'],
                                  ]);
                                },
                                leading: const CircleAvatar(
                                  backgroundColor: red,
                                  child: Icon(
                                    Icons.person,
                                    color: white,
                                  ),
                                ),
                                title: "${data[index]['friend_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(Colors.grey)
                                    .make(),
                                subtitle:
                                    "${data[index]['last_msg']}".text.make(),
                              ),
                            );
                          }))
                ]),
              );
            }
          }),
    );
  }
}
