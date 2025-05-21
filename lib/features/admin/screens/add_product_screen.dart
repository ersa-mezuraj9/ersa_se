import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:nukdi4/constants/global_variables.dart';
import 'package:nukdi4/constants/utils.dart';
import 'package:nukdi4/common/widgets/custom_button.dart';
import 'package:nukdi4/common/widgets/custom_textfield.dart';
import 'package:nukdi4/features/admin/services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _carBrandController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();
  final TextEditingController _carYearController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  final AdminServices adminServices = AdminServices();

  final _addProductFormKey = GlobalKey<FormState>();
  List<File> images = [];
  String category = 'Mobiles';

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _carBrandController.dispose();
    _carModelController.dispose();
    _carYearController.dispose();
    _stockController.dispose();
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        category: category,
        images: images,
        carBrand: _carBrandController.text,
        carModel: _carModelController.text,
        carYear: int.parse(_carYearController.text),
        stock: int.parse(_stockController.text),
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: GlobalVariables.secondaryColor,
          title: const Text('Add Product'),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) => Image.file(
                            images[index],
                            fit: BoxFit.cover,
                            width: 100,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.folder_open,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextField(controller: _nameController, hintText: 'Product Name'),
                const SizedBox(height: 10),
                CustomTextField(controller: _descriptionController, hintText: 'Description', maxLines: 3),
                const SizedBox(height: 10),
                CustomTextField(controller: _priceController, hintText: 'Price'),
                const SizedBox(height: 10),
                CustomTextField(controller: _quantityController, hintText: 'Quantity'),
                const SizedBox(height: 10),
                CustomTextField(controller: _carBrandController, hintText: 'Car Brand'),
                const SizedBox(height: 10),
                CustomTextField(controller: _carModelController, hintText: 'Car Model'),
                const SizedBox(height: 10),
                CustomTextField(controller: _carYearController, hintText: 'Car Year'),
                const SizedBox(height: 10),
                CustomTextField(controller: _stockController, hintText: 'Stock Quantity'),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(text: 'Sell', onTap: sellProduct),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
