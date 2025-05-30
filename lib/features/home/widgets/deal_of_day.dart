import 'package:nukdi4/common/widgets/loader.dart';
import 'package:nukdi4/features/home/services/home_services.dart';
import 'package:nukdi4/features/product_details/screens/product_details_screen.dart';
import 'package:nukdi4/features/search/screens/search_screen.dart'; // ✅ Import this
import 'package:nukdi4/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  void navigateToSeeAllDeals() {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName, // ✅ or use '/search-screen' if not imported
      arguments: 'deal',
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
        ? const SizedBox()
        : GestureDetector(
          onTap: navigateToDetailScreen,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: const Text(
                  'Deal of the day',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Image.network(
                product!.images[0],
                height: 235,
                fit: BoxFit.fitHeight,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                child: const Text('\$100', style: TextStyle(fontSize: 18)),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                child: const Text(
                  'Rivaan',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      product!.images
                          .map(
                            (e) => Image.network(
                              e,
                              fit: BoxFit.fitWidth,
                              width: 100,
                              height: 100,
                            ),
                          )
                          .toList(),
                ),
              ),
              GestureDetector(
                onTap: navigateToSeeAllDeals,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ).copyWith(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'See all deals',
                    style: TextStyle(
                      color: Colors.cyan[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
