import 'package:flutter/material.dart';

class Design extends StatelessWidget {
  const Design({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,          
          children: [
            Container(              
              padding: EdgeInsets.only(top:10,bottom: 10),                            
              child : Text("LAB # 3",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),                            
            ),
            Container(              
              width: double.infinity,
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 80,vertical: 20),              
              decoration: BoxDecoration(  
                color: Colors.red,              
                borderRadius: BorderRadius.circular(20), 
              ),
              child : Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                height: double.infinity,                
                decoration: BoxDecoration(
                  color: Colors.blue,                  
                  borderRadius: BorderRadius.circular(20), 
                ),
                child : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                  'images/box-8.jpg',                            
                  fit: BoxFit.cover,
                  ),                  
                )
              )
            ),
            Container(
              padding : EdgeInsets.all(20),
              width: double.infinity, 
              height: double.infinity,
              child: Stack(              
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                    ),
                  ),
                  Positioned(
                    top: 0, 
                    left: 50,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.green,
                    ),
                  ),
                  Positioned(
                    top: 25, 
                    left: 70,
                    child: Container(      
                      alignment: Alignment.center,
                      width: 50,
                      height: 200,
                      color: Colors.pink,                      
                      child : Text("1\n2\n3\n4\n5\n6\n7\n8\n9", style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  )
                ]
              )
            ),
            Text("Practice makes a man perfect thats why we should practice it more often",textAlign: TextAlign.center,),
            Container(
              width: double.infinity,
              padding : EdgeInsets.all(20),              
              color : Colors.lightGreen,
              child : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,                          
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("LEADING",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                  ClipRRect(                    
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(                      
                      'images/box-8.jpg',                    
                      width: 60,
                      height: 60,        
                      fit: BoxFit.cover,
                    )
                  ),
                  Text("TRAILING",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}