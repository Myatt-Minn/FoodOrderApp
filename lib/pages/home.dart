import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fooddeliveryapp/pages/details.dart';
import 'package:flutter_fooddeliveryapp/services/database.dart';
import 'package:flutter_fooddeliveryapp/widgets/category_card.dart';
import 'package:flutter_fooddeliveryapp/widgets/food_card.dart';
import 'package:flutter_fooddeliveryapp/widgets/widget_support.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream? foodcards;

  ontheLoad() async {
    foodcards = await DatabaseMethods().getFoodItems("Ice-cream");
    setState(() {});
  }

  Widget allItems() {
    return StreamBuilder(
        stream: foodcards,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];

                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
                                image: documentSnapshot["Image"],
                                title: documentSnapshot["Name"],
                                desc: documentSnapshot["Detail"],
                                price: documentSnapshot["Price"],
                                id: documentSnapshot["id"],
                              ),
                            ),
                          );
                        },
                        child: FoodCard(
                          image: documentSnapshot['Image'],
                          title: documentSnapshot["Name"],
                          price: documentSnapshot["Price"],
                        ));
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget allItemsVertical() {
    return StreamBuilder(
        stream: foodcards,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20, right: 10),
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  documentSnapshot["Image"],
                                  width: 110,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      documentSnapshot["Name"],
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                      style: AppWidgets
                                          .smallboldlineTextFieldStyle(),
                                    ),
                                  ),
                                  Text(
                                    "Honey Goat Cheese",
                                    style: AppWidgets.lightTextFieldStyle(),
                                  ),
                                  Text(
                                    documentSnapshot["Price"],
                                    style: AppWidgets
                                        .smallboldlineTextFieldStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  bool icecream = false;
  bool burger = false, salad = false, pizza = false;

  @override
  void initState() {
    ontheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 10,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          title: Text(
            'Hello MyatMin',
            style: AppWidgets.boldTextFieldStyle(),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delicous Food",
                style: AppWidgets.headlineTextFieldStyle(),
              ),
              Text(
                "Discover and Get Great Food",
                style: AppWidgets.lightTextFieldStyle(),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () async {
                        icecream = true;
                        burger = false;
                        salad = false;
                        pizza = false;
                        foodcards =
                            await DatabaseMethods().getFoodItems("Ice-cream");
                        setState(() {});
                      },
                      child: CategoryCard(
                        category: icecream,
                        img: "images/ice-cream.png",
                      )),
                  GestureDetector(
                      onTap: () async {
                        icecream = false;
                        burger = true;
                        salad = false;
                        pizza = false;
                        foodcards =
                            await DatabaseMethods().getFoodItems("Burger");
                        setState(() {});
                      },
                      child: CategoryCard(
                        category: burger,
                        img: "images/burger.png",
                      )),
                  GestureDetector(
                      onTap: () async {
                        icecream = false;
                        burger = false;
                        salad = true;
                        pizza = false;
                        foodcards =
                            await DatabaseMethods().getFoodItems("Salad");
                        setState(() {});
                      },
                      child: CategoryCard(
                        category: salad,
                        img: "images/salad.png",
                      )),
                  GestureDetector(
                      onTap: () async {
                        icecream = false;
                        burger = false;
                        salad = false;
                        pizza = true;
                        foodcards =
                            await DatabaseMethods().getFoodItems("Pizza");
                        setState(() {});
                      },
                      child: CategoryCard(
                        category: pizza,
                        img: "images/pizza.png",
                      )),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 275,
                child: allItems(),
              ),
              const SizedBox(
                height: 10,
              ),
              allItemsVertical(),
            ],
          ),
        ),
      ),
    );
  }
}
