


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weather_app/view/details.dart';

class WeatherHomeScreen extends StatefulWidget{

const WeatherHomeScreen({super.key});
WeatherHomeScreenState createState() => WeatherHomeScreenState();

}

class WeatherHomeScreenState extends State<WeatherHomeScreen>{


  TextEditingController cityNameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        title: Text("Weather App", style: TextStyle(fontSize: 30),),
        centerTitle: true,
      ),

      body:
         Padding(
        padding: EdgeInsets.all(10),
      
    child: 
       Column(children: [
          
          const Image(image: NetworkImage("https://i2.wp.com/www.metgraphics.net/wp-content/uploads/2018/01/7-day.jpg?fit=2400%2C1400&ssl=1")),


         SizedBox(height: 20,),

        Card(
          child: Row(
            children: [

          Expanded(child: 
          Padding(padding: EdgeInsets.only(left: 20),
           child:   TextField(
                 
                 controller: cityNameCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter City",
                  border: InputBorder.none
                  
                ),
                
               ),
           ) ),
               Container(
                width: 50,
                height: 50,
                decoration:const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                  color: Colors.amber,
                ),
                child: Icon(Icons.search),
               )
               
            ],
          ),
        ),
          
          SizedBox(height: 60,),

          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
               color: Colors.amber,
            ),
            child:InkWell(
            onTap: (){
              print("object:${cityNameCtrl.text}");
              Get.toNamed(
                WeatherDetailsScreen.routeName,
                arguments: cityNameCtrl.text
                );
            },
            child: Center(child: Text("Search"))
            )
            )
       ],),
    ));
  }


}