import 'package:flutter/material.dart';
import 'package:newsfeed/data/articles.dart';
import 'package:newsfeed/model/news_article.dart';
import 'package:newsfeed/widget/carousel.dart';
import 'package:newsfeed/widget/news_card.dart';
import 'package:newsfeed/widget/news_topic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: const Text(
                  "Breaking News",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              const Carousel(),
              Container(
                margin: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                child: const Text(
                  "News by Topics",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 45.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _getTopics(),
                ),
              ),
              _getNewsTopicsList(breakingNews),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> _getTopics() {
  List<Widget> topics = [];
  List<String> newsTopics = newsArticles.keys.toList();

  topics.add(Container(
    margin: const EdgeInsets.only(left: 15.0),
    child: const NewsTopic(topic: 'All'),
  ));

  for (int i = 0; i < newsTopics.length - 1; i++) {
    topics.add(
      NewsTopic(
        topic: newsTopics[i],
      ),
    );
  }

  topics.add(Container(
    margin: const EdgeInsets.only(right: 15.0),
    child: NewsTopic(topic: newsTopics.last),
  ));

  return topics;
}

Widget _getNewsTopicsList(List<NewsArticle> newsArticles) {
  List<Widget> newsByTopic = [];

  for (var newsArticle in newsArticles) {
    newsByTopic.add(NewsCard(
      newsArticle: newsArticle,
    ));
  }

  return Column(children: newsByTopic);
}
