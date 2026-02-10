import 'package:flutter/material.dart';
import 'package:football_ticket/page/login_and_sign_up/login_page.dart';
import 'package:football_ticket/page/main/main_page.dart';
import 'package:football_ticket/service/auth_service.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const LoginScreen();
          }
        },
      )
      ),
    );
  }
}