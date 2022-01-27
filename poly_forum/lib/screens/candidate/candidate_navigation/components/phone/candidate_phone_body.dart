import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_get_user_cubit.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_navigation_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/offers/offers_screen.dart';
import 'package:poly_forum/screens/candidate/profil/edit/candidate_profil_screen.dart';
import 'package:poly_forum/screens/candidate/profil/home/home_profile_screen.dart';
import 'package:poly_forum/screens/candidate/wishlist/choices_screen.dart';
import 'package:poly_forum/screens/password/change_password_screen.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../candidate_profil_btn.dart';

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
            buildTile(context, selectedIndex),
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
          CandidateProfilBtn(
            user: candidateUser,
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
                /* PlanningScreen(user: candidateUser!), */
                Container(),
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

  Widget buildTile(BuildContext context, int selectedIndex) {
    return Container();
    // return Column(
    //   children: [
    //     const SizedBox(height: 20),
    //     TabNavigationItem(
    //       onPressed: () {
    //         Navigator.pop(context);
    //         BlocProvider.of<CandidateNavigationCubit>(context)
    //             .setSelectedItem(0);
    //       },
    //       isSelect: selectedIndex == 0,
    //       text: "Le forum",
    //       iconData: selectedIndex == 0 ? Icons.home : Icons.home_outlined,
    //     ),
    //     const SizedBox(height: 20),
    //     TabNavigationItem(
    //       onPressed: () {
    //         Navigator.pop(context);
    //         BlocProvider.of<CandidateNavigationCubit>(context)
    //             .setSelectedItem(1);
    //       },
    //       isSelect: selectedIndex == 1,
    //       text: "Les offres",
    //       iconData: selectedIndex == 1
    //           ? Icons.local_offer
    //           : Icons.local_offer_outlined,
    //     ),
    //     const SizedBox(height: 20),
    //     TabNavigationItem(
    //       onPressed: () {
    //         Navigator.pop(context);
    //         BlocProvider.of<CandidateNavigationCubit>(context)
    //             .setSelectedItem(2);
    //       },
    //       isSelect: selectedIndex == 2,
    //       text: "Mes choix",
    //       iconData: selectedIndex == 2 ? Icons.bookmark : Icons.bookmark_border,
    //     ),
    //     const SizedBox(height: 20),
    //     TabNavigationItem(
    //       onPressed: () {
    //         Navigator.pop(context);
    //         BlocProvider.of<CandidateNavigationCubit>(context)
    //             .setSelectedItem(4);
    //       },
    //       isSelect: selectedIndex >= 4,
    //       text: "Mon profil",
    //       iconData: selectedIndex >= 4 ? Icons.person : Icons.person_outline,
    //       children: [
    //         TabChildNavigationItem(
    //           title: "Modifier mon profil",
    //           onPress: () {
    //             Navigator.pop(context);
    //             BlocProvider.of<CandidateNavigationCubit>(context)
    //                 .setSelectedItem(5);
    //           },
    //           isSelect: selectedIndex == 5,
    //         ),
    //         TabChildNavigationItem(
    //           title: "Changer mon mot de passe",
    //           onPress: () {
    //             Navigator.pop(context);
    //             BlocProvider.of<CandidateNavigationCubit>(context)
    //                 .setSelectedItem(6);
    //           },
    //           isSelect: selectedIndex == 6,
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
