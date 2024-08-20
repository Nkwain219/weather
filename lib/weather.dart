import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_fotcast/const.dart';
class Weather_Page extends StatefulWidget {
  const Weather_Page({super.key});

  @override
  State<Weather_Page> createState() => _WeatherState();
}

class _WeatherState extends State<Weather_Page> {
  final WeatherFactory _weatherFactory = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _weatherFactory.currentWeatherByCityName("Bambili").then((w) {
      setState(() {
        _weather = w ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage('assets/001.PNG'),fit: BoxFit.cover)),
        child: _buildUI(),
      ),

    );
  }

  Widget _buildUI(){
    if(_weather == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    Widget _locationHeader(){
      return Text(_weather?.areaName ?? "",
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold
      ),);
    }
    Widget _dateTimeInfo(){
      DateTime now = _weather!.date!;
      return Column(
        children: [
          Text(
            DateFormat("HH:mm a").format(now),
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat("EEEE").format(now),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
               " ${DateFormat("dd-MM-yyyy").format(now)}",
                style:TextStyle(fontSize: 20,color: Colors.white) ,
              ),
            ],
          ),
        ],
      );
    }
    Widget _currentHumidity(){
      return Text("Humidity: ${_weather?.humidity}° ",style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),);
    }
    Widget _currentTemperature(){
      return Text("Temperature: ${_weather?.temperature?.celsius?.toStringAsFixed(2)}° ",style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),);
    }
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.03,
          ),
          _dateTimeInfo(),
          _currentTemperature(),
          _currentHumidity(),
        ],
      ),
    );
  }
}
