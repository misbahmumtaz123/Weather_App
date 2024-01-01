import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/view/screens/UImain.dart';
import '../../Controller/controllerMain.dart';



class StartScreen extends StatefulWidget {
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  ControllerMain controllerMain = Get.find<ControllerMain>();

  var formatedDate = DateFormat.yMMMMd()
      .add_jm()
      .format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('$formatedDate',style: TextStyle(color: theme.primaryColor),),
          actions: [
            Obx( () => IconButton(onPressed: () {
              controllerMain.toggleTheme();
            }, icon: Icon(controllerMain.isDark.value ?Icons.light_mode: Icons.dark_mode,color: theme.iconTheme.color,)),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert,color: theme.iconTheme.color)),
            SizedBox(
              width: 10,
            )
          ],
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(width: 150,height: 150,
                          //color: Colors.blue,
                          child: Image.asset('assets/images/09d.png',fit: BoxFit.cover,)),
                    ),
                    SizedBox(height: 30,),
                    Text(
                      'Let\'s Explore our Sky',
                      style: TextStyle(fontSize: 40, color: theme.primaryColor,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(width: 150,height: 150,
                          //color: Colors.blue,
                          child: Image.asset('assets/images/09n.png',fit: BoxFit.cover,)),
                    ),
                    SizedBox(height: 30,),

                    Container(
                      // color: Colors.cyan,
                      width: 230,
                      height: 65,

                      child: ElevatedButton(
                        onPressed: () {
                          //Get.toNamed('/uimain');
                          Get.to(UIMain(),
                              transition: Transition.rightToLeftWithFade,

                              duration: Duration(milliseconds: 500)
                          );
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                            color: Colors.black, // Outline color
                            width: 2, // Outline width
                          )),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // Adjust the border radius as needed
                            ),
                          ),
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ?? Colors.redAccent,
                          ),

                        ),
                        child: Text('Get Started',style: TextStyle(color: theme.primaryColor,fontSize: 28),),

                      ),
                    )

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
