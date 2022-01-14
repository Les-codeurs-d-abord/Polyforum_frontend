import 'package:flutter/material.dart';

final RegExp emailValidatorRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
// RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const kScaffoldColor = Colors.white;
const kTextColor = Colors.black;

//à voir
//text (noir - bleu foncé)
const kPrimaryColor = Color(0xFF263238);

//background (bleu clair)
const kSecondaryColor = Color(0xFFE3F3FD);

//button (orange ?)
const kButtonColor = Color(0xFF0D47A1);

// Main color palette
const kOrange = Color(0xFFF7931D);
const kDarkBlue = Color(0xFF004876);
const kBlue = Color(0xFF00AEEF);
const kLightBlue = Color(0xFFA8E2FA);

// Server IP
const kServer = "localhost:8080";
