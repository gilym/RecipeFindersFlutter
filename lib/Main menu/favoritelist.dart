import 'package:flutter/material.dart';
import 'package:recipefinders/main.dart';

class favoriteList extends StatefulWidget {
  final List<dynamic> Favorite;
  const favoriteList({Key? key, required this.Favorite}) : super(key: key);



  @override
  State<favoriteList> createState() => _favoriteListState();
}

class _favoriteListState extends State<favoriteList> {

  @override
  void initState() {
    print(widget.Favorite.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background,
      appBar: AppBar(
        backgroundColor: Background,
        title: Text("Favorite"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child:Container(

                child: ListView.builder(

                  itemCount: widget.Favorite.length,
                  itemBuilder: (context, index) {
                    final data = widget.Favorite[index];
                    List<String> ingredientList = data['ingredients'].split(", ");
                    int ingredientCount = ingredientList.length;
                    return Column(

                      children: [
                        InkWell(
                          // onTap : (){
                          //
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>  detailpage(data: data,id: id,token: token,Fav:Fav,),
                          //     ),
                          //   );
                          //
                          // },
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
  }
}
