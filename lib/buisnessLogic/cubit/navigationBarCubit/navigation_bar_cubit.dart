


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../helper/enums/nav_bar_items.dart';
part 'navigation_bar_state.dart';
class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit()
      : super(const NavigationBarState(NavbarItems.WATCH, 1));

  void getNavBarItem(NavbarItems navbarItem) {
    switch (navbarItem) {
      case NavbarItems.DASHBOARD:
        emit(const NavigationBarState(NavbarItems.DASHBOARD, 0));
        break;
      case NavbarItems.WATCH:
        emit(const NavigationBarState(NavbarItems.WATCH, 1));
        break;
      case NavbarItems.MEDIA_LIBRARY:
        emit(const NavigationBarState(NavbarItems.MEDIA_LIBRARY, 2));
        break;
      case NavbarItems.MORE:
        emit(const NavigationBarState(NavbarItems.MORE, 3));
        break;
    }
  }
}
