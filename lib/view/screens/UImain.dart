import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/view/screens/sevenDays.dart';
import 'package:weatherapp/view/screens/UImain.dart';
import '../../Controller/controllerMain.dart';
import '../../Model/ForecastModel.dart';
import '../../model/CurrentWeather.dart';
import '../reuseable/Constants.dart';
import '../reuseable/images.dart';

class UIMain extends StatefulWidget {
  @override
  State<UIMain> createState() => _UIMainState();
}

class _UIMainState extends State<UIMain> {
  ControllerMain controllerMain = Get.find<ControllerMain>();

  var formatedDate = DateFormat.yMMMMd()
      .add_jm()
      .format(DateTime.now());
 //DateFormat.yMMM().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body:
          Obx(() =>
          controllerMain.isloaded == true ?
          FutureBuilder<CurrentWeather>(
            future: controllerMain.weatherData,
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
                CurrentWeather data = snapshot.data!;

                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Container(
                              color: Colors.blue,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Container(
                                            width: 50,
                                            height: 50,
                                            padding: EdgeInsets.all(2),
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
                                        Spacer(),
                                        Icon(Icons.location_on_outlined,size: 30,color: theme.primaryColor,),
                                        SizedBox(height: 5,),
                                        Text(
                                          '${data.name}'.toUpperCase(),
                                          //'Azad Kashmir',
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 25, color: theme.primaryColor,fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    Container(
                                        width: 150,
                                        height: 150,
                                        //color: Colors.blue,
                                        child: Image.asset(
                                          'assets/images/${data.weather![0].icon}.png', //
                                          fit: BoxFit.cover,
                                        )),

                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: '${data.main!.temp!.toInt()}$degree',
                                            style: TextStyle(
                                                fontSize: 80,
                                                color: theme.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ])),
                                    Text(
                                      '${data.weather![0]!.main}',
                                      style: TextStyle(
                                          fontSize: 28, color: theme.primaryColor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '$formatedDate',
                                      style: TextStyle(color: theme.primaryColor),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
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
                                          var values = ["${data.clouds!.all}%",
                                            "${data.main!.humidity}%",
                                            "${data.wind!.speed}km/hr"];
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
                                                    fontSize: 20,
                                                    color: theme.primaryColor),
                                              ), SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                '${nameList[index]}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: theme.primaryColor),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],

                                          );
                                        })),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '3 Hour Forecast',
                                style:
                                TextStyle(color: theme.primaryColor, fontSize: 20),
                              ),
                              TextButton(
                                  onPressed: (){
                                    Get.to(SevenDayScreen(),
                                        transition: Transition.rightToLeftWithFade,
                                        duration: Duration(milliseconds: 800)
                                    );
                                  },
                                  child: Text(
                                    'Next 5 Days?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FutureBuilder<HourlyWeatherData>(
                          future: controllerMain.forecastData,
                          builder: (BuildContext context, AsyncSnapshot<HourlyWeatherData>  snapshot) {
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
                                        'Please, Check your Internet Connection!...}',//${snapshot.error
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if(snapshot.hasData) {
                              HourlyWeatherData hourlyData = snapshot.data!;

                              return  SizedBox(
                                height: 120,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: hourlyData.list!.length> 6 ? 6 : hourlyData.list!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var threeHrTime = DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(hourlyData.list![index].dt!.toInt()*1000));

                                    return Container(
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.all(4),
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          shape: BoxShape.rectangle),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${threeHrTime}',
                                            style: TextStyle(
                                                color: theme.primaryColor, fontSize: 14),
                                          ),
                                          Image.asset(
                                            'assets/images/${hourlyData.list![index].weather![0].icon}.png',
                                            width: 45,
                                          ),
                                          Text(
                                            '${ hourlyData.list![index].main!.temp }$degree',
                                            style: TextStyle(
                                                color: theme.primaryColor, fontSize: 17),
                                          ),

                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            else{
                              return Center(
                                child: Text('No Data Available Now ') ,
                              );
                            }
                          },
                        ),

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
        )
    );
  }
}
