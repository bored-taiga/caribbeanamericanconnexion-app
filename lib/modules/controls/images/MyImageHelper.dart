import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyImage {
  // Old way -> crash
  // //widget.city.featuredImamge != null ? Image.network(widget.city.featuredImamge).image : AssetImage('assets/photos/paris.jpg')
  // New way
  static Widget from(String url, {BorderRadius borderRadius, Color color}) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: url ?? "",
      placeholder: (context, url) => Container(
        alignment: Alignment.center,
        child: Container(
          width: 20,
          height: 20,
          child: CircularProgressIndicator()
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover
        ),
        color: color,
        borderRadius: borderRadius
    ),
  ),
    );
  }
}