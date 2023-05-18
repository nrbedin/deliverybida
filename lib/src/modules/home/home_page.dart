import 'package:flutter/material.dart';

import 'package:deliverydigital/src/core/env/env.dart';
import 'package:deliverydigital/src/core/ui/helpers/loader.dart';
import 'package:deliverydigital/src/core/ui/helpers/messages.dart';
import 'package:deliverydigital/src/core/ui/helpers/size_extensions.dart';
import 'package:deliverydigital/src/core/ui/styles/colors_app.dart';
import 'package:deliverydigital/src/core/ui/styles/text_styles.dart';
import 'package:deliverydigital/src/modules/template/base_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: context.colors.primary,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('Login'),
                  ),
                  validator: (String) => 'Erro',
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Botão',
                  style: context.textStyles.textExtraBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
