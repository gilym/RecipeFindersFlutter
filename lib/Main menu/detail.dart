import 'package:flutter/material.dart';
import 'package:recipefinders/function/addFavorite.dart';
import 'package:recipefinders/function/deleteFavorite.dart';
import 'package:recipefinders/main.dart';

import 'dashboard.dart';

class detailpage extends StatefulWidget {
  final Map<String,dynamic> data;
  final int id;
  final String token;
  final List<dynamic> Fav;
  const detailpage({Key? key , required this.data, required this.id,required this.token,required this.Fav}) : super(key: key);

  @override
  State<detailpage> createState() => _detailpageState();
}

class _detailpageState extends State<detailpage> {
 late bool _isFavorite ;
 late int favid;
 late int matchingFavoritesId;
  @override
  void initState() {
   _isFavorite = widget.Fav.any((favItem) => favItem['id'] == widget.data['id']);

   bool foundMatch = false; // Flag to indicate if a match is found

   for (var favItem in widget.Fav) {
     if (widget.data['id'] == favItem['id']) {
       matchingFavoritesId = favItem['favorite_id'];
       foundMatch = true; // Set the flag to true when a match is found
       break; // Exit the loop when a match is found
     }
   }

   if (!foundMatch) {
     matchingFavoritesId = 0; // Set the default value when no match is found
   }


// Cek apakah matchingFavoritesId ada nilainya, jika iya, maka cetak nilainya
    if (matchingFavoritesId != null) {
      print("Matching favorites_id: $matchingFavoritesId");
    } else {
      print("Tidak ada elemen dalam Fav yang sesuai dengan data");
    }

   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> ingredientList = widget.data['ingredients'].split(", ");
    int columnCount = (ingredientList.length / 2).ceil();
    return Scaffold(
      backgroundColor: Background,
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Stack(
            children: [
              Container(
                height:350,
                color: Background,
              ),
              Container(
                height:220,
                color: button,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height/8,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.data['img']),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                  right: 20,
                  child:
                      InkWell(
                        onTap: (){
                          setState(() {


                            if(_isFavorite){
                              _deleteFav();
                            }
                            else{
                              _addFav(widget.id,widget.data['id']);
                            }

                          });
                        },
                        child: _isFavorite?  Icon(Icons.favorite,
                          size: 40,):Icon(Icons.favorite_border_outlined,
                          size: 40,)
                      )

                 )
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Text(widget.data['name'],
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width/1.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Category",
                    style: TextStyle(
                      fontSize: 20
                    ),),
                    Row(
                      children: [
                        Text('• ' , style: TextStyle(
                            fontSize: 25,
                        ),),
                        Text(widget.data['kategori'],style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600]
                        ),)
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text("Nutrition",
                      style: TextStyle(
                          fontSize: 20
                      ),),
                    Row(

                      children: [
                        Row(
                          children: [
                            Text('• ' , style: TextStyle(
                              fontSize: 25,
                            ),),
                            Text("Calories : "+widget.data['kkal']+ " kcal",style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600]
                            ),)
                          ],
                        ),
                        SizedBox(width: 45,),
                        Row(
                          children: [
                            Text('• ' , style: TextStyle(
                              fontSize: 25,
                            ),),
                            Text("Protein : "+widget.data['protein']+ " g",style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600]
                            ),)
                          ],
                        ),
                      ],
                    ),
                    Row(

                      children: [
                        Row(
                          children: [
                            Text('• ' , style: TextStyle(
                              fontSize: 25,
                            ),),
                            Text("Carbohydrates : "+widget.data['karbohidrat']+ " g",style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600]
                            ),)
                          ],
                        ),
                        SizedBox(width: 20,),
                        Row(
                          children: [
                            Text('• ' , style: TextStyle(
                              fontSize: 25,
                            ),),
                            Text("Fat : "+widget.data['lemak']+ " g",style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600]
                            ),)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text("Ingredients",
                      style: TextStyle(
                          fontSize: 20
                      ),),
                    GridView.count(
                      padding: EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio:6,
                      children: ingredientList.map((name) {
                        return Row(
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(width: 5),
                            Text(
                              name,
                              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                            ),
                          ],
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 15,),
                    Text("Description",
                      style: TextStyle(
                          fontSize: 20
                      ),),
                    SizedBox(height: 10,),
                    Text(widget.data['description']),
                    SizedBox(height: 50,)
                  ],
                ),
              )
            ],
          )



        ],
      ),

    );
  }
  Future<void> _addFav(int user_id , int food_id) async {

    String token = widget.token;
    int id = widget.id;


    addFavResponse favResponse = await addFavService.login(user_id,food_id,token);
    String message = favResponse.message;

    // Lakukan sesuatu dengan nilai message, data, dan token
    // ...

    if (message == 'Data inserted successfully') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(
            fontSize: 18
        ),),
          backgroundColor: button,),
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => dashboardpage()), (route) => false);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(
            fontSize: 18
        ),),
          backgroundColor: button,),
      );
    }
  }
 Future<void> _deleteFav() async {

   String token = widget.token;



   deleteFavResponse deletefavResponse = await deleteFavService.login(matchingFavoritesId,token);
   String message = deletefavResponse.message;

   // Lakukan sesuatu dengan nilai message, data, dan token
   // ...

   if (message == 'Delete successful') {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(message,style: TextStyle(
           fontSize: 18
       ),),
         backgroundColor: button,),
     );
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => dashboardpage()), (route) => false);

   } else {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(message,style: TextStyle(
           fontSize: 18
       ),),
         backgroundColor: button,),
     );
   }
 }
}
