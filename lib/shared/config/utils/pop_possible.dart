import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

canPopThenPop(BuildContext context) {
  if (context.canPop()) context.pop();
}
