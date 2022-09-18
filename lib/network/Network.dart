import 'package:http/retry.dart';

import '../values/strings.dart';
import 'package:http/http.dart' as http;

var url = Uri.http(systemHost, systemUrl, {"news": "true"});
var c = http.Client();
var client = RetryClient(c);
