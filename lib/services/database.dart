import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .set(userInfoMap);
  }

  Future addFoodDetails(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItems(String name) async {
    return FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodtoCart(
      Map<String, dynamic> userInfoMap, String uid, String id) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Cart")
        .doc(id)
        .set(userInfoMap);
  }

  Future<void> addProfileImage(String profileImageUrl) async {
    try {
      // Get the current user's ID
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update the user document with the profileImg field
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'profileImg': profileImageUrl,
        });
      } else {
        print('No user is currently signed in.');
      }
    } catch (e) {
      print('Error adding profile image: $e');
      // Handle errors appropriately
    }
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .collection("Cart")
        .snapshots();
  }
}
