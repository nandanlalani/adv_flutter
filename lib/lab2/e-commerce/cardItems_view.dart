import 'package:adv_flutt/lab2/e-commerce/product_controller.dart';
import 'package:flutter/material.dart';


class CartItemsPage extends StatefulWidget {
  final ProductController controller = ProductController();
  CartItemsPage({super.key, required ProductController controller});

  @override
  State<CartItemsPage> createState() => _CartItemsPageState();
}

class _CartItemsPageState extends State<CartItemsPage> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> cartItems = [];

  @override
  void initState() {
    super.initState();
    cartItems = List.from(productController.cartList);
  }

  void removeItem(int index) {
    setState(() {
      productController.removeFromCart(index);
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = cartItems.isEmpty;
    double amount = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Cart", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: isEmpty
            ? Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
              SizedBox(height: 24),
              Text("Your cart is empty", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text("Start adding items to see them here.", textAlign: TextAlign.center),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text("Go to Shop"),
              ),
            ],
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search cart items",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onChanged: (value) {
                  setState(() {
                    cartItems = productController.cartList
                        .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: cartItems.isEmpty
                    ? Center(child: Text("No matching items"))
                    : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    amount = amount + item.price;
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Image.asset(item.imageUrl, width: 50, height: 50),
                        title: Text(item.name),
                        subtitle: Text("₹${item.price}"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("Remove item"),
                                content: Text("Remove this item from cart?"),
                                actions: [
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: Text("Remove", style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      setState(() {
                                        removeItem(index);
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              Text("₹Checkout amount: ${productController.totalamount}",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              ElevatedButton(
                onPressed: () {

                },
                child: Text("CheckOut"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
