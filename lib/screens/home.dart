import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/screens/Details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> news = [];



  String srcName = '';
  String author = '';
  String TITLE = '';
  String DESCR = '';
  String URL = '';
  String image = '';
  String TIME = '';
  String CONTENT = '';

  void getNews(String url) async {

    final apiKey = 'Your_Api_Key';
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    print("Fetching!");

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (body.containsKey('articles') && body['articles'] is List) {
        news = body['articles'];
        print("Fetching complete! Response: $news");
      } else {
        print("Unexpected JSON structure: $body");
      }
    }

    setState(() {});
  }

  @override
  initState() {
    super.initState();


    Future.delayed(Duration(seconds: 1), () {
      getNews(url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  'NewsApp',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Times new roman',
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.auto_awesome),
              title: Text("App created by Sumit Kamble"),

            )

          ],),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text("NewsApp"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
          ),
          elevation: 0,
          // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          // backgroundColor: ThemeData(primaryColor: rever),
        ),
        backgroundColor: Colors.blue[50],
        body: Column(
          children: [
            Container(
              color: Colors.blue[50],
              padding: EdgeInsets.all(18.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top Headlines for You!🔥",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                    // textAlign: TextAlign.left,
                  )),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    final newsBlock = news[index];
                    final title = newsBlock['title'];
                    // final imageLink = newsBlock['url']; //!!! A mistake to be remembered !
                    final imageLink = newsBlock['urlToImage'];
                    final time = newsBlock['publishedAt'];
                    final src = newsBlock['source']['name'];
                    if (title == '[Removed]') {
                      return SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Divider(
                            color: Colors.blue[800],
                            thickness: 1,
                          ),
                          ListTile(
                            tileColor:Colors.blue[50],
                            leading: imageLink != null && imageLink is String
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      imageLink,
                                      fit: BoxFit.fitHeight,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.network(
                                          'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                                          fit: BoxFit.fitHeight,
                                        );
                                      },
                                    ))
                                : Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                                      fit: BoxFit.fitHeight,
                                    )),
                            title: Text(
                              title,
                              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),
                            ),
                            subtitle: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:8,bottom:8,),
                                    child: Text("- "+src),
                                  ),
                                  Text(time),
                                ],
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            onTap: () {
                              setState(() {
                                print('Title: ' + title);
                                title != null ? TITLE = title : TITLE = 'NULL';
                                imageLink != null && imageLink is String
                                    ? image = imageLink
                                    : image =
                                        "https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";
                                time != null ? TIME = time : TIME = 'NULL';
                                srcName = newsBlock['source']['name'];
                                newsBlock['author'] != null
                                    ? author = newsBlock['author']
                                    : author = 'NULL';
                                newsBlock['description'] != null
                                    ? DESCR = newsBlock['description']
                                    : DESCR = 'NULL';
                                newsBlock['url'] != null
                                    ? URL = newsBlock['url']
                                    : URL = 'NULL';
                                newsBlock['content'] != null
                                    ? CONTENT = newsBlock['content']
                                    : CONTENT = 'NULL';
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                            SourceName: srcName,
                                            Author: author,
                                            ImageLink: image,
                                            Title: TITLE,
                                            Description: DESCR,
                                            Url: URL,
                                            Time: TIME,
                                            Content: CONTENT,
                                          )
                                  )
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }),

            ),

          ],
        )
    );
  }
}
