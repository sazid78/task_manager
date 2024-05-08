import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/UI/Screens/authentication/login_screen.dart';
import 'package:task_manager/presentation/UI/Widgets/body_background.dart';
import 'package:task_manager/presentation/UI/Widgets/center_circuler_indicatior.dart';
import 'package:task_manager/presentation/UI/Widgets/snack_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _firstNameTEcontroller = TextEditingController();
  final TextEditingController _lastNameTEcontroller = TextEditingController();
  final TextEditingController _mobileTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();
  final TextEditingController _photoTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
          child: Padding(
        padding: EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text("Join With Us",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEcontroller,
                  validator: (String? value) {
                    if (value!.isEmpty ||!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value!)) {
                      return "Enter your valied email address";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _firstNameTEcontroller,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your first name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "First Name",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _lastNameTEcontroller,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your last name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _mobileTEcontroller,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your mobile number";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Mobile",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordTEcontroller,
                  validator: (String? value) {
                    if (value!.isEmpty ||!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value!)) {
                      return "Enter valied password. you must contain at least one upper case, one lower case . one digit and one Special character and length must at least 8 letter";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _signUpInProgress == false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _signUp,
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "have account?",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign in",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.green),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _signUpInProgress = true;
      setState(() {

      });
      final NetworkResponse response =
      await NetworkCaller().postRequest(
        Urls.signup,
        body: {
          "email": _emailTEcontroller.text.trim(),
          "firstName": _firstNameTEcontroller.text.trim(),
          "lastName": _lastNameTEcontroller.text.trim(),
          "mobile": _mobileTEcontroller.text.trim(),
          "password": _passwordTEcontroller.text.trim(),
        },
      );
      _signUpInProgress = false;
      setState(() {

      });
      if (response.isSuccess) {
        if (mounted) {
          _clearTextFeild();
          appSnackMessage(context, "Your account has been created. please log in");
        }
      }else{
        if (mounted) {
          appSnackMessage(context, "Account created failed. try again later",true);
        }
      }
    }
  }

  void _clearTextFeild(){
    _photoTEcontroller.clear();
    _firstNameTEcontroller.clear();
    _lastNameTEcontroller.clear();
    _passwordTEcontroller.clear();
    _mobileTEcontroller.clear();
    _emailTEcontroller.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _photoTEcontroller.dispose();
    _firstNameTEcontroller.dispose();
    _lastNameTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    _mobileTEcontroller.dispose();
    _emailTEcontroller.dispose();
  }
}
