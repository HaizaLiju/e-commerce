import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/controllers/home_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:commerce/const/const.dart';
import 'package:commerce/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  var isloading = false.obs;
  var isFea = false.obs;

  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();
  var imageUrlController = TextEditingController();
  var imageUrl1Controller = TextEditingController();
  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImageLinks = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColorIndex = 0.obs;

  getCategories() async {
    categoryList.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();

    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubcategory(cat) {
    subcategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImageLinks.clear();

    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImageLinks.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productsCollection).doc();
    pImageLinks.add(imageUrlController.text);
    pImageLinks.add(imageUrl1Controller.text);
    await store.set({
      'is_featured': false,
      'category': categoryvalue.value,
      'subcategory': subcategoryvalue.value,
      'colors': FieldValue.arrayUnion([Colors.red.value, Colors.brown.value]),
      'imgs': FieldValue.arrayUnion(pImageLinks),
      'wishlist': FieldValue.arrayUnion([]),
      'desc': pdescController.text,
      'name': pnameController.text,
      'price': ppriceController.text,
      'quantity': pquantityController.text,
      'seller': Get.find<HomeController>().username,
      'rating': "5.0",
      'vendor_id': currentUser!.uid,
      'featured_id': ''
    });
    isloading(false);
    VxToast.show(context, msg: "Product uploaded");
  }

  setFeatured(docId, context) async {
    await firestore
        .collection(productsCollection)
        .doc(docId)
        .update({'is_featured': true});

    VxToast.show(context, msg: "Set to Featured Product");
  }

  addToFeatured(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).update({
      'is_featured': true,
      'featured_id': currentUser!.uid,
    });
    isFea(true);
    VxToast.show(context, msg: "Add to wishlist");
  }

  removeFromFeatured(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).update({
      'is_featured': false,
      'featured_id': "",
    });
    isFea(false);
    VxToast.show(context, msg: "Add to wishlist");
  }

  removeProduct(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).delete();

    VxToast.show(context, msg: "Product has been deleted");
  }
}
