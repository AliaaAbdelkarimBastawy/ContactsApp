import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:go_router/go_router.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>  with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(seconds: 5),
      // This takes in the TickerProvider, which is this _AnimationPageState object
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut,
    );

    animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(curvedAnimation)

      ..addListener(() {
    // Empty setState because the updated value is already in the animation field
    setState(() {});
    })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // animController.reverse();
          Future.delayed(Duration(milliseconds: 100), () {
            // Do something
            GoRouter.of(context).go("/Screen1");
          });




        } else if (status == AnimationStatus.dismissed) {
          animController.forward();
        }
      });

    // Goes from 0 to 1, we'll do something with these values later on
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: animation.value,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("Assets/Images/APP-LOGO.png"),
                fit: BoxFit.cover,
              ),
            ),
            height: 300,
            width: 300,
            padding: EdgeInsets.all(30),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}
