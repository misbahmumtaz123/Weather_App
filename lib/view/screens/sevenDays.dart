import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/view/reuseable/images.dart';
import '../../Controller/controllerMain.dart';
import '../../Model/ForecastModel.dart';
import '../reuseable/Constants.dart';
// import '../reuseable/images.dart';

class SevenDayScreen extends StatefulWidget {
  SevenDayScreen({super.key});

  @override
  State<SevenDayScreen> createState() => _SevenDayScreenState();
}

class _SevenDayScreenState extends State<SevenDayScreen> {
  ControllerMain controllerMain = Get.find<ControllerMain>();

  var formatedDate = DateFormat.yMMMMd()
      .add_jm()
      .format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body:
        Obx(() =>
        controllerMain.isloaded == true ?
        FutureBuilder<HourlyWeatherData>(
          future: controllerMain.forecastData,
          builder: (BuildContext context,  snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator() ,
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 15,
                    color: Colors.teal,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Please, Check your Internet Connection! ...}',//${snapshot.error
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              );
            }
            if(snapshot.hasData) {
              HourlyWeatherData data = snapshot.data!;

              return SingleChildScrollView(
                physics: BouncingScrollPhysics() ,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Container(

                          color: Colors.blue,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 4),
                                child:Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: theme.primaryColor, width: 2),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_back_ios_new,
                                            size: 15,
                                            color: theme.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(), // Pushes the following widgets to the right
                                    Icon(Icons.calendar_today, size: 14, color: Theme.of(context).primaryColor),
                                    SizedBox(width: 5),
                                    Text(
                                      '7 Days',
                                      style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(), // Pushes the previous widgets to the left
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                      width: 100,
                                      height: 100,
                                      //color: Colors.blue,
                                      child: Image.asset(
                                        'assets/images/${data.list![0].weather![0].icon}.png',
                                        fit: BoxFit.cover,
                                      )),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tommorow',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: theme.primaryColor),
                                      ),
                                      RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: '${data.list![0].main!.temp}$degree',
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  color: theme.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: '/${data.list![0].main!.tempMin}$degree',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: theme.primaryColor,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ])),
                                      // Text(
                                      //   '${data.list![0].clouds!.all}',
                                      //   style: TextStyle(
                                      //       fontSize: 28,
                                      //       color: theme.primaryColor),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 35),

                                color: theme.primaryColor,
                                width: double.infinity,
                                height: 1.5,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: List.generate(3, (index) {
                                    var iconList = [clouds, humidity, windSpeed];
                                    var values = ["${data.list![0].clouds!.all}%",
                                      "${data.list![0].main!.humidity}%",
                                      "${data.list![0].wind!.speed}km/Hr"];
                                    var nameList = ['clouds', 'humidity', 'windSpeed'];

                                    return Column(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              shape: BoxShape.rectangle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Image.asset(
                                              iconList[index],
                                              // width: 45,
                                              // height: 45,
                                              // fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          '${values[index]}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: theme.primaryColor),
                                        ),SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${nameList[index]}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: theme.primaryColor),
                                        ),SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  })),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          var days = DateFormat('EEEE').format(DateTime.now().add(Duration(days: index+1 )));
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: theme.cardColor,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text('$days',style: TextStyle(color: theme.primaryColor),)),
                                  Expanded(
                                    child: TextButton.icon(
                                      onPressed: null,
                                      icon: Image.asset('assets/images/${data.list![index].weather![0].icon}.png',width: 40,height: 40,),
                                      label:  Text(
                                        '${data.list![index].main!.temp}$degree',
                                        style: TextStyle(fontSize: 18, color: theme.primaryColor),
                                      ),
                                    ),
                                  ),
                                  RichText(text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                          '${data.list![index].main!.tempMax}$degree / ',
                                          style: TextStyle(fontSize: 15, color: Colors.yellow),
                                        ),
                                        TextSpan(
                                          text:
                                          '${data.list![index].main!.tempMin}$degree ',
                                          style: TextStyle(fontSize: 15, color: Colors.white),
                                        )
                                      ]
                                  ))
                                ],
                              ),
                            ),
                          );
                        },
                      )

                    ],
                  ),
                ),
              );
            }
            else{
              return Center(
                child: Text('No Data Available Now ') ,
              );
            }
          },

        ) : Center(
          child: CircularProgressIndicator(),
        )
        ),





      ),
    );
  }
}
