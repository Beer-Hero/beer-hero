import 'package:flutter/material.dart';

Color getTagColor(final String tag) {
  if (tagsColorMap.containsKey(tag)) {
    return tagsColorMap[tag];
  }

  return Colors.grey;
}

Map<String, Color> tagsColorMap = {
  'orange': Colors.orange,
  'summer': Colors.yellow,
};
