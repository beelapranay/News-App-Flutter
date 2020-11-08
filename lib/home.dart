import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/newsmodel.dart';
import 'content/news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<NewsModel> newsList = new List<NewsModel>();
  bool isLoading = true;
  getData() async{
    News newsobj = News();
    await newsobj.getData();
    newsList = newsobj.news;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ):
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Text("News",style: TextStyle(color: Colors.black)),
            Text("API.org",style: TextStyle(color: Colors.blue),)
          ],
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: newsList.length,
            itemBuilder: (context, index){
            return NewsTile(
              title: newsList[index].title,
              url: newsList[index].url,
              description: newsList[index].description,
              imgurl: newsList[index].urlToImage,
            );
            }
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {

  String title,description,url,imgurl;
  NewsTile({@required this.title,@required this.url,@required this.description,@required this.imgurl});

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Container(
            child: Image.network(imgurl),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(description),
            ),
            SizedBox(height: 5,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Text(url,style: TextStyle(color: Colors.blue)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  height: 2)
              ],),
            ),
          ],
        ),
      );
  }
}

