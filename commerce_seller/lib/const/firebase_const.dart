import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

const vendorsCollection = "vendors";
const usersCollection = "User";
const productsCollection = "Products";
const cartCollection = 'Cart';
const chatsCollection = 'Chats';
const messagesCollection = 'Messages';
const ordersCollection = 'Orders';
