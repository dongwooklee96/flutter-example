// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reactions _$ReactionsFromJson(Map<String, dynamic> json) => Reactions(
  likes: (json['likes'] as num).toInt(),
  dislikes: (json['dislikes'] as num).toInt(),
);

Map<String, dynamic> _$ReactionsToJson(Reactions instance) => <String, dynamic>{
  'likes': instance.likes,
  'dislikes': instance.dislikes,
};

Post _$PostFromJson(Map<String, dynamic> json) => Post(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  body: json['body'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  reactions: Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
  views: (json['views'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'tags': instance.tags,
  'reactions': instance.reactions,
  'views': instance.views,
  'userId': instance.userId,
};

PostsResponse _$PostsResponseFromJson(Map<String, dynamic> json) =>
    PostsResponse(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      skip: (json['skip'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$PostsResponseToJson(PostsResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };
