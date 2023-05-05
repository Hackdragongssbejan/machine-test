import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:http/http.dart' as http;

import '../productdetailsscreen.dart';
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  bool isFavorite=false;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    isFavourite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body)['products'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300,width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.shade500)
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            const snackBar = SnackBar(
              content: Text('This page is currently under development'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }, icon:LineIcon(Icons.shopping_bag),
            color: Colors.grey,
          ) ,
          IconButton(onPressed: () {
            const snackBar = SnackBar(
              content: Text('This page is currently under development'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }, icon:LineIcon(Icons.message),
            color: Colors.grey,
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const SizedBox(
                  width: 289,
                  child: Text('Best Sale Product',style: TextStyle(
                    fontSize: 18
                  )),
                ),
                TextButton(onPressed: (){}, child: const Text('See more',style: TextStyle(
                  color: Colors.green,
                ),))
              ],
            ),
          ),
          FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Product> products = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final Product product = products[index];
                      return InkWell(
                        onTap: () {
                          Get.to(ProductDetailsPage(product: product));
                        },
                        child: Material(
                          borderOnForeground: false,
                          elevation: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Stack(
                              children: [
                                Image.network(
                                  product.thumbnail,
                                  height: 130,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 6.0,
                                  right: 6.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        product.isFavorite = !product.isFavorite;
                                      });
                                    },
                                    child: Icon(
                                      product.isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: product.isFavorite ? Colors.red : Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5.0,
                                  left: 6.0,
                                  right: 6.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5,left: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          product.description,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                          ),
                                          maxLines: 2, // Show only two lines
                                          overflow: TextOverflow.ellipsis, // Show ellipsis if text overflows
                                        ),
                                        const SizedBox(height: 15.0),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/star.png',
                                              height: 12,
                                              width: 12,
                                              color: Colors.yellow.shade700,
                                            ),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              '${product.rating}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.0,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Spacer(),
                                            Text(
                                              '\$${product.price}',
                                              style: TextStyle(
                                                color: Colors.green.shade700,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
                    } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error loading products'),
                );
              } else {
                return const Center(
                  child: LinearProgressIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.blueGrey,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
