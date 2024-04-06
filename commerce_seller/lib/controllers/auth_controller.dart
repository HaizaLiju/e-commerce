import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:commerce/const/const.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs; // Observable variable
  @override
  void onInit() {
    super.onInit();
    // Example with Firebase Auth
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIn.value = false;
      } else {
        isLoggedIn.value = true;
      }
    });
  }

  userLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLoggedIn.value = true;
      Get.toNamed('/home'); // Use the route name for the HomePage
    } on FirebaseAuthException catch (e) {
      if (e.code == 'channel-error') {
        Get.snackbar('Fail', 'No User Found for that Email');
      } else if (e.code == 'invalid-credential') {
        Get.snackbar('Fail', 'invalid-credential');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Fail', 'The email address is badly formatted.');
      }
    }
  }

  registration(String email, String password, String name) async {
    if (password != "" && name != "" && email != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Get.snackbar('success', "Registered Successfully");

        // this row get the same id with authentication
        String? userId = userCredential.user?.uid;
        createUserData(
            email: email, password: password, name: name, id: userId);
        // ignore: use_build_context_synchronously
        Get.toNamed('/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar('Fail', "Password Provided is too Weak");
        } else if (e.code == "email-already-in-use") {
          Get.snackbar('Fail', "Account Already exists");
        } else if (e.code == "invalid-email") {
          Get.snackbar('Fail', "The email address is badly format");
        }
      }
    }
  }

  var isloading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(vendorsCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': 'assets/images/user.png',
      'id': currentUser!.uid,
      // 'cart_count': "00",
      // 'wishlist_count': "00",
      // 'order_count': "00",
    });
  }

  createUserData({name, password, email, id}) async {
    DocumentReference store = firestore.collection(vendorsCollection).doc(id);
    store.set({
      'vendor_name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': id,
      // 'cart_count': "00",
      // 'wishlist_count': "00",
      // 'order_count': "00",
    });
  }

  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
