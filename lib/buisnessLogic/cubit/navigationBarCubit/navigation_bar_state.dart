

part of 'navigation_bar_cubit.dart';

class NavigationBarState extends Equatable {
  @override
  List<Object> get props => [navbarItem, index];

  const NavigationBarState(this.navbarItem, this.index);

  final NavbarItems navbarItem;
  final int index;
}
