import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizify_ai/screens/quiz_screen.dart';
import 'package:quizify_ai/utils/constants.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();

  String assetName = 'assets/bg.svg';

  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fitWidth),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    "Let's Play Quiz",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const Text("Enter your information below"),
                  Spacer(),
                  TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      hintText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(QuizScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.all(kDefaultPadding * 0.75),
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "Let's Start Quiz",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
