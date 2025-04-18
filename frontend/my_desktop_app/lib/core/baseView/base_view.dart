import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseViewClass extends ConsumerWidget {
  const BaseViewClass({super.key});

  // ignore: recursive_getters
  BuildContext get context => context;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    bool isMobile = MediaQuery.of(context).size.width < 800;
    bool isSmallScreen = MediaQuery.of(context).size.width <= 400;

    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: isMobile ? _buildMobileAppBar(isSmallScreen) : null,
      drawer: isMobile ? buildSideBarArea() : null,
      body: Row(
        children: [
          // if (!isMobile) Expanded(flex: 2, child: buildSideBarArea()),
          if (!isMobile) buildSideBarArea(),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                if (!isMobile) buildTopBarArea(),
                Expanded(child: buildMainContentArea()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildMobileAppBar(bool isSmallScreen) {
    return AppBar(
      toolbarHeight: 50,
      title: isSmallScreen ? null : buildTopBarArea(),
    );
  }

  // Sidebar
  Widget buildSideBarArea();

  // Main content area
  Widget buildMainContentArea();

  // Top bar area
  Widget buildTopBarArea();
}
