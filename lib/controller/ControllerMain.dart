import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../services/services.dart';
import '../view/reuseable/getSnakbar.dart';

class ControllerMain extends GetxController {
  var isDark = false.obs;
  var weatherData;
  var forecastData;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var isloaded = false.obs;

  @override
  Future<void>  onInit()  async {
    super.onInit();
    await getUserLocation();
    weatherData =  getCurrentWeather(latitude.value,longitude.value);
    forecastData = getDaysForeCast(latitude.value,longitude.value);

  }

  toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> getUserLocation() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      getSnackBar('Location is not enabled');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      getSnackBar('Location permission denied forever');
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        getSnackBar('Location permission denied');

        // Get.snackbar(
        //   'Error',
        //   'Location permission denied',
        //   duration: Duration(seconds: 4),
        //   snackPosition: SnackPosition.TOP,
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        //   borderRadius: 10,
        //   margin: EdgeInsets.all(10),
        //   isDismissible: false,
        //   dismissDirection: DismissDirection.horizontal,
        //   forwardAnimationCurve: Curves.easeOutBack,
        //   reverseAnimationCurve: Curves.easeInBack,
        //   mainButton: TextButton(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     child: Text(
        //       'Close',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // );
        return;
      }
    }

    try {
      Position userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = userPosition.latitude;
      longitude.value = userPosition.longitude;
      isloaded.value = true;
      // weatherData =  getCurrentWeather(latitude.value,longitude.value);
      // forecastData = getDaysForeCast(latitude.value,longitude.value);
    } catch (e) {
      getSnackBar('We can\'nt get User Position, Check internet Connection and make sure Location is Enabled');

    }
  }
}
