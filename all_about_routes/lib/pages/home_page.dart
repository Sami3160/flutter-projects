import 'package:all_about_routes/pages/page1.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
            },
            child: Text('Classic navigation'),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Page1()));
            },
            child: Text('Navigation of()'),
          ),
          SizedBox(height: 10,),ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/page2");
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
            },
            child: Text('Navigation named'),
          ),
          SizedBox(height: 10,),
          SizedBox(height: 10,),ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/page3");
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
            },
            child: Text('pass static data'),
          ),
          SizedBox(height: 10,),
          SizedBox(height: 10,),ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/page4",arguments: "page 4 dynamic data");
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
            },
            child: Text('pass dynamic data'),
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }
}