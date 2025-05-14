import 'package:equatable/equatable.dart';
import 'package:youtube_shorts/models/mux_asset.dart';

class Video extends Equatable {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final String muxId;
  final MuxAsset? muxAsset;

  const Video(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.muxId,
      this.muxAsset});

  @override
  List<Object?> get props =>
      [id, title, description, createdAt, muxId, muxAsset];

  Video copyWith(
      {String? id,
      String? title,
      String? description,
      String? createdAt,
      String? muxId,
      MuxAsset? muxAsset}) {
    return Video(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        muxId: muxId ?? this.muxId,
        muxAsset: muxAsset ?? this.muxAsset);
  }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['created_at'],
      muxId: json['muxId'],
    );
  }

  static List<Map<String, dynamic>> sampleVideos = [
    {
      "id": "1",
      "title": "Exploring the Mountains",
      "description": "A journey through the landscapes of the mountains.",
      "created_at": "2023-11-01",
      "muxId": "GSOIEUGK43jiORriJbzROYJt7L1P00vwDVblrrJQhxxw",
    },
    {
      "id": "2",
      "title": "Urban Adventures",
      "description": "Discover the hidden gems of city life.",
      "created_at": "2023-11-01",
      "muxId": "Ge3wOzsrkOvizfAWn01Cl01DYQ1Wbx6sVcga5E00gF3zR00",
    },
    {
      "id": "3",
      "title": "Ocean Wonders",
      "description": "Exploring the mysteries of the ocean.",
      "created_at": "2023-1-01",
      "muxId": "1eRi6mMVT88c4qANA02KLi7CX7h0289pZf1q0002mTHXl8U",
    },
    {
      "id": "4",
      "title": "Ocean Wonders",
      "description": "Exploring the mysteries of the ocean.",
      "created_at": "2023-1-01",
      "muxId": "Ufu4ogXlyb8lKmZCWFtF01x00VFkAQ00yp72WGyAaUWHpI",
    },
    {
      "id": "5",
      "title": "Ocean Wonders",
      "description": "Exploring the mysteries of the ocean.",
      "created_at": "2023-1-01",
      "muxId": "7vmgz3wVyHp009HisPaQ2FSbqXBxFKL01TSD9oZy7sPxg",
    },
  ];
}
