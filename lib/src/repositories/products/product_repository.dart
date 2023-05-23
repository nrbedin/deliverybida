import 'dart:typed_data';

import 'package:deliverydigital/src/models/product_model.dart';
import 'package:deliverydigital/src/modules/products/home/products_module.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> findAll(String? name);
  Future<ProductModel> getProduct(int id);
  Future<void> save(ProductModel productModel);
  Future<String> uploadImageProduct(Uint8List file, String filename);
  Future<void> deleteProduct(int id);
}
