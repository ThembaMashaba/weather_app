import 'package:flutter/material.dart';
import 'package:flutter_weather_app_apr22/models/weather_model.dart';
import 'package:flutter_weather_app_apr22/routes/routes.dart';
import 'package:flutter_weather_app_apr22/widgets/app_textfield.dart';
import 'package:flutter_weather_app_apr22/widgets/snackbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  get loginName => null;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Text controller for the textfield
  late TextEditingController usernameController;

  //Hardcoded logins
  static const String _loginName = 'Themba';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    'Weather App',
                    style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                ),
                AppTextField(
                  controller: usernameController,
                  labelText: 'Enter your credentials',
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (usernameController.text == _loginName) {
                      Navigator.of(context).pushNamed(RouteManager.homePage);
                    } else {
                      showSnackBar(
                          context, 'Invalid Username. Please try again.');
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
