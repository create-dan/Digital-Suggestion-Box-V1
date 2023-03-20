import 'package:cloud_firestore/cloud_firestore.dart';

enum SuggestionStatus {
  pending,
  approved,
  rejected,
}

extension SuggestionStatusExtension on SuggestionStatus {
  static SuggestionStatus? fromString(String? value) {
    if (value == null) return null;

    switch (value) {
      case 'pending':
        return SuggestionStatus.pending;
      case 'approved':
        return SuggestionStatus.approved;
      case 'rejected':
        return SuggestionStatus.rejected;
      default:
        return null;
    }
  }

  String toShortString() {
    return this.toString().split('.').last;
  }
}

class SuggestionModel {
  final String username;
  final bool isAnonymous;
  final bool isAdmin;
  final String description;
  final List<String> tags;
  late final String imageUrl;
  final String ownerUid;
  final Timestamp createdAt;
  final String title;
  final String uid;
  final int upvotes;
  final String approvedMessage;
  // SuggestionStatus status;
  final String status;
  SuggestionModel(
      {this.username = "Test User",
      this.isAdmin = false,
      this.status = "pending",
      required this.uid,
      required this.isAnonymous,
      required this.description,
      required this.tags,
      required this.imageUrl,
      required this.ownerUid,
      required this.createdAt,
      required this.title,
      required this.upvotes,
      this.approvedMessage = ""});

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      title: json['title'],
      approvedMessage: json['approvedMessage'],
      username: json['username'],
      isAdmin: json['isAdmin'],
      status: json['status'],
      isAnonymous: json['is_anonymous'],
      description: json['description'],
      tags: List<String>.from(json['tags']),
      imageUrl: json['imageUrl'],
      ownerUid: json['ownerUid'],
      createdAt: json['createdAt'],
      uid: json['uid'],
      upvotes: json['upvotes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'is_anonymous': isAnonymous,
        'username': username,
        'approvedMessage': approvedMessage,
        'isAdmin': isAdmin,
        'status': status,
        'description': description,
        'tags': tags,
        'imageUrl': imageUrl,
        'ownerUid': ownerUid,
        'createdAt': createdAt,
        'title': title,
        'uid': uid,
        'upvotes': upvotes,
      };

  factory SuggestionModel.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    String id = snapshot.id;
    // String createdAt = (data['createdAt'] as Timestamp).toDate() as String;

    return SuggestionModel(
        username: data['username'],
        isAdmin: data['isAdmin'],
        status: data['status'],
        approvedMessage: data['approvedMessage'],
        ownerUid: data['ownerUid'],
        title: data['title'],
        description: data['description'],
        imageUrl: data['imageUrl'],
        createdAt: data['createdAt'],
        upvotes: data['upvotes'],
        isAnonymous: false,
        tags: [],
        uid: data['uid']);
  }
}
