import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_provider.dart';
import '../ViewModel/AddtoCart/getcardtotal_view_model.dart';
import '../widgets/bill_summary_widget.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    final vm =
    Provider.of<GetCartTotalViewModel>(context, listen: false);
    vm.fetchCartTotal(firmId: 1, userTypeId: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartList.isEmpty) {
            return const Center(
              child: Text(
                "Cart is Empty",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: cartProvider.cartList.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.cartList[index];

                    return Container(
                      margin:
                      const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(12),
                            child: Image.network(
                              item.imageUrl,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context,
                                  error, stackTrace) {
                                return Container(
                                  height: 70,
                                  width: 70,
                                  color:
                                  Colors.grey.shade200,
                                  child: const Icon(Icons
                                      .image_not_supported),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productName,
                                  maxLines: 1,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style:
                                  const TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "₹${item.price}",
                                  style:
                                  const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: 36,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blue),
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize:
                              MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding:
                                  EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    cartProvider
                                        .decreaseQty(
                                        item.productName,
                                        item.minQuantity);
                                  },
                                ),
                                Text(
                                  item.qty.toString(),
                                  style:
                                  const TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  padding:
                                  EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    cartProvider
                                        .increaseQty(
                                        item.productName);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const BillSummaryWidget(),
            ],
          );
        },
      ),
    );
  }
}