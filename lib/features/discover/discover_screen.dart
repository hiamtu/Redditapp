import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

var isPreview = StreamController<bool>();
String currentPreviewImgUrl = '';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  static const tiles = [
    GridTile(2, 3),
    GridTile(2, 1),
    GridTile(1, 2),
    GridTile(1, 1),
    GridTile(2, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(3, 1),
    GridTile(1, 2),
    GridTile(4, 1),
    GridTile(3, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(3, 1),
    GridTile(1, 3),
    GridTile(4, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 3,
        children: [
          ...tiles.map((tile) {
            int index = tiles.indexOf(tile);
            return StaggeredGridTile.count(
              crossAxisCellCount: tile.crossAxisCount,
              mainAxisCellCount: tile.mainAxisCount,
              child: ImageTile(
                index: index,
                width: tile.crossAxisCount * 100,
                height: tile.mainAxisCount * 100,
              ),
            );
          }),
        ],
      ),
    ));
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}

class ImageTile extends StatefulWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;

  @override
  State<ImageTile> createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  String generateText(int length) {
    var random = Random();
    var charCodes = List.generate(length, (_) => random.nextInt(26) + 97);
    return String.fromCharCodes(charCodes);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          'https://picsum.photos/${widget.width}/${widget.height}?random=${widget.index * Random().nextInt(200)}',
          width: widget.width.toDouble(),
          height: widget.height.toDouble(),
          fit: BoxFit.cover,
        ),
      ),
      Positioned(left: 15, top: 15, child: Text('r/${generateText(6)}'))
    ]);
  }
}
