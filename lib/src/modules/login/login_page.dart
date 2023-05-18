import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

import 'package:deliverydigital/src/core/ui/helpers/loader.dart';
import 'package:deliverydigital/src/core/ui/helpers/messages.dart';
import 'package:deliverydigital/src/core/ui/helpers/size_extensions.dart';
import 'package:deliverydigital/src/core/ui/styles/colors_app.dart';
import 'package:deliverydigital/src/core/ui/styles/text_styles.dart';
import 'package:deliverydigital/src/modules/login/login_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader, Messages {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Modular.get<LoginController>();
  late final ReactionDisposer statusReactionDisposer;

  @override
  void initState() {
    statusReactionDisposer = reaction(
      (_) => controller.loginStatus,
      (status) {
        switch (status) {
          case LoginStateStatus.initial:
            break;
          case LoginStateStatus.loading:
            showLoader();
            break;
          case LoginStateStatus.success:
            hideLoader();
            Modular.to.navigate('/');
            break;
          case LoginStateStatus.error:
            hideLoader();
            showError(controller.erroMessage ?? 'Erro');
            break;
        }
      },
    );
    super.initState();
  }

  @override
  void _formSubmit() {
    final formValid = formKey.currentState?.validate() ?? false;
    if (formValid) {
      controller.login(emailEC.text, passwordEC.text);
    }
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    statusReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenShortesSide = context.screenShortesSide;
    final screenWidth = context.screenWidth;
    return Scaffold(
      backgroundColor: context.colors.black,
      body: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenShortesSide * 1,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/lanche.png',
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
              width: screenShortesSide * .5,
              padding: EdgeInsets.only(top: context.percentHeight(.10)),
              // child: Image.asset(
              //   'assets/images/logo11.png',
              // ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: context.percentWidth(screenWidth < 1300 ? .7 : .3),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      30,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .3,
                          child: Image.asset('assets/images/logo11.png'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Login',
                            style: context.textStyles.textTitle,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailEC,
                          onFieldSubmitted: (_) => _formSubmit(),
                          decoration: InputDecoration(labelText: 'E-mail'),
                          validator: Validatorless.multiple([
                            Validatorless.required('E-mail Obrigatório'),
                            Validatorless.email('E-mail inválido'),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordEC,
                          obscureText: true,
                          onFieldSubmitted: (_) => _formSubmit(),
                          decoration: InputDecoration(labelText: 'Senha'),
                          validator:
                              Validatorless.required('Senha Obrigatória'),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _formSubmit,
                            child: Text(
                              'Entrar',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
