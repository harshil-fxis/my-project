import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login1/Model/ProductModel';
import 'package:login1/Screens/product_detail_page.dart';


class home1 extends StatefulWidget {
  const home1({super.key});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  late Future<List<ProductModel>> _products;
  List<dynamic> productmodel = [];
  bool isLoading = true;
  
  List categories = [
    "All",
    "Men's Clothes",
    "Women's Clothes",
    "Jewelery",
    "Electronics"
  ];


  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 40,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu,size: 35,color: Colors.black,),
              Icon(Icons.notifications,size: 35,color: Colors.black,),
            ],
          ),
          SizedBox(height: 10,),
          Text("Get your product",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
          Text("Delivered!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          _buildCategoriesRow(),
          Expanded (
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // Show loader while fetching data
                : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Display two products per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.53,
                // Aspect ratio for better layout
              ),
              itemCount: productmodel.length,
              itemBuilder: (context,index){
                final product = productmodel[index];
                final dynamic Product = product;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(Product: Product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                    ),
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Rounded image corners
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue.shade200,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.yellow[700], size: 20),
                                        const SizedBox(width: 5),
                                        Center(child: Text('${Product['rating']['rate']}')),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(Icons.favorite_border)
                              ],
                            ),
                            SizedBox(height: 15,),
                            Image.network(
                              Product['image'],
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(height: 10,),
                            Text(Product['title'],maxLines: 2,),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('\$ ${Product['price']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                Container(
                                  height: 30,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange,
                                  ),
                                  child: Center(child: Text("View")),
                                )
                              ],
                            ),

                            // Text('${Product.price}'),

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],),
      ),
    );
  }

int currentCategoryIndex = 0;
  Container _buildCategoriesRow() {
    return Container(
          height: 40,
          child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
              onTap: (){
                setState(() {
                  currentCategoryIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index == currentCategoryIndex ?Colors.orange:Colors.grey.shade100,
                  ),
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(categories[index],style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                  )),
              ),
            )
          ),
        );
  }



  Future<void> getData() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      setState(() {
        productmodel = jsonDecode(response.body);
        isLoading = false;
        print(response.body.toString()+"hello");
        log(response.body.toString());
      });
    } else {
      // Handle API error
      isLoading = true;
      throw Exception('Failed to load products');
      
    }
  }
  // Future<List<ProductModel>> getData() async{
  //   final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
  //   List<dynamic> data = jsonDecode(response.body.toString());
  //   if(response.statusCode == 200){
  //     for(Map<String,dynamic> index in data){
  //       productmodel.add(ProductModel.fromJson(index));
  //     }
  //     return productmodel;
  //   }else{
  //     return productmodel;
  //   }
  // }
}




// child: FutureBuilder(
//               future: getData(),
//               builder: (context,snapshot) {
//                 if(snapshot.hasData){
//                   final products = snapshot.data!;
//                   return GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, // Display two products per row
//                       crossAxisSpacing: 5,
//                       mainAxisSpacing: 5,
//                       childAspectRatio: 0.7,
//                        // Aspect ratio for better layout
//                     ),
//                     scrollDirection: Axis.vertical,
//                     itemCount: 3,
//                     itemBuilder: (context,index){
//                       final product = products[index];
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: (){
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => ProductDetailsScreen(product: product),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               margin: EdgeInsets.only(top: 20,left: 10,right: 10,),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [BoxShadow(
//                                   color: Colors.grey.shade400,
//                                   blurRadius: 10,
//                                 )]
//                               ),
//                               height: 300,
//                               width: double.infinity,
//                               // padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
//                               // margin: EdgeInsets.all(20),

//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: 10,),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           width: 50,
//                                           height: 25,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10),
//                                             color: Colors.blue.shade300
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             children: [
//                                               Icon(Icons.star,color: Colors.yellow,size: 20,),
//                                               Text("${snapshot.data![index].rating!.rate}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
//                                             ],
//                                           ),
//                                         ),
//                                         Icon(Icons.favorite_border,color: Colors.black,),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 10,),
//                                   Expanded(
//                                     child: Container(
//                                       child: Image.network('${snapshot.data![index].image}',
//                                         fit: BoxFit.fill, // Image fit inside the card
//                                         width: double.infinity,

//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 10,),
//                                   Text("${productmodel[index].title}",style: TextStyle(fontSize: 12),),
//                                   SizedBox(height: 10,),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(" \$ ${productmodel[index].price}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
//                                       Container(
//                                         width: 70,
//                                         height: 30,
//                                         decoration: BoxDecoration(
//                                           color: Colors.orange,
//                                           borderRadius: BorderRadius.circular(10)
//                                         ),
//                                         child: Center(child: Text("Add cart")),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }
//                   );
//                 }
//                 else{
//                 return Center(child: CircularProgressIndicator(),);
//                 }
//               }
//             ),
