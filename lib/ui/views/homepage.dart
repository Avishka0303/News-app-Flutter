import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/apis/api_manager.dart';
import 'package:news_app/core/models/newsinfo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = API_Manager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News app"),
        ),
        body: Container(
            child: FutureBuilder<NewsModel>(
                future: _newsModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //check the data is available or not
                    return ListView.builder(
                        itemCount: snapshot.data.articles.length,
                        itemBuilder: (context, index) {
                          var article = snapshot.data.articles[index];
                          return Container(
                            margin: EdgeInsets.all(3),
                            height: 100,
                            child: Row(
                              children: <Widget>[
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                        article.urlToImage,
                                        fit: BoxFit.cover
                                    )
                                  ),
                                ),
                                //SizedBox(width: 200),
                                Flexible(child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          article.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      ),
                                      Text(article.description,
                                          overflow: TextOverflow.ellipsis
                                      ),
                                  ],
                                ))

                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(
                        child:
                            CircularProgressIndicator()); //return circular progress indicator
                  }
                })));
  }
}
