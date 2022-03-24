import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String? name;
  final String? bio;
  final String? description;
  final String? id;
  final int? quoteCount;
  final String? link;
  final String? dateAdded;
  final String? dateModified;
  final String? slug;

  const Post(
      {this.name,
      this.link,
      this.slug,
      this.description,
      this.bio,
      this.quoteCount,
      this.id,
      this.dateAdded,
      this.dateModified});

  @override
  List<Object?> get props => [
        name,
        description,
        bio,
        quoteCount,
        id,
        dateModified,
        description,
        dateAdded,
        link,
        slug
      ];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'slug': slug,
      'bio': bio,
      'description': description,
      '_id': id,
      'quoteCount': quoteCount,
      'dateAdded': dateAdded,
      'link': link,
      'dateModified': dateModified,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      name: map['name'] as String?,
      link: map['link'] as String?,
      slug: map['slug'] as String?,
      bio: map['bio'] as String?,
      description: map['description'] as String?,
      id: map['_id'] as String?,
      quoteCount: map['quoteCount'] as int?,
      dateAdded: map['dateAdded'] as String?,
      dateModified: map['dateModified'] as String?,
    );
  }
}
