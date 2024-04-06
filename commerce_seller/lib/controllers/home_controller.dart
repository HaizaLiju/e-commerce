import 'dart:async';

import 'package:commerce/const/const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit;
    getUsername();
  }

  var navIndex = 0.obs;
  var username = '';

  void changeTabIndex(int index) {
    navIndex.value = index; // Update the index
  }

  getUsername() async {
    var n = await firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['vendor_name'];
      }
    });

    username = n;
  }

  Stream<List<QueryDocumentSnapshot>> getOrdersCount(uid) {
    // Get the Firestore instance

    // Create a stream controller
    StreamController<List<QueryDocumentSnapshot>> controller =
        StreamController();

    // Query the "orders" collection where the specified field has the given value
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = firestore
        .collection(ordersCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();

    // Listen to the stream and add data to the stream controller
    stream.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      controller.add(snapshot.docs);
    }, onError: (dynamic error) {
      controller.addError(error);
    });

    // Return the stream
    return controller.stream;
  }
}
