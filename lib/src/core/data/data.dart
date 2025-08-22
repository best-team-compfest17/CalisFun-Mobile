import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import 'package:calisfun/src/core/domain/domain.dart';
import 'package:calisfun/src/network/network.dart';
import 'package:calisfun/src/shared/shared.dart';

part 'user_repository.dart';
part 'reading_repository.dart';
part 'writing_repository.dart';
part 'modifier/user_converter.dart';
part 'modifier/child_converter.dart';
part 'modifier/progress_converter.dart';
part 'modifier/reading_question_converter.dart';
part 'modifier/writing_question_converter.dart';