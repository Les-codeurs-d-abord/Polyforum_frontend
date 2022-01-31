import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_get_user_cubit.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_navigation_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/offers/offers_screen.dart';
import 'package:poly_forum/screens/candidate/planning/planning_screen.dart';
import 'package:poly_forum/screens/candidate/profil/edit/candidate_profil_screen.dart';
import 'package:poly_forum/screens/candidate/profil/home/home_profile_screen.dart';
import 'package:poly_forum/screens/candidate/wishlist/choices_screen.dart';
import 'package:poly_forum/screens/password/change_password_screen.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/nav_bar_profil_btn.dart';
import '../tab_navigation_item_list.dart';

class CandidatePhoneBody extends StatelessWidget {
  const CandidatePhoneBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateNavigationCubit, CandidateNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CandidateNavigationLoaded) {
          return buildScreen(
            context,
            state.index,
            BlocProvider.of<CandidateGetUserCubit>(context).getUser(),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildScreen(
      BuildContext context, int selectedIndex, CandidateUser candidateUser) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          primary: false,
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(
                child: Image.asset('images/logo.png'),
              ),
            ),
            TabNavigationItemList(selectedIndex: selectedIndex),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "PolyForum",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          NavBarProfilBtn(
            uri: candidateUser.logo,
            text: candidateUser.firstName + " " + candidateUser.lastName,
            textTypeUser: "Candidat",
            onProfileSelected: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(4);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: <Widget>[
                const WelcomeScreen(),
                OffersScreen(user: candidateUser),
                ChoicesScreen(user: candidateUser),
                PlanningScreen(user: candidateUser),
                HomeProfileScreen(
                  onEditProfilePressed: () {
                    BlocProvider.of<CandidateNavigationCubit>(context)
                        .setSelectedItem(5);
                  },
                  onChangePasswordPressed: () {
                    BlocProvider.of<CandidateNavigationCubit>(context)
                        .setSelectedItem(6);
                  },
                ),
                CandidateProfilScreen(candidateUser: candidateUser),
                ChangePasswordScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
