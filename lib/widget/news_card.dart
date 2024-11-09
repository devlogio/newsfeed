import 'package:flutter/material.dart';
import 'package:newsfeed/model/news_article.dart';

import '../util/string_truncator.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle newsArticle;
  const NewsCard({super.key, required this.newsArticle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 8.0),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: 140,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 9.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  child: Image.network(
                    newsArticle.imageURL,
                    fit: BoxFit.cover,
                    width: 155.0,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Business'),
                      Expanded(
                        child: Text(
                          truncateWithEllipsis(67, newsArticle.title),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(truncateWithEllipsis(15, newsArticle.author)),
                          Text(newsArticle.publishedDate),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
