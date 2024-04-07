import 'package:flutter/material.dart';
import '../model/Item.dart';
import 'package:provider/provider.dart';
import '../provider/shoppingcart_provider.dart';

class Checkout extends StatelessWidget{
  const Checkout({super.key});
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
        ]
      )

    );
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
       return Text("Total cost to pay: ${cart.cartTotal}");
    });
  }

  Widget getItems(BuildContext context){
    List<Item> products = context.watch<ShoppingCart>().cart;

    return products.isEmpty
      ? Center(
          child: Text("No items to checkout!", textAlign: TextAlign.center),
        )
      : Expanded(
        child: Column(
          children: [
            Text("Item Details"),
            Divider(),
            Flexible(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(products[index].name),
                        ),
                        Text('${products[index].price.toStringAsFixed(2)}'),
                      ]
                    )
                  );
                }
              )
            ),
            Divider(),
            computeCost(),
            Flexible(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<ShoppingCart>(context, listen: false).removeAll(); //clear the shopping cart
                        Navigator.pushNamed(context, "/products"); //return to shopping catalog
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Payment Successful!"),
                          duration: const Duration(seconds: 1, milliseconds: 100),
                        ));
                      },
                      child: const Text("Pay Now")),
                  ]
                )
              )
            ),
          ]

        )
      );
  }
}