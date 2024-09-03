import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class CookieManager {
  PersistCookieJar? _cookieJar;

  CookieManager() {
    if (!kIsWeb) {
      _cookieJar = PersistCookieJar();
    }
  }


Future<void> setCookie(String name, List<String> values, {String? domain, String? path, int? maxAge}) async {
  final value = jsonEncode(values); // Serialize list to JSON string
  if (kIsWeb) {
    final cookie = '$name=$value; path=${path ?? '/'}; max-age=${maxAge ?? 3600}';
    html.document.cookie = cookie;
  } else {
    final uri = Uri.parse(domain ?? 'https://example.com');
    final cookie = Cookie(name, value)
      ..path = path ?? '/'
      ..maxAge = maxAge;
    await _cookieJar?.saveFromResponse(uri, [cookie]);
  }
}

Future<List<String>?> getCookie(String name, {String? domain}) async {
  String? value;
  if (kIsWeb) {
    final cookies = html.document.cookie?.split('; ') ?? [];
    for (final cookie in cookies) {
      final parts = cookie.split('=');
      if (parts[0] == name) {
        value = parts[1];
        break;
      }
    }
  } else {
    final uri = Uri.parse(domain ?? 'https://example.com');
    final cookies = await _cookieJar?.loadForRequest(uri) ?? [];
    for (final cookie in cookies) {
      if (cookie.name == name) {
        value = cookie.value;
        break;
      }
    }
  }
  return value != null ? List<String>.from(jsonDecode(value)) : null; // Deserialize JSON string to list
}

  Future<void> deleteCookie(String name, {String? domain, String? path}) async {
    if (kIsWeb) {
      final cookie = '$name=; path=${path ?? '/'}; max-age=0';
      html.document.cookie = cookie;
    } else {
      final uri = Uri.parse(domain ?? 'https://example.com');
      final cookies = await _cookieJar?.loadForRequest(uri) ?? [];
      cookies.removeWhere((cookie) => cookie.name == name);
      await _cookieJar?.saveFromResponse(uri, cookies);
    }
  }
}

void main() async {
  final cookieManager = CookieManager();

  // Set a cookie
  await cookieManager.setCookie('user', ['JohnDoe'], domain: 'https://example.com', maxAge: 3600);

  // Get a cookie
  final user = await cookieManager.getCookie('user', domain: 'https://example.com');
  print('User: $user');

  // Delete a cookie
  await cookieManager.deleteCookie('user', domain: 'https://example.com');
}