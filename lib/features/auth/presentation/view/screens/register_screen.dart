import 'package:flutter/material.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_body_view.dart';
import 'package:games_app/features/auth/presentation/view/widgets/register_view_body.dart';
import 'package:games_app/styles/colors/color_manager.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: ColorManager.primary,
      body:  SafeArea(
        child: RegisterViewBody(),
      ),
    );
  }
}