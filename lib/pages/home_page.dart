import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/articledetails.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/article.dart';
import 'consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio dio = Dio();
  List<Article> articles = [];
  

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailPage(article: article),
              ),
            );
          },
          leading: Image.network(
            article.urlToImage ?? PLACEHOLDER_IMAGE_LINK,
            height: 250,
            width: 100,
            fit: BoxFit.cover,
          ),
          title: Text(article.title ?? ""),
          subtitle: Text(article.publishedAt ?? ""),
        );
      },
    );
  }

  Future<void> _getNews() async {
    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$NEWS_API_KEY',
    );
    final articlesJson = response.data["articles"] as List;
    setState(() {
      articles = articlesJson
          .map((a) => Article.fromJson(a))
          .where((a) => a.title != "[Removed]")
          .toList();
    });
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
