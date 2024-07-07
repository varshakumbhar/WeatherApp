 
import 'package:get/get.dart';
import 'package:weather_app/view/details.dart';

final List<GetPage<dynamic>> routes = [
  
  GetPage(
      name: WeatherDetailsScreen.routeName,
      page: () =>  WeatherDetailsScreen()),
   
];

 