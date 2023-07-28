import 'package:flutter/material.dart';

import 'article_model.dart';

class ExploreNews extends StatefulWidget {
  const ExploreNews({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  State<ExploreNews> createState() => _ExploreNewsState();
}

class _ExploreNewsState extends State<ExploreNews> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          widget.article.urlToImage,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        widget.article.title,
                        style: const TextStyle(
                          fontSize: 29,
                          color: Color(0xfff2f2f2),
                        ),
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.article.source['name'],
                            style: const TextStyle(
                                fontSize: 20, color: Color(0xffbababa)),
                          ),
                          Text(
                            widget.article.publishedAt.split("T").first,
                            style: const TextStyle(
                                fontSize: 20, color: Color(0xffbababa)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        widget.article.description,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xffbababa)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
