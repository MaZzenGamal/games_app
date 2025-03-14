
import 'package:flutter/material.dart';
import 'package:games_app/styles/assets/asset_manager.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.center,
      child: Image(
        width: MediaQuery.sizeOf(context).width*.3,
        height: MediaQuery.sizeOf(context).height*.1,
        fit: BoxFit.cover,
        image: const AssetImage(
            AssetManager.logoLight
        ),
      ),
    );
  }
}