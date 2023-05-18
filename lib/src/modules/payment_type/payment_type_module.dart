import 'package:flutter_modular/flutter_modular.dart';

import 'package:deliverydigital/src/modules/payment_type/paymente_type_page.dart';

class PaymentTypeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => const PaymenteTypePage())];
}
