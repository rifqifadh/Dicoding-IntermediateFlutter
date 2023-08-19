import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:story_app/data/model/story_model.dart';
import 'package:story_app/widget/map_widget.dart';

class StoryScreen extends StatefulWidget {
  final Story? story;

  const StoryScreen({super.key, required this.story});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Story")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: widget.story!.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "created by: ${widget.story?.name}",
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.story?.description ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 16,
              ),
              if (widget.story?.lat != null && widget.story?.lon != null) ...[
              const Text("Posting from:"),
              SizedBox(
                height: 280,
                child: StoryMapWidget(position: LatLng(widget.story!.lat!.toDouble(), widget.story!.lon!.toDouble())),
              )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
