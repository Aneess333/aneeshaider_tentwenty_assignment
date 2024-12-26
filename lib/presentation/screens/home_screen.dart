import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwenty_assessment/helper/constants/strings_resources.dart';
import 'package:tentwenty_assessment/presentation/screens/dashboard.dart';
import 'package:tentwenty_assessment/presentation/screens/media_library.dart';
import 'package:tentwenty_assessment/presentation/screens/more.dart';
import 'package:tentwenty_assessment/presentation/screens/watch.dart';

import '../../buisnessLogic/cubit/navigationBarCubit/navigation_bar_cubit.dart';
import '../../helper/constants/colors_resources.dart';
import '../../helper/constants/dimension_resources.dart';
import '../../helper/constants/image_resources.dart';
import '../../helper/enums/nav_bar_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BlocBuilder<NavigationBarCubit, NavigationBarState>(
          builder: (context, state) {
        return Theme(
            data: ThemeData(
              splashColor: Colorss.TRANSPARENT,
              highlightColor: Colorss.TRANSPARENT
            ),
            child: ClipRRect(borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dim.D_25),
              topRight: Radius.circular(Dim.D_25),
            ),child: bottomNavBar(state)));
      }),
      backgroundColor: Colorss.LIGHT_WHITE,
      body: BlocBuilder<NavigationBarCubit, NavigationBarState>(
          builder: (context, state) {
        if (state.navbarItem == NavbarItems.DASHBOARD) {
          return const Dashboard();
        } else if (state.navbarItem == NavbarItems.WATCH) {
          return const Watch();
        } else if (state.navbarItem == NavbarItems.MEDIA_LIBRARY) {
          return const MediaLibrary();
        } else if (state.navbarItem == NavbarItems.MORE) {
          return const More();
        }
        return Container();
      }),
    );
  }

  BottomNavigationBar bottomNavBar(NavigationBarState state) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      currentIndex: state.index,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      backgroundColor: Colorss.NAV_BAR_COLOR,
      unselectedItemColor: Colorss.WHITE.withOpacity(0.54),
      selectedItemColor: Colorss.WHITE,
      unselectedLabelStyle: GoogleFonts.roboto(
          textStyle: theme.textTheme.bodyMedium?.copyWith(
              inherit: true,
              fontWeight: FontWeight.w400,
              color: Colorss.WHITE.withOpacity(0.54))),
      selectedLabelStyle: GoogleFonts.roboto(
          textStyle: theme.textTheme.bodyMedium?.copyWith(
              inherit: true,
              fontWeight: FontWeight.w700,
              color: Colorss.WHITE)),
      items: [
        customBottomNavigationBarItem(
          ImagesResource.DASHBOARD_INACTIVE_ICON,
          ImagesResource.DASHBOARD_ACTIVE_ICON,
          Strings.DASHBOARD,
        ),
        customBottomNavigationBarItem(
          ImagesResource.WATCH_INACTIVE_ICON,
          ImagesResource.WATCH_ACTIVE_ICON,
          Strings.WATCH,
        ),
        customBottomNavigationBarItem(
          ImagesResource.MEDIA_LIBRARY_INACTIVE_ICON,
          ImagesResource.MEDIA_LIBRARY_ACTIVE_ICON,
          Strings.MEDIA_LIBRARY,
        ),
        customBottomNavigationBarItem(
          ImagesResource.MORE_INACTIVE_ICON,
          ImagesResource.MORE_ACTIVE_ICON,
          Strings.MORE,
        ),
      ], // Ensure clipping is applied to the corners

      onTap: (index) {
        if (index == 0) {
          BlocProvider.of<NavigationBarCubit>(context)
              .getNavBarItem(NavbarItems.DASHBOARD);
        } else if (index == 1) {
          BlocProvider.of<NavigationBarCubit>(context)
              .getNavBarItem(NavbarItems.WATCH);
        } else if (index == 2) {
          BlocProvider.of<NavigationBarCubit>(context)
              .getNavBarItem(NavbarItems.MEDIA_LIBRARY);
        } else if (index == 3) {
          BlocProvider.of<NavigationBarCubit>(context)
              .getNavBarItem(NavbarItems.MORE);
        }
      },
    );
  }

  BottomNavigationBarItem customBottomNavigationBarItem(
      String inactiveIcon, String activeIcon, String label) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(inactiveIcon),
          const SizedBox(height: Dim.D_5),
        ],
      ),
      activeIcon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(activeIcon),
          const SizedBox(height: Dim.D_5),
        ],
      ),
      label: label,
    );
  }
}
