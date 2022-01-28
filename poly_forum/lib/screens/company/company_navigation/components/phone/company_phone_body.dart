import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_navigation_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_navigation_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/screens/candidate/profil/home/home_profile_screen.dart';
import 'package:poly_forum/screens/company/candidat/list/candidat_list.dart';
import 'package:poly_forum/screens/company/offers/create/create_offer_screen.dart';
import 'package:poly_forum/screens/company/offers/get/offers_screen.dart';
import 'package:poly_forum/screens/company/profile/edit/company_profil_screen.dart';
import 'package:poly_forum/screens/company/wishlist/wishlist_screen.dart';
import 'package:poly_forum/screens/password/change_password_screen.dart';
import 'package:poly_forum/screens/shared/components/nav_bar_profil_btn.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_child_navigation_item.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_navigation_item.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: <Widget>[
                const WelcomeScreen(),
                const OffersScreen(),
                const CreateOfferScreen(),
                const CandidatList(),
                const WishlistScreen(),
                Container(), //planning
                HomeProfileScreen(
                  onEditProfilePressed: () {
                    BlocProvider.of<CompanyNavigationCubit>(context)
                        .setSelectedItem(6);
                  },
                  onChangePasswordPressed: () {
                    BlocProvider.of<CompanyNavigationCubit>(context)
                        .setSelectedItem(7);
                  },
                ),
                const CompanyProfileScreen(), //profil
                ChangePasswordScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTile(BuildContext context, int selectedIndex) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 10),
            Image.asset(
              'images/logo.png',
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text(
              "PolyForum",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        TabNavigationItem(
          index: 0,
          selectedIndex: selectedIndex,
          text: "Le forum",
          iconSelected: Icons.home,
          iconNonSelected: Icons.home_outlined,
        ),
        const SizedBox(height: 20),
        TabNavigationItem(
          index: 1,
          selectedIndex: selectedIndex,
          text: "Mes offres",
          iconSelected: Icons.local_offer,
          iconNonSelected: Icons.local_offer_outlined,
          children: [
            TabChildNavigationItem(
              index: 2,
              selectedIndex: selectedIndex,
              text: "Créer une offre",
            ),
          ],
        ),
        const SizedBox(height: 20),
        TabNavigationItem(
          index: 3,
          selectedIndex: selectedIndex,
          text: "Les candidats",
          iconSelected: Icons.local_offer,
          iconNonSelected: Icons.local_offer_outlined,
        ),
        const SizedBox(height: 20),
        TabNavigationItem(
          index: 4,
          selectedIndex: selectedIndex,
          text: "Mes voeux",
          iconSelected: Icons.local_offer,
          iconNonSelected: Icons.local_offer_outlined,
        ),
        const SizedBox(height: 20),
        TabNavigationItem(
          index: 5,
          selectedIndex: selectedIndex,
          text: "Mon planning",
          iconSelected: Icons.local_offer,
          iconNonSelected: Icons.local_offer_outlined,
        ),
        const SizedBox(height: 20),
        TabNavigationItem(
          index: 6,
          selectedIndex: selectedIndex,
          text: "Mon profil",
          iconSelected: Icons.person,
          iconNonSelected: Icons.person_outline,
          children: [
            TabChildNavigationItem(
              index: 7,
              selectedIndex: selectedIndex,
              text: "Modifier mon profil",
            ),
            TabChildNavigationItem(
              index: 8,
              selectedIndex: selectedIndex,
              text: "Changer mon mot de passe",
            ),
          ],
        ),
      ],
    );
  }
}
