

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/consts.dart';

class WeatherDetailsScreen extends StatefulWidget{
 
  
  WeatherDetailsScreen({super.key});


  static String routeName = '/weatherDetails';
  WeatherDetailsScreenState createState ()=> WeatherDetailsScreenState();
}

class WeatherDetailsScreenState extends State<WeatherDetailsScreen>{
  
  final WeatherFactory weatherFactory = WeatherFactory(weather_aip_key);
  
  late String cityName;
    Weather? weather;
    @override
    void initState(){
      super.initState();
      cityName = Get.arguments as String;
      print("CityName:$cityName");
      fetchWeather();
    }

    Future<void> fetchWeather() async {
    try {
      Weather w = await weatherFactory.currentWeatherByCityName(cityName);
      setState(() {
        weather = w;
      });
    } catch (e) {
      print("Exception: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Color.fromRGBO(70, 129, 156, 1),
    appBar: AppBar(
       backgroundColor:Color.fromRGBO(70, 129, 156, 1),
      title: Text("Weather Details",
        style: TextStyle(fontSize: 30,
        color: Colors.white70
        ),
      ),
      centerTitle: true,
    ),
    body: RefreshIndicator(
      onRefresh:fetchWeather ,
      child: _createUI(),
      )
            
    
     
   );

   
  }
    Widget _createUI(){
      if(weather == null){
        return  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           CircularProgressIndicator(),
           SizedBox(height: 20,),
           if(weather == null)
           Text("Invalid City name", style: TextStyle(color: Colors.white, fontSize: 20),),
            ],
          )
        
             
        );
      }
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,

        child:  Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             _locationHeader(),

             SizedBox(height: MediaQuery.sizeOf(context).height * 0.08,),

             _dateTime(),
             SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
             _weatherIcon(),
             SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
            _currentTemp(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
            _craeteContainer(),
        ],),
      );
    }

    Widget _locationHeader(){
          return Text(
            weather?.areaName??"",
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
                      color: Colors.white70

            ),
          );
    }
    Widget _dateTime(){
       DateTime now=weather!.date!;
       
      return Column(
        children: [
          Text(DateFormat("h:mm:a").format(now),
          style: TextStyle(
            fontSize: 25,
                    color: Colors.white70

          ),
          ),
          SizedBox(height: 10,),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Text(DateFormat("EEEE").format(now),
            style: TextStyle(
            fontSize: 15,
                    color: Colors.white70

          ),
          ),
       SizedBox(width: 10,),
          Text("${DateFormat("dd-MM-y").format(now)}",
            style: TextStyle(
            fontSize: 15,
            color: Colors.white70

          ),
          ),
          ],)
        ],
      );
    }

    Widget _weatherIcon(){
       
       return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height*0.20,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("https://openweathermap.org/img/wn/${weather?.weatherIcon}@4x.png"))
            ),
          ),
          Text(weather?.weatherDescription??'',
          style: TextStyle(
           color: Colors.white,
          fontSize: 20
          ),
          ),
       ],);
    }

    Widget _currentTemp(){

      return Text("${weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
      style: TextStyle(
      color: Colors.white,
      fontSize: 50,
      fontWeight: FontWeight.bold
      
      ),
      );
    }
    Widget _craeteContainer(){
      return Container(
        height: MediaQuery.sizeOf(context).height *0.15,
        width: MediaQuery.sizeOf(context).width*0.80,
        
        decoration: BoxDecoration(
         color: Colors.blue,
         borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text("Max: ${weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
              ),
               Text("Min: ${weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
              )
             ],),
      SizedBox(height: 15,),
             Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text("Wind: ${weather?.windSpeed?.toStringAsFixed(0)} m/s",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
              ),
               Text("Humidity: ${weather?.humidity?.toStringAsFixed(0)}%",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
              )
             ],)
        ],),
      );
    }
}