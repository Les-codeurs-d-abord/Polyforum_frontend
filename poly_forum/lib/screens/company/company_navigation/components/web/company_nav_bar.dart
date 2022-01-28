import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_navigation_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/screens/shared/components/nav_bar_profil_btn.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyNavBar extends StatelessWidget {
  final Function onProfileSelected;
  final List<Widget> paths;
  final String title;

  const CompanyNavBar(
      {required this.onProfileSelected,
      required this.paths,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CompanyUser user =
        BlocProvider.of<CompanyGetUserCubit>(context).getUser();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      height: 70,
      child: Stack(
        children: [
          Row(
            children: [
              Row(
                children: [
                  for (int i = 0; i < paths.length; i++)
                    Row(
                      children: [
                        const Icon(Icons.arrow_right),
                        paths[i],
                      ],
                    ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
              NavBarProfilBtn(
                text: user.companyName,
                textTypeUser: "Entreprise",
                onProfileSelected: () {
                  BlocProvider.of<CompanyNavigationCubit>(context)
                      .setSelectedItem(6);
                },
              ),
            ],
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: kButtonColor,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
