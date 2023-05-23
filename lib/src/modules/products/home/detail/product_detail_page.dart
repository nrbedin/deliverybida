import 'package:flutter/material.dart';

import 'package:deliverydigital/src/core/ui/styles/text_styles.dart';

class ProductDetailPage extends StatefulWidget {
  final int? productId;

  const ProductDetailPage({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Form(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${widget.productId == null ? 'Alterar' : 'Adicionar'} Produto',
                    style: context.textStyles.textTitle.copyWith(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
