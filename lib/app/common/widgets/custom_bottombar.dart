import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastewise/app/common/theme/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double itemWidth = width / 3;
    double bubbleSize = 60;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Bottom Bar
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                  context,
                  icon: Icons.home,
                  index: 0,
                  route: '/home',
                  isSelected: currentIndex == 0),
              _buildNavItem(
                  context,
                  icon: Icons.chat,
                  index: 1,
                  route: '/wisebot',
                  isSelected: currentIndex == 1),
              _buildNavItem(
                  context,
                  icon: Icons.person,
                  index: 2,
                  route: '/account',
                  isSelected: currentIndex == 2),
            ],
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          left: (itemWidth * currentIndex) + (itemWidth / 2) - (bubbleSize / 2),
          bottom: 20,
          child: Container(
            width: bubbleSize,
            height: bubbleSize,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  currentIndex == 0
                      ? Icons.home
                      : currentIndex == 1
                      ? Icons.chat
                      : Icons.person,
                  key: ValueKey<int>(currentIndex),
                  size: 32,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(BuildContext context,
      {required IconData icon,
        required int index,
        required String route,
        required bool isSelected}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Hanya navigasi jika index berbeda
          if (!isSelected) {
            Get.offAllNamed(route);
          }
        },
        child: SizedBox(
          height: 70,
          child: Center(
            child: Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.transparent : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
