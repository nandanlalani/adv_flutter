import 'package:adv_flutt/lab2/e-commerce/product_controller.dart';
import 'package:adv_flutt/lab2/e-commerce/product_model.dart';
import 'package:flutter/material.dart';

import 'cardItems_view.dart';



class ECommerceView extends StatefulWidget {
  const ECommerceView({super.key});

  @override
  State<ECommerceView> createState() => _ECommerceViewState();
}

class _ECommerceViewState extends State<ECommerceView> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> filteredList = [];
  final ProductController _controller = ProductController();
  @override
  void initState() {
    super.initState();
    filteredList = productController.productList.cast<ProductModel>();
  }

  void filterSearch(String query) {
    final filtered = productController.productList.where((item) {
      final nameLower = (item.name ?? '').toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredList = filtered.cast<ProductModel>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Ayushi Crop Science",
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartItemsPage(controller: _controller),
                    ));
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                onChanged: filterSearch,
                decoration: const InputDecoration(
                  hintText: "Search products",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  itemCount: filteredList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 280,
                  ),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    final isInCart = productController.cartList.contains(item);
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.asset(
                              item.imageUrl,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "₹${item.price}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: isInCart
                                  ? null
                                  : () {
                                      setState(() {
                                        productController.addToCart(index);
                                      });
                                    },
                              icon: Icon(
                                isInCart ? Icons.check : Icons.add,
                                color: isInCart ? Colors.black : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
