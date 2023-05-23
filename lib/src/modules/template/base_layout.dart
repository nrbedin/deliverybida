import 'package:flutter/material.dart';

import 'package:deliverydigital/src/core/ui/helpers/size_extensions.dart';
import 'package:deliverydigital/src/core/ui/styles/colors_app.dart';
import 'package:deliverydigital/src/modules/template/menu/menu_bar.dart'
    as menu;

class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final shortestSide = context.screenShortesSide;
    return Scaffold(
      body: SizedBox(
        height: context.screenHeight,
        child: Stack(
          children: [
            Container(
              color: Colors.grey[850],
              constraints: BoxConstraints(
                minWidth: screenWidth,
                minHeight: shortestSide * .15,
                maxHeight: shortestSide * .15,
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                width: shortestSide * .13,
                margin: const EdgeInsets.only(left: 60),
                child: Image.asset(
                  fit: BoxFit.cover,
                  'assets/images/logogrey850.png',
                ),
              ),
            ),
            Positioned.fill(
              top: shortestSide * .13,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800], //alterei
                  //borderRadius: const BorderRadius.horizontal(
                  //  left: Radius.circular(20),
                  //  right: Radius.circular(20),
                  //),
                ),
                child: Row(
                  children: [
                    const menu.MenuBar(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: Colors.grey[50],
                        child: body,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
