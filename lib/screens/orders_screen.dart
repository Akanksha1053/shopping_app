import 'package:flutter/material.dart';
import 'package:shoping_app/providers/orders.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndsetOrders(),
            builder: (ctx, dataSnapShot) {
              if (dataSnapShot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (ConnectionState == null) {
                  return const Center(child: const Text('An error occured'));
                } else {
                  return Consumer<Orders>(
                    builder: (context, orderData, child) => ListView.builder(
                      itemBuilder: (context, index) =>
                          OrderWidget(orderItem: orderData.orders[index]),
                      itemCount: orderData.orders.length,
                    ),
                  );
                }
              }
            }));
  }
}
