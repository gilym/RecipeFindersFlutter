import 'package:flutter/material.dart';
import 'package:recipefinders/Main%20menu/Camera.dart';
import 'package:recipefinders/Main%20menu/detail.dart';
import 'package:recipefinders/Main%20menu/profile.dart';
import 'package:recipefinders/function/foodservice.dart';
import 'package:recipefinders/function/getFavorite.dart';
import 'package:recipefinders/function/getuser.dart';
import 'package:recipefinders/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login/login.dart';
class dashboardpage extends StatefulWidget {
  const dashboardpage({Key? key}) : super(key: key);

  @override
  State<dashboardpage> createState() => _dashboardpageState();
}

class _dashboardpageState extends State<dashboardpage> {
  late SharedPreferences _prefs;
  late String name ;
  late String img ;
  late List<dynamic> food;
  late List<dynamic> Fav;
   Map<String, dynamic>? user ;
  late String token='';
  late String email='';
  late int id;


  loadUsername() async {
    food=[];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefs = prefs;
      token = prefs.getString('token') ?? '';
      id = prefs.getInt('id')! ;

    });


  }

  @override
  void initState() {

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });

    loadUsername().then((_) {
      if (token.isNotEmpty) {
        getFood.fetchfood(token).then((data) {
          setState(() {

            food = data;

          });
        }).catchError((error) {
          print(error);
        });

        getUser.fetchuser(token, id).then((data) {
          setState(() {
            user = data;
          });

          // Pemanggilan getFav.fetchFav akan dilakukan setelah getUser selesai
          getFav.fetchFav(token, user!['id']).then((favData) {
            setState(() {
              Fav = favData;
            });


          }).catchError((error) {
            print("Error fetching favorites: $error");
          });
        }).catchError((error) {
          print("Error fetching user data: $error");
        });




      }
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return Scaffold(
        backgroundColor: Background,
        body: Column
          (
          children: [
            Container(
              height:MediaQuery.of(context).size.height/3 ,
              width: MediaQuery.of(context).size.width ,
              color: button,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    child: Row(
                      children: [
                        InkWell(
                          onTap : (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  profilepage(name: user!['name'], Favorite: Fav,img: user!['img'],email: user!['email'],id: id,token: token,),
                              ),
                            );

                          },
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(user!['img']),
                          ),
                        ),

                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, " + user!['name'],
                              style: TextStyle(
                                color: Background,
                                fontSize: 23,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Let’s find your food",
                              style: TextStyle(
                                color: Background,
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: TextFormField(

                      decoration: InputDecoration(

                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Set border color
                          borderRadius: BorderRadius.circular(20.0), // Set border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Set focused border color
                          borderRadius: BorderRadius.circular(25.0), // Set border radius
                        ),
                        suffixIcon: InkWell(
                          child: Icon(Icons.camera_alt_outlined,color: Colors.grey,size: 30 ,),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  CameraPage(id: id,token: token,Fav: Fav,),
                              ),
                            );
                          },
                        ),
                        prefixIcon: Icon(Icons.search,color: Colors.grey,size: 30),
                      ),
                    ),
                  )
                ],
              ),
            ),


            Expanded(
                child:Container(

                  child: ListView.builder(

                    itemCount: food.length,
                    itemBuilder: (context, index) {
                      final data = food[index];
                      List<String> ingredientList = data['ingredients'].split(", ");
                      int ingredientCount = ingredientList.length;
                      return Column(

                        children: [
                          InkWell(
                            onTap : (){

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  detailpage(data: data,id: id,token: token,Fav:Fav,),
                                ),
                              );

                            },
                            child:
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3), // atur posisi bayangan (x, y)
                                  ),
                                ],
                              ),
                              height: 300,
                              width:MediaQuery.of(context).size.width/1.1 ,
                              margin: EdgeInsets.only(bottom: 20),
                              child:
                              Column(
                                children: [
                                  Container(
                                    height:200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(data['img']!),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                  Container(
                                    width:MediaQuery.of(context).size.width/1.2,
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(data['name'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                  Container(
                                    width:MediaQuery.of(context).size.width/1.2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          alignment: Alignment.centerLeft,
                                          child: Text( ingredientCount.toString() +' ingredients',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey

                                            ),),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          alignment: Alignment.centerLeft,
                                          child: Text( data['kategori'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.bold

                                            ),),
                                        ),
                                      ],
                                    ),
                                  ),


                                ],

                              ),
                            )
                            ,
                          )
                        ],
                      );
                    },
                  ),

                )
            ),



          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Background,
        body: Center(
          child: CircularProgressIndicator(color: button,), // Menampilkan loading spinner
        ),
      );
    }


  }

}
