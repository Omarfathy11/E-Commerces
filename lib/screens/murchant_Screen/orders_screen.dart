import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Orders",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => MerchantlayoutCubitCubit()..getOrders(),
        child: BlocConsumer<MerchantlayoutCubitCubit, MerchantlayoutCubitState>(
          listener: (context, state) {
            // Add any necessary listener logic here
          },
          builder: (context, state) {
            if (state is MerchantlayoutCubitInitial) {
              return const Center(
                child:
                    CupertinoActivityIndicator(radius: 40, color: Colors.amber),
              );
            } else if (state is GetOrdersSuccessState) {
              final orders = state.orders;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(order.customer!.fullName!),
                      subtitle: Text(order.customer!.phoneNumber!.toString()),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: order.items!.map((item) {
                          return Text('Product ${item.product!.name}');
                        }).toList(),
                      ),
                    ),
                  );
                },
              );
            } else {
               return const Center(
                      child: CupertinoActivityIndicator(
                          radius: 40, color: Colors.amber));
            }
          },
        ),
      ),
    );
  }
}
