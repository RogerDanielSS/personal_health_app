import 'package:flutter_dotenv/flutter_dotenv.dart';

String makeApiUrl(String path) => '${dotenv.env['API_URL']}/$path';
