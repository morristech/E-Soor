import 'package:flutter/material.dart';
class Settings extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Settings"),
            ),
            body:ListView(
              children:<Widget>[
                Column(
                children: <Widget>[
                  Container(
                    child: ListTile(
                       title: Text("Account Settings", style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    ),
                  ),

                  ///Username

                  Container(
                    decoration: BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         color: Colors.grey[600],
                         width: 0.5
                       )
                     ),
                     color: Colors.grey[900],
                    ),
                    child:ListTile(
                      title: Text("Username"),
                      onTap: (){},
                    )
                  ),

                  //Phone Number

                Container(
                  decoration: BoxDecoration(
                   border: Border(
                    bottom: BorderSide(
                         color: Colors.grey[600],
                         width: 0.5
                       )
                   ),
                  color: Colors.grey[900],
                  ),
                  child: ListTile(
                    title: Text("Phone "),
                    onTap: (){},
                  ),
                ),

                 ///E-mail address


                Container(
                    decoration: BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         color: Colors.grey[600],
                         width: 0.5
                       )
                     ),
                     color: Colors.grey[900],
                    ),
                  color: Colors.grey[900],
                  child: ListTile(
                     title: Text("Email address"),
                     onTap: (){},
                  ),
                ),

                 ///Password 


                Container(
                    decoration: BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         color: Colors.grey[600],
                         width: 0.5
                       )
                     ),
                     color: Colors.grey[900],
                    ),
                  color: Colors.grey[900],
                  child: ListTile(
                    title: Text( "Password"),
                    onTap: (){},
                  ),
                ),

                 ///Deactivate Account

                Container(
                    decoration: BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         color: Colors.grey[600],
                         width: 0.5
                       )
                     ),
                     color: Colors.grey[900],
                    ),
                  color: Colors.grey[900],
                  child: ListTile(
                    title: Text( "Deactivate your acccount"),
                    onTap: (){},
                  ),
                )
                ]
              )
              ]
            )
        );
    }
}