import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsHelper {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> sendEvent(
      String eventName, Map<String, dynamic> parameters) async {
    await analytics.logEvent(name: eventName, parameters: parameters);
  }

  Future<void> sendCurrentScreen(String screenName, String screenClass) async {
    await analytics.setCurrentScreen(
        screenName: screenName, screenClassOverride: screenClass);
  }

  Future<void> sendLogin(String uid) async {
    log('login $uid');
    // await analytics.logLogin(loginMethod: "anonymous");
  }

  Future<void> sendSearchEvent(String searchTerm, String pageOrigin) async {
    analytics.logSearch(searchTerm: searchTerm, origin: pageOrigin);
  }

  Future<void> sendSelectedItem(String contentType, String itemId) async {
    await analytics.logSelectContent(contentType: contentType, itemId: itemId);
  }
}
