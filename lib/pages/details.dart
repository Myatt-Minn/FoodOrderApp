import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fooddeliveryapp/services/database.dart';
import 'package:flutter_fooddeliveryapp/widgets/widget_support.dart';
import 'package:random_string/random_string.dart';

class Details extends StatefulWidget {
  final String image, title, desc, price, id;
  const Details(
      {super.key,
      required this.image,
      required this.title,
      required this.desc,
      required this.price,
      required this.id});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int foodcount = 1, total = 0;
  String? id;

  @override
  void initState() {
    total = int.parse(widget.price); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30, left: 10, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            Image.network(widget.image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                fit: BoxFit.fill),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        widget.title,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: AppWidgets.boldTextFieldStyle(),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: IconButton(
                    onPressed: () {
                      if (foodcount > 1) {
                        foodcount--;
                        total = total - int.parse(widget.price);
                      }
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "$foodcount",
                  style: AppWidgets.smallboldlineTextFieldStyle(),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: IconButton(
                    onPressed: () {
                      foodcount++;
                      total = total + int.parse(widget.price);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.desc,
              style: AppWidgets.littlelightTextFieldStyle(),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  "Delivery Time",
                  style: AppWidgets.smallboldlineTextFieldStyle(),
                ),
                const SizedBox(width: 24),
                const Icon(Icons.alarm),
                const SizedBox(width: 3),
                Text(
                  "30 minutes",
                  style: AppWidgets.smallboldlineTextFieldStyle(),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price",
                      style: AppWidgets.smallboldlineTextFieldStyle(),
                    ),
                    Text(
                      "\$$total",
                      style: AppWidgets.smallboldlineTextFieldStyle(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () async {
                        Map<String, dynamic> addtoCart = {
                          "Name": widget.title,
                          "Image": widget.image,
                          "Quantity": foodcount.toString(),
                          "Total": total.toString()
                        };

                        await DatabaseMethods().addFoodtoCart(addtoCart,
                            FirebaseAuth.instance.currentUser!.uid, widget.id);

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Colors.orangeAccent,
                                content: Text(
                                  "Food Item has been added to the Cart",
                                  style: TextStyle(fontSize: 18.0),
                                )));
                      },
                      child: const Row(children: [
                        Text(
                          "Add to Cart",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        )
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
