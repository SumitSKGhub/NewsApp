import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  String SourceName;
  String Author;
  String Title;
  String Description;
  String Url;
  String ImageLink;
  String Time;
  String Content;
  DetailsScreen(
      {super.key,
      required this.SourceName,
      required this.Author,
      required this.Title,
      required this.Description,
      required this.Url,
      required this.ImageLink,
      required this.Time,
      required this.Content});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<void> launch(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text("News Details"),
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Container(
                  alignment: Alignment.center,
                  child: Column(children: [
                    Image.network(
                      widget.ImageLink,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context,error,stackTrace){
                        return Image.network(
                          'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                          fit: BoxFit.fitHeight,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.Description,
                        style: TextStyle(fontWeight: FontWeight.w200),
                        // textAlign: TextAlign.center,
                      ),
                    )
                  ]))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // left align
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 3.0),
                child: Text( widget.Time,
                    style: TextStyle(fontWeight: FontWeight.w300)),
              ),
              widget.Title != 'NULL' ?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.Title,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              )
                  : Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Text(
                  "[Removed]",
                  textAlign: TextAlign.left,
                ),
              ),

              widget.Content != 'NULL' ?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.Content,
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 16)),
              )
                  : Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Text(
                  "[Removed]",
                  textAlign: TextAlign.left,
                ),
              ),

              widget.Url != 'NULL'  ? widget.Url ! != 'https://removed.com' ?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    const Text("For more: "),
                    InkWell(
                        onTap: () async {
                          await launchUrl(Uri.parse(widget.Url));
                        },
                        child: Text(
                          widget.Url,
                          style: TextStyle(color: Colors.blueAccent),
                        ))
                  ],
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Text(
                  "For more: NA",
                  textAlign: TextAlign.left,
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Text(
                  "For more: NA",
                  textAlign: TextAlign.left,
                ),
              ),

              widget.SourceName != 'NULL' ?
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Text(
                  "Source: " + widget.SourceName,
                  textAlign: TextAlign.left,
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Text(
                  "Source: NA",
                  textAlign: TextAlign.left,
                ),
              ),

              widget.Author != 'NULL'
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                      child: Text(
                        "Author: " + widget.Author,
                        textAlign: TextAlign.left,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                      child: Text(
                        "Author: NA",
                        textAlign: TextAlign.left,
                      ),
                    ),
            ],
          ),
        ]),
      ),
    );
  }
}
