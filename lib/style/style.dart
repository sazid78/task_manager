import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


const colorLightRed = Color.fromRGBO(136, 28, 32, 1);
const colorRed = Color.fromRGBO(231, 28, 36, 1);
const colorGreen = Color.fromRGBO(33, 191, 115, 1);
const colorBlue = Color.fromRGBO(52, 152, 219, 1);
const colorOrange = Color.fromRGBO(230, 126, 36, 1);
const colorWhite = Color.fromRGBO(255, 255, 255, 1);
const colorDarkBlue = Color.fromRGBO(44, 62, 80, 1.0);
const colorLightGray = Color.fromRGBO(136, 28, 32, 1.0);
const colorDark = Color.fromRGBO(135, 142, 150, 1.0);
const colorLight = Color.fromRGBO(211, 211, 211, 1.0);

PinTheme appOtpStyle(){
  return PinTheme(
    inactiveColor: colorLight,
    inactiveFillColor: colorWhite,
    selectedColor: colorGreen,
    activeColor: colorGreen,
    selectedFillColor: colorGreen,
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(5),
    activeFillColor: colorWhite,
    fieldHeight: 50,
    borderWidth: 0.5,
    fieldWidth: 45,
  );
}
AppBar mainAppBar(){
  return AppBar(
    leading: const CircleAvatar(
     backgroundImage: NetworkImage("https://images.pexels.com/photos/15868390/pexels-photo-15868390/free-photo-of-bag-of-tulips.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    ),
    title: const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sazid arefin",style: TextStyle(
          fontSize: 16
        ),),
        Text("sazidarefin20000@gmail.com",style: TextStyle(
          fontSize: 12
        ),)
      ],
    )
    
  );
}