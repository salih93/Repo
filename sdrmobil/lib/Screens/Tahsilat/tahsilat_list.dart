import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Tahsilat/tahsilat_list_card.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
import 'package:sdrmobil/models/Tahsilat/tahsilat.dart';


class TahsilatList extends StatelessWidget {
  const TahsilatList({Key key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TahsilatController _controller = Get.put(TahsilatController());
    

  return Background(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(          
              height: size.height * 0.85,
              width: size.width * 0.96,
              child: FutureBuilder<List<Tahsilat>>(
                
                future: _controller.getAllTahsilat(),
                builder: (BuildContext context, AsyncSnapshot<List<Tahsilat>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Tahsilat tahsilat;
                        tahsilat = snapshot.data[index];

                        return Container(                                                                
                              child: TahsilatListCard(tahsilat: tahsilat),
                        );
                                                    
                      },
                    );

                  } else if (snapshot.hasError) {
                    return Text('Error');
                  } else {
                    //return Text('');
                    return Center(child:CircularProgressIndicator(color: Color(0xff009068),),);
                  }
                },                
              ),
            ),
          ),
        ],
                  
      ),
    );

  }
}
