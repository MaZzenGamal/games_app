import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/features/auth/presentation/view/screens/register_screen.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class CreateNewAccountButton extends StatelessWidget {
  const CreateNewAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            'ليس لديك حساب؟',
            style: TextStyles.textStyle18Regular.copyWith(
                fontSize: MediaQuery.sizeOf(context).height*.018
            )
        ),
        TextButton(
          onPressed: (){
            customPushNavigator(context, const RegisterScreen());
          },
          child: Text(
              'انشاء حساب جديد',
              style: TextStyles.textStyle18Bold.copyWith(
                  fontSize: MediaQuery.sizeOf(context).height*.018
              )
          ),
        ),

      ],
    );
  }
}
