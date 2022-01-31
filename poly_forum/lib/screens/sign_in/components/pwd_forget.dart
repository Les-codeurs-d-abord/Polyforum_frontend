import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/pwd_forget_form_cubit.dart';
import 'package:poly_forum/resources/user_repository.dart';
import 'package:poly_forum/screens/sign_in/components/pwd_forget_form.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PwdForget extends StatelessWidget {
  const PwdForget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext builder) {
              return BlocProvider(
                create: (context) => PwdForgetFormCubit(UserRepository()),
                child: const PwdForgetForm(),
              );
            }
        );
      },
      style: TextButton.styleFrom(
        primary: kPrimaryColor,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      child: const Text("Mot de passe oublié"),
    );
  }
}
