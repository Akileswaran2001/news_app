import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Details"),
        leading: IconButton(
        icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),  
        onPressed: () => Navigator.pop(context),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.urlToImage != null)
                Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16.0),
              Text(
                article.title ?? "No Title",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              Text(
                article.publishedAt ?? "No Date",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16.0),
              Text(
                article.description ?? "No Description",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16.0),
              Text(
                article.content ??
                    "No Content Available",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
               const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  Uri url = Uri.parse(article.url!);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch ${article.url}';
                  }
                },
                child: const Text("Read Full Article"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
