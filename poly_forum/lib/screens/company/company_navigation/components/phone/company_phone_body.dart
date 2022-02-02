import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_navigation_cubit.dart';
import 'package:poly_forum/cubit/info_phase_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/screens/candidate/profil/home/home_profile_screen.dart';
import 'package:poly_forum/screens/company/candidat/list/candidat_list.dart';
import 'package:poly_forum/screens/company/offers/create/create_offer_screen.dart';
import 'package:poly_forum/screens/company/offers/edit/edit_offer_screen.dart';
import 'package:poly_forum/screens/company/offers/get/offers_screen.dart';
import 'package:poly_forum/screens/company/profile/edit/company_profil_screen.dart';
import 'package:poly_forum/screens/company/wishlist/wishlist_screen.dart';
import 'package:poly_forum/screens/password/change_password_screen.dart';
import 'package:poly_forum/screens/shared/components/nav_bar_profil_btn.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/screens/welcome/components/info_phase.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:poly_forum/utils/constants.dart';

import '../tab_navigation_item_list.dart';

class CompanyPhoneBody extends StatelessWidget {
  const CompanyPhoneBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyNavigationCubit, CompanyNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CompanyNavigationLoaded) {
          return buildScreen(
            context,
            state.index,
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildScreen(BuildContext context, int selectedIndex) {
    final CompanyUser user =
        BlocProvider.of<CompanyGetUserCubit>(context).getUser();

    final currentPhase = BlocProvider.of<PhaseCubit>(context).currentPhase;

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
        title: Text(
          getTitle(selectedIndex),
          style: const TextStyle(
            color: kButtonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          BlocConsumer<InfoPhaseCubit, InfoPhaseState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is InfoPhaseLoaded) {
                bool notif = false;
                if (currentPhase == Phase.inscription &&
                    state.infos.containsKey(0)) {
                  for (var info in state.infos[0]!) {
                    if (!info.isValid) notif = true;
                  }
                }
                if (currentPhase == Phase.wish && state.infos.containsKey(1)) {
                  for (var info in state.infos[1]!) {
                    if (!info.isValid) notif = true;
                  }
                }

                return Center(
                  child: Stack(
                    children: [
                      PopupMenuButton<int>(
                        onSelected: (value) {
                          if (value == 0) {
                            BlocProvider.of<CompanyNavigationCubit>(context)
                                .setSelectedItem(7);
                          } else if (value == 1) {
                            BlocProvider.of<CompanyNavigationCubit>(context)
                                .setSelectedItem(2);
                          } else if (value == 2) {
                            BlocProvider.of<CompanyNavigationCubit>(context)
                                .setSelectedItem(3);
                          }
                        },
                        itemBuilder: (context) => [
                          if (currentPhase == Phase.inscription &&
                              state.infos.containsKey(0))
                            for (int i = 0; i < state.infos[0]!.length; i++)
                              PopupMenuItem(
                                value: i,
                                child: InfoPhase(
                                    context: context, info: state.infos[0]![i]),
                              ),
                          if (currentPhase == Phase.wish &&
                              state.infos.containsKey(1))
                            for (var info in state.infos[1]!)
                              PopupMenuItem(
                                value: 2,
                                child: InfoPhase(context: context, info: info),
                              ),
                        ],
                        tooltip: "Notifications",
                        child: const Icon(
                          Icons.notifications,
                          size: 40,
                        ),
                      ),
                      notif
                          ? const IgnorePointer(
                              child: Icon(Icons.circle,
                                  color: Colors.red, size: 25))
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              } else if (state is InfoPhaseError) {
                return const SizedBox.shrink();
              }

              return const CircularProgressIndicator();
            },
          ),
          NavBarProfilBtn(
            text: user.companyName,
            uri: user.logo,
            textTypeUser: "Entreprise",
            onProfileSelected: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(6);
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
                WelcomeScreen(
                    user: BlocProvider.of<CompanyGetUserCubit>(context).user),
                const OffersScreen(),
                const CreateOfferScreen(),
                const CandidatList(),
                const WishlistScreen(),
                Container(), //planning
                HomeProfileScreen(
                  onEditProfilePressed: () {
                    BlocProvider.of<CompanyNavigationCubit>(context)
                        .setSelectedItem(7);
                  },
                  onChangePasswordPressed: () {
                    BlocProvider.of<CompanyNavigationCubit>(context)
                        .setSelectedItem(8);
                  },
                ),
                const CompanyProfileScreen(), //profil
                ChangePasswordScreen(
                    BlocProvider.of<CompanyGetUserCubit>(context).getUser()),
                if (selectedIndex == 9) const EditOfferScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getTitle(int selectedIndex) {
    String title = "";

    switch (selectedIndex) {
      case 0:
        title = "Le forum";
        break;
      case 1:
        title = "Mes offres";
        break;
      case 2:
        title = "Créer une offre";
        break;
      case 3:
        title = "Liste des candidats";
        break;
      case 4:
        title = "Mes voeux";
        break;
      case 5:
        title = "Mon planning";
        break;
      case 6:
        title = "Mon profil";
        break;
      case 7:
        title = "Modifier mon profil";
        break;
      case 8:
        title = "Changer le mot de passe";
        break;
      case 9:
        title = "Modifier une offre";
        break;
    }

    return title;
  }
}
