import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/company_profile_cubit.dart';
import 'package:poly_forum/screens/company/profile/edit/components/profile_form.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: BlocProvider(
        create: (context) => CompanyProfileCubit(),
        child: const ProfileForm(),
      ),
      width: 1200,
    );
  }
}
