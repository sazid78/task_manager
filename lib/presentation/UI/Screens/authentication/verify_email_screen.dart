import 'package:flutter/material.dart';
import 'package:task_manager/presentation/UI/Screens/authentication/login_screen.dart';
import 'package:task_manager/presentation/UI/Screens/authentication/pin_verification_screen.dart';
import 'package:task_manager/presentation/UI/Screens/authentication/signup_screen.dart';
import 'package:task_manager/presentation/UI/Widgets/body_background.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
          child: Padding(
        padding: EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 160,
              ),
              Text("Your Email Address",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: 8,
              ),
               Text(
                "A 6 digit verification pin will sent to your email address",
                style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PinVerificationScreen()));
                  },
                  child: const Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Have account?",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.grey
                    ),
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
                    child:  Text(
                      "Sign In",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.green
                      )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
