// TODO add dependencies
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson(Post post) {
  return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
      };
    }
}

Future<List<Post>> fetchPosts() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List).map((i) => Post.fromJson(i)).toList();
  }
  throw Exception('Failed to load posts');
}
