// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:login1/Model/ProductModel';
// import 'package:login1/Screens/product_detail_page.dart';

// class ProductListPage extends StatefulWidget {
//   @override
//   _ProductListPageState createState() => _ProductListPageState();
// }

// class _ProductListPageState extends State<ProductListPage> {
//   late Future<List<ProductModel>> _products;
//   List<ProductModel> productmodel = [];

//   @override
//   void initState() {
//     super.initState();
//     _products = getData();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Products",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
//         backgroundColor: Colors.blue.shade200,
//         centerTitle: true,
//       ),
//       backgroundColor: Colors.white,
//       body: Container(
//         margin: EdgeInsets.only(top: 10,left: 20,right: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//           SizedBox(height: 20,),
//           Expanded(
//             child: FutureBuilder(
//               future: getData(),
//               builder: (context,snapshot) {
//                 if(snapshot.hasData){
//                   final products = snapshot.data!;
//                   return GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3, // Display two products per row
//                       crossAxisSpacing: 5,
//                       mainAxisSpacing: 5,
//                       childAspectRatio: 0.7,
//                        // Aspect ratio for better layout
//                     ),
//                     scrollDirection: Axis.vertical,
//                     itemCount: productmodel.length,
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
//                               margin: EdgeInsets.only(top: 5,left: 5,right: 5,),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [BoxShadow(
//                                   color: Colors.grey.shade300,
//                                   blurRadius: 10,
//                                 )]
//                               ),
//                               height: 200,
//                               width: double.infinity,
//                               // padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
//                               // margin: EdgeInsets.all(20),
                              
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: 5,),
//                                   Expanded(
//                                     child: Container(
//                                       child: Image.network('${snapshot.data![index].image}',
//                                         fit: BoxFit.fill, // Image fit inside the card
//                                         width: double.infinity,
                                        
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 5,),
//                                   Text("${productmodel[index].title}",style: TextStyle(fontSize: 8),),
//                                   SizedBox(height: 5,),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(" \$ ${productmodel[index].price}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
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
//           ),
//         ],),
//       ),
//     );
//   }
//   Future<List<ProductModel>> getData() async{
//     final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
//     List<dynamic> data = jsonDecode(response.body.toString());
//     if(response.statusCode == 200){
//       for(Map<String,dynamic> index in data){
//         productmodel.add(ProductModel.fromJson(index));
//       }
//       return productmodel;
//     }else{
//       return productmodel;
//     }
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login1/Screens/product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<dynamic> products = [];
  bool isLoading = true;

  // Fetch product data from fake API
  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      setState(() {
        products = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      // Handle API error
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        elevation: 8,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader while fetching data
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Display two products per row
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.68, // Aspect ratio for better layout
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(Product: product);
          },
        ),
      ),
    );
  }
}

// Separate widget for Product Card design
class ProductCard extends StatelessWidget {
  final dynamic Product;

  const ProductCard({Key? key, required this.Product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // Rounded image corners
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  Product['image'],
                  height: 80,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 5,),
                Text(Product['title'],style: TextStyle(fontSize: 10),maxLines: 2,),
                SizedBox(height: 5,),
                Text('\$ ${Product['price']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green),),

                // Text('${Product.price}'),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

