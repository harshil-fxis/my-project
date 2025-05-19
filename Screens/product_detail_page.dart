import 'package:flutter/material.dart';
import 'package:login1/Model/ProductModel';


class ProductDetailsScreen extends StatelessWidget {
  final dynamic Product;
  
  const ProductDetailsScreen({Key? key, required this.Product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Product['title']),
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Center(
                child: Image.network(
                  Product['image'],
                  height: 350,
                  width: 450,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                Product['title'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Product Price
              Padding(
                padding: const EdgeInsets.only(left: 0,right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${Product['price']}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[700], size: 20),
                          const SizedBox(width: 5),
                        Text(
                          '${Product['rating']['rate']}',
                          // '${product.rating!.rate!}',
                          style: const TextStyle(fontSize: 16),
                      ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Product Description
              Text(
                Product['description'],
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.green.shade400,
                    height: 50,
                    width: 170,
                    child: Center(child: Text("But Now",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    color: Colors.green.shade400,
                    height: 50,
                    width: 170,
                    child: Center(child: Text("Add to Cart",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
