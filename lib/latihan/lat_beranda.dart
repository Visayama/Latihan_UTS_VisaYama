import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:latihan_uts/latihan/bottom_menu.dart';
import 'package:latihan_uts/latihan/list_berita.dart';
import 'package:latihan_uts/latihan/register_api.dart';

class LatBeranda extends StatelessWidget {
  const LatBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Latihan Projek'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('gambar/img.png',
                fit: BoxFit.contain,
                height: 150,
                width: 150,
              ),
              SizedBox(height: 8,),
              // const Image(
              //   image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              //   fit: BoxFit.contain,
              //   height: 150,
              //   width: 150,
              // ),
              SizedBox(height: 10,),
              MaterialButton(onPressed: (){
                showToast('Pindah Ke Page Navigation Drawer',
                  context: context,
                  axis: Axis.horizontal,
                  alignment: Alignment.center,
                  position: StyledToastPosition.bottom,
                  toastHorizontalMargin: 20,
                  fullWidth: true,
                );
                //code untuk pindah pager
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => PageBottomNavigationBar()
                ));
              },

                child: Text('Page Navigation Utama',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                color: Colors.green,
                textColor: Colors.white,
              ),

              SizedBox(height: 8,),
              MaterialButton(onPressed: (){
                //code untuk pindah page
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => PageFormRegister()
                ));
              },
                  child: Text('Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),
                  ),
                  color: Colors.green,
                  textColor: Colors.white
              ),
              SizedBox(height: 8,),
              MaterialButton(onPressed: (){
                //code untuk pindah page
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => PageBerita()
                ));
              },
                  child: Text('List Berita',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),
                  ),
                  color: Colors.green,
                  textColor: Colors.white
              ),




            ],
          ),
        ) ,
      ),
    );
  }
}