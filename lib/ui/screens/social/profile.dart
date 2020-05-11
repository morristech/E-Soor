import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

////This is the main class that holds all of the main profile components
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        /// the container that holds the profile name, bio and picture
         Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                   ProfilePicture(),
                   ProfileName(),
                   ProfileBio(),
                   FlatButton(
                     color: Colors.grey[900],
                     onPressed: (){},
                     child:Padding( 
                     padding: EdgeInsets.symmetric(horizontal:130, vertical:5),  
                     child:Text("Edit Profile"), 
                   )
                )
             ],
         ),
         /// the container that holds the book highlights list view
         Container(
           child: BookHighlightsList()
         ),
      ],
    )]);
  }
}

/////Profile picture class

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return 
        Padding(
        padding:EdgeInsets.all(5),
        child:CircleAvatar(
        radius: 70,
            backgroundImage: NetworkImage("")
     )
    );
  }
}


////Profile name class

class ProfileName extends StatefulWidget {
  final String profile_name;
  ProfileName({Key key, this.profile_name}) : super(key: key);

  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
     padding:EdgeInsets.all(5),
     child:AutoSizeText(
     "Omar Hany Hassan",
      maxLines: 1,
      overflow: TextOverflow.ellipsis ,
      style: TextStyle(
        fontSize: 30, 
        fontWeight: FontWeight.bold,
      ),
     )
    ); 
  }
}

////Profile Bio class

class ProfileBio extends StatefulWidget {

  final String profile_bio;
  ProfileBio({Key key, this.profile_bio}) : super(key: key);

  @override
  _ProfileBioState createState() => _ProfileBioState();
}

class _ProfileBioState extends State<ProfileBio> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), 
      child: Text(
      'I am in love with reading i like it so much and hope to become a writer one day at my lifge is so. I love my cousins and computer science in MIT is very fantasting and luxury and i love harvard alot. ',
     )
    );
  }
}

///book highlights List View

class BookHighlightsList extends StatefulWidget {
  @override
  _BookHighlightsListState createState() => _BookHighlightsListState();
}

class _BookHighlightsListState extends State<BookHighlightsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        addAutomaticKeepAlives: false,
        reverse: true,
        shrinkWrap: true,
        children: <Widget>[
          ///these are the card children of the ListView
          ///The user should be able to add cards to this ListView 
          ///These Cards represents some book reviews 
          Card(
              child: Container(
                  height: 250,
                  width: 150,
                  child: Card(
                      margin:EdgeInsets.symmetric(vertical: 15, horizontal: 3.5),
                      child: Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.library_books,
                                size: 35,
                              ),
                            onPressed: () { /* by clicking on this users are able to add book reviews */ },
                            ),
                            Text(
                              'Add Book Highlight',
                               style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                )
              )
            )
          ),
        ],
      ),
    );
  }
}
