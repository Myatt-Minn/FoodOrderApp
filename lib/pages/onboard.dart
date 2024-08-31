import 'package:flutter/material.dart';
import 'package:flutter_fooddeliveryapp/model/content_model.dart';
import 'package:flutter_fooddeliveryapp/pages/signup.dart';
import 'package:flutter_fooddeliveryapp/widgets/widget_support.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              itemCount: contents.length,
              controller: _controller,
              itemBuilder: (snap, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[index].image,
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        contents[index].title,
                        style: AppWidgets.headlineTextFieldStyle(),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        contents[index].descritpion,
                        style: AppWidgets.lightTextFieldStyle(),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_currentPage == contents.length - 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              }
              _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceIn);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              height: 60,
              margin: const EdgeInsets.all(40),
              width: double.infinity,
              child: Center(
                child: Text(
                  _currentPage == contents.length - 1 ? "Start" : "Next",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.0,
      width: _currentPage == index ? 18 : 7,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.black38),
    );
  }
}
