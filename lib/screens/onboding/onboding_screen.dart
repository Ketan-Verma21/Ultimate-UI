import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

import '../../components/sign_in_form.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late RiveAnimationController _btnAnimationController;
  bool isDialog=false;
  @override
  void initState() {
    // TODO: implement initState
    _btnAnimationController=OneShotAnimation("active",
        autoplay: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
          children: [

            Positioned(
              // height: 100,
                bottom: 200,
                left: 100,
                width: MediaQuery.of(context).size.width*1.7,
                child: Image.asset("assets/Backgrounds/Spline.png")),
            Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(
                sigmaY:10,
                sigmaX: 20
            ),
            )),
            const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
            Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(
                sigmaY:30,
                sigmaX: 30
            ),
              child: SizedBox(),)),
            AnimatedPositioned(
              top: isDialog?-50:0,
              duration: Duration(milliseconds: 240),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                  child:Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const SizedBox(
                          width: 260,
                          child: Column(
                            children: [
                              Text("Welcome to an amazing UI",style: TextStyle(
                                  fontSize: 60,
                                  fontFamily: "Poppins",
                                  height: 1.2
                              ),),
                              SizedBox(height: 16,),
                              Text(
                                  "Opportunity is missed by most people because it is dressed in overalls and looks like work."
                              )
                            ],
                          ),
                        ),
                        const Spacer(flex: 2,),
                        GestureDetector(
                          onTap: (){
                            _btnAnimationController.isActive=true;
                            Future.delayed(Duration(milliseconds: 800),(){
                              setState(() {
                                isDialog=true;
                              });
                              customSignInDialog(context);
                            });

                          },
                          child: SizedBox(
                              height: 64,
                              width: 260,

                              child: Stack(
                                children: [
                                  RiveAnimation.asset("assets/RiveAssets/button.riv",
                                    controllers: [_btnAnimationController],),
                                  const Positioned.fill(
                                    top: 8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.arrow_right),
                                        SizedBox(width: 8,),
                                        Text("Take a Look",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600
                                          ),),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                        const Padding(
                          padding:  EdgeInsets.symmetric(vertical: 24),
                          child: Text("This is my first UI that has animation of this level"),
                        )
                      ],
                    ),
                  )),
            )

          ],
        ),
      );
  }

  Future<Object?> customSignInDialog(BuildContext context) {
    return showGeneralDialog(
      transitionBuilder: (context,animation,secondaryAnimation,child){
        Tween<Offset> tween;

        tween=Tween(begin: Offset(0,-1),end:Offset.zero );
        return SlideTransition(position: tween.animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
        child: child,);
      },
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible:true ,barrierLabel: "Sign In",context: context, pageBuilder: (context,_,__)=>
                            Center(
                              child: Container(
                                height: 620,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                padding: EdgeInsets.symmetric(vertical: 32,horizontal: 24),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.94),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child:   Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Column(
                                            children: [
                                              Text("Sign In",style: TextStyle(
                                                  fontSize: 34,
                                                  fontFamily: "Poppins"
                                              ),),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                                child: Text("Unlocking possibilities with every keystroke, signing in to a world of endless opportunities.",textAlign: TextAlign.center,),
                                              ),
                                              SignInForm(),
                                              Row(
                                                children: [
                                                  Expanded(child: Divider()),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                    child: Text("OR",style:TextStyle(color: Colors.black26)),
                                                  ),
                                                  Expanded(child: Divider()),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                                child: Text("Sign up with Email, Apple or Google",style: TextStyle(
                                                  color: Colors.black54
                                                )),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  IconButton(
                                                      padding:EdgeInsets.zero,
                                                      onPressed: (){},
                                                      icon: SvgPicture.asset("assets/icons/email_box.svg",height: 64,width: 64,)),
                                                  IconButton(
                                                      padding:EdgeInsets.zero,
                                                      onPressed: (){},
                                                      icon: SvgPicture.asset("assets/icons/apple_box.svg",height: 64,width: 64,)),
                                                  IconButton(
                                                      padding:EdgeInsets.zero,
                                                      onPressed: (){},
                                                      icon: SvgPicture.asset("assets/icons/google_box.svg",height: 64,width: 64,)),
                                                ],
                                              )
                                            ],


                                        ),
                                      Positioned(
                                        bottom: -48,
                                        right: 0,
                                        left: 0,
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.white,
                                          child: Icon(Icons.close,color: Colors.black,),
                                        ),
                                      )
                                    ],
                                  ),
                                  ),
                                ),

                            ),);
  }
}


