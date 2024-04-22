import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app_apr22/models/game_model.dart';
import 'package:flutter_weather_app_apr22/models/weather_model.dart';
import 'package:flutter_weather_app_apr22/services/weather_service.dart';
import 'package:flutter_weather_app_apr22/widgets/app_textfield.dart';
import 'package:flutter_weather_app_apr22/widgets/game_button.dart';
import 'package:flutter_weather_app_apr22/widgets/snackbar.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_weather_app_apr22/widgets/game_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Text controller for the textfield
  late TextEditingController usernameController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  String cityName = '';
//API Key
  final _weatherService = WeatherService('fd23c8dbcaaebe29a90a094275ff8c3f');
  Weather? _weather;
  bool displayText = true;
  bool displayWeather = false;
  bool displayGame = false;

  //Fetch weather
  _fetchWeather(String city) async {
    String cityName = await _weatherService.getCity(city);
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //Weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/icons/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/icons/partly_cloudy.json';
      case 'rain':
      case 'drizzle':
        return 'assets/icons/sunny_rain.json';
      case 'shower rain':
        return 'assets/icons/t_showers.json';
      case 'clear':
        return 'assets/icons/sunny.json';
      default:
        return 'assets/icons/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    double btnWidth = MediaQuery.of(context).size.width / 2 - 140;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Textfield
          Visibility(
            visible: displayText,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.grey],
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
                      AppTextField(
                        controller: usernameController,
                        labelText: 'Enter city',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (usernameController.text.isNotEmpty) {
                                setState(
                                  () {
                                    cityName = usernameController.text;
                                    _fetchWeather(cityName);
                                    displayText = false;
                                    displayWeather = true;
                                    displayGame = false;
                                  },
                                );
                              } else {
                                showSnackBar(context, 'Please enter a city');
                              }
                            },
                            child: const Text('Search Weather'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                displayText = false;
                                displayWeather = false;
                                displayGame = true;
                              });
                            },
                            child: const Text('Play Game'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          //Weather display
          Visibility(
            visible: displayWeather,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.grey],
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Display city name
                      Text(
                        _weather?.cityName ?? 'Loading city...',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      //Display animation
                      Lottie.asset(
                          getWeatherAnimation(_weather?.mainCondition)),
                      //Display temperature
                      Text(
                        '${_weather?.temperature.round()} °C',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //Game display
          Visibility(
            visible: displayGame,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.grey],
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 5.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'SCORE:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${Game.score}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
                          child: Stack(
                            children: [
                              Positioned(
                                //Setting position
                                top: 0,
                                left: MediaQuery.of(context).size.width / 2 -
                                    btnWidth / 2 -
                                    20,
                                child: gameButton(() {
                                  print('You chose rock!');
                                }, 'assets/images/rock.png', btnWidth),
                              ),
                              Positioned(
                                top: btnWidth,
                                left: MediaQuery.of(context).size.width / 2 -
                                    btnWidth -
                                    40,
                                child: gameButton(() {
                                  print('You chose paper!');
                                }, 'assets/images/paper.png', btnWidth),
                              ),
                              Positioned(
                                top: btnWidth,
                                right: MediaQuery.of(context).size.width / 2 -
                                    btnWidth -
                                    40,
                                child: gameButton(() {
                                  print('You chose scissors!');
                                }, 'assets/images/scissor.png', btnWidth),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: RawMaterialButton(
                          onPressed: () {},
                          shape: const StadiumBorder(
                              side: BorderSide(color: Colors.white)),
                          child: const Text(
                            'RULES',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
