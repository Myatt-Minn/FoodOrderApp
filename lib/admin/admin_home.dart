import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fooddeliveryapp/admin/add_food.dart';
import 'package:flutter_fooddeliveryapp/admin/admin_login.dart';
import 'package:flutter_fooddeliveryapp/pages/onboard.dart';
import 'package:flutter_fooddeliveryapp/services/database.dart';
import 'package:flutter_fooddeliveryapp/widgets/widget_support.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Center(
                  child: Text(
                    "Home Admin",
                    style: AppWidgets.headlineTextFieldStyle(),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AdminLogin()));
                    },
                    icon: const Icon(Icons.logout_outlined))
              ]),
              const SizedBox(
                height: 50.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AddFood()));
                },
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(
                              "images/food.jpg",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          const Text(
                            "Add Food Items",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
