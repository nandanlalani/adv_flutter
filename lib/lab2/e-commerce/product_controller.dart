

import 'package:adv_flutt/lab2/e-commerce/product_model.dart';
import 'package:get/get.dart';

class ProductController {
  List<dynamic> productList = [
    ProductModel(name: 'Ayuban - 20', imageUrl: 'assets/Ayuban - 20.jpg', price: 1000),
    ProductModel(name: 'Ayuban - 50', imageUrl: 'assets/Ayuban - 50.jpg', price: 1500),
    ProductModel(name: 'Ayuban - 505', imageUrl: 'assets/Ayuban - 505.jpg', price: 2000),
    ProductModel(name: 'Ayustara', imageUrl: 'assets/Ayustara.jpg', price: 2500),
    ProductModel(name: 'Ayustara - 75', imageUrl: 'assets/Ayustara - 75.jpg', price: 3000),
    ProductModel(name: 'Confidant', imageUrl: 'assets/Confidant.jpg', price: 3500),
  ];

  List<dynamic> cartList = [];
  double totalamount = 0.0;

  void addToProductList(String name, String image, double price) {
    ProductModel newProduct = ProductModel(name: name, imageUrl: image, price: price);
    productList.add(newProduct);
  }

  void addToCart(int productIndex) {
    if (productIndex >= 0 && productIndex < productList.length) {
      cartList.add(productList[productIndex]);
      totalamount += productList[productIndex].price;
      print(totalamount);
    }
  }

  void removeFromCart(int cartIndex) {
    if (cartIndex >= 0 && cartIndex < cartList.length) {
      totalamount -= cartList[cartIndex].price;
      cartList.removeAt(cartIndex);
      print(totalamount);
    }
  }
}

final ProductController productController = ProductController();
