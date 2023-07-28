import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:headlines/explorenews.dart';
import 'article_model.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Article> listArticle = [];

  @override
  void initState() {
    fetchArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff464646),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff000000),
          centerTitle: true,
          title: const Text(
            "HEADLINES",
            style: TextStyle(
              fontSize: 29,
              color: Color(0xffffffff),
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: listArticle.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(listArticle[index].urlToImage),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExploreNews(
                        article: listArticle[index],
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listArticle[index].title,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xfff2f2f2),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listArticle[index].source['name'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xffbababa),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                listArticle[index].publishedAt.split("T").first,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xffbababa),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Future<void> fetchArticle() async {
    String apiKey = "21e1ced1d5974e86a8c7418105a2978c";
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey";
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body.toString());
      setState(() {
        listArticle = List.from(data['articles'])
            .map((e) => Article.fromJson(e))
            .toList();
      });
    }
  }
}
