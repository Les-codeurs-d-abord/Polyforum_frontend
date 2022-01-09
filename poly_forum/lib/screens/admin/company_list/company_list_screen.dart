import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/company_list/company_list_screen_cubit.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/screens/admin/company_list/components/body.dart';
import 'package:poly_forum/utils/constants.dart';

class CompanyListScreen extends StatelessWidget {
  static const route = "/ListeEntreprise";

  const CompanyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: BlocProvider(
        create: (context) => CompanyListScreenCubit(CompanyRepository()),
        child: const Body(),
      ),
    );
  }
}
