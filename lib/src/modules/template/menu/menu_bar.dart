import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:deliverydigital/src/core/ui/helpers/size_extensions.dart';
import 'package:deliverydigital/src/modules/template/menu/menu_button.dart';
import 'package:deliverydigital/src/modules/template/menu/menu_enum.dart';

class MenuBar extends StatefulWidget {
  const MenuBar({super.key});

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  Menu? selectedMenu;
  var colapsed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: colapsed ? 90 : context.percentWidth(.18),
      height: double.infinity,
      //color: Colors.grey[300],
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: colapsed ? Alignment.center : Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                setState(() {
                  colapsed = !colapsed;
                });
              },
              icon: Icon(
                colapsed
                    ? Icons.keyboard_double_arrow_right
                    : Icons.keyboard_double_arrow_left,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: Menu.values.length,
              itemBuilder: (context, index) {
                final menu = Menu.values[index];
                return MenuButton(
                  menu: menu,
                  menuSelected: selectedMenu,
                  onPressed: (Menu menu) {
                    setState(() {
                      selectedMenu = menu;
                      Modular.to.navigate(menu.route);
                    });
                  },
                );
              })
        ],
      ),
    );
  }
}
