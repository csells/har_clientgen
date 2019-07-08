import 'dart:convert';

Har harFromJson(String str) => Har.fromJson(json.decode(str));

class Har {
  Log log;

  Har({
    this.log,
  });

  factory Har.fromJson(Map<String, dynamic> json) => new Har(
        log: json["log"] == null ? null : Log.fromJson(json["log"]),
      );
}

class Log {
  String version;
  Creator creator;
  List<Entry> entries;

  Log({
    this.version,
    this.creator,
    this.entries,
  });

  factory Log.fromJson(Map<String, dynamic> json) => new Log(
        version: json["version"] == null ? null : json["version"],
        creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
        entries: json["entries"] == null
            ? null
            : new List<Entry>.from(json["entries"].map((x) => Entry.fromJson(x))),
      );
}

class Creator {
  String name;
  String version;

  Creator({
    this.name,
    this.version,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => new Creator(
        name: json["name"] == null ? null : json["name"],
        version: json["version"] == null ? null : json["version"],
      );
}

class Entry {
  DateTime startedDateTime;
  double time;
  Request request;
  Response response;
  ServerIpAddress serverIpAddress;
  Initiator initiator;
  Priority priority;
  String resourceType;
  String connection;
  Pageref pageref;
  String fromCache;

  Entry({
    this.startedDateTime,
    this.time,
    this.request,
    this.response,
    this.serverIpAddress,
    this.initiator,
    this.priority,
    this.resourceType,
    this.connection,
    this.pageref,
    this.fromCache,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => new Entry(
        startedDateTime:
            json["startedDateTime"] == null ? null : DateTime.parse(json["startedDateTime"]),
        time: json["time"] == null ? null : json["time"].toDouble(),
        request: json["request"] == null ? null : Request.fromJson(json["request"]),
        response: json["response"] == null ? null : Response.fromJson(json["response"]),
        serverIpAddress: json["serverIPAddress"] == null
            ? null
            : serverIpAddressValues.map[json["serverIPAddress"]],
        initiator: json["_initiator"] == null ? null : Initiator.fromJson(json["_initiator"]),
        priority: json["_priority"] == null ? null : priorityValues.map[json["_priority"]],
        resourceType: json["_resourceType"] == null ? null : json["_resourceType"],
        connection: json["connection"] == null ? null : json["connection"],
        pageref: json["pageref"] == null ? null : pagerefValues.map[json["pageref"]],
        fromCache: json["_fromCache"] == null ? null : json["_fromCache"],
      );
}

class Initiator {
  Type type;
  String url;
  int lineNumber;

  Initiator({
    this.type,
    this.url,
    this.lineNumber,
  });

  factory Initiator.fromJson(Map<String, dynamic> json) => new Initiator(
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        url: json["url"] == null ? null : json["url"],
        lineNumber: json["lineNumber"] == null ? null : json["lineNumber"],
      );
}

enum Type { OTHER, PARSER }

final typeValues = new EnumValues({"other": Type.OTHER, "parser": Type.PARSER});

enum Pageref { PAGE_2 }

final pagerefValues = new EnumValues({"page_2": Pageref.PAGE_2});

enum Priority { VERY_HIGH, HIGH, LOW }

final priorityValues =
    new EnumValues({"High": Priority.HIGH, "Low": Priority.LOW, "VeryHigh": Priority.VERY_HIGH});

class Request {
  Method method;
  String url;
  HttpVersion httpVersion;
  List<Header> headers;
  List<Header> queryString;
  List<Cooky> cookies;
  int headersSize;
  int bodySize;
  PostData postData;

  Request({
    this.method,
    this.url,
    this.httpVersion,
    this.headers,
    this.queryString,
    this.cookies,
    this.headersSize,
    this.bodySize,
    this.postData,
  });

  factory Request.fromJson(Map<String, dynamic> json) => new Request(
        method: json["method"] == null ? null : methodValues.map[json["method"]],
        url: json["url"] == null ? null : json["url"],
        httpVersion:
            json["httpVersion"] == null ? null : httpVersionValues.map[json["httpVersion"]],
        headers: json["headers"] == null
            ? null
            : new List<Header>.from(json["headers"].map((x) => Header.fromJson(x))),
        queryString: json["queryString"] == null
            ? null
            : new List<Header>.from(json["queryString"].map((x) => Header.fromJson(x))),
        cookies: json["cookies"] == null
            ? null
            : new List<Cooky>.from(json["cookies"].map((x) => Cooky.fromJson(x))),
        headersSize: json["headersSize"] == null ? null : json["headersSize"],
        bodySize: json["bodySize"] == null ? null : json["bodySize"],
        postData: json["postData"] == null ? null : PostData.fromJson(json["postData"]),
      );
}

class Cooky {
  Name name;
  String value;
  dynamic expires;
  bool httpOnly;
  bool secure;

  Cooky({
    this.name,
    this.value,
    this.expires,
    this.httpOnly,
    this.secure,
  });

  factory Cooky.fromJson(Map<String, dynamic> json) => new Cooky(
        name: json["name"] == null ? null : nameValues.map[json["name"]],
        value: json["value"] == null ? null : json["value"],
        expires: json["expires"],
        httpOnly: json["httpOnly"] == null ? null : json["httpOnly"],
        secure: json["secure"] == null ? null : json["secure"],
      );
}

enum Name { NAME_GEN, RANDOM_GEN, NAV, EXTFC }

final nameValues = new EnumValues({
  "__extfc": Name.EXTFC,
  "name_gen": Name.NAME_GEN,
  "nav": Name.NAV,
  "random_gen": Name.RANDOM_GEN
});

class Header {
  String name;
  String value;

  Header({
    this.name,
    this.value,
  });

  factory Header.fromJson(Map<String, dynamic> json) => new Header(
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? null : json["value"],
      );
}

enum HttpVersion { HTTP_11, HTTP_20_QUIC_46, EMPTY, HTTP_VERSION_HTTP_11 }

final httpVersionValues = new EnumValues({
  "": HttpVersion.EMPTY,
  "HTTP/1.1": HttpVersion.HTTP_11,
  "http/2.0+quic/46": HttpVersion.HTTP_20_QUIC_46,
  "http/1.1": HttpVersion.HTTP_VERSION_HTTP_11
});

enum Method { POST, GET }

final methodValues = new EnumValues({"GET": Method.GET, "POST": Method.POST});

class PostData {
  String mimeType;
  String text;
  List<Header> params;

  PostData({
    this.mimeType,
    this.text,
    this.params,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => new PostData(
        mimeType: json["mimeType"] == null ? null : json["mimeType"],
        text: json["text"] == null ? null : json["text"],
        params: json["params"] == null
            ? null
            : new List<Header>.from(json["params"].map((x) => Header.fromJson(x))),
      );
}

class Response {
  int status;
  StatusText statusText;
  HttpVersion httpVersion;
  List<Header> headers;
  List<dynamic> cookies;
  Content content;
  String redirectUrl;
  int headersSize;
  int bodySize;
  int transferSize;
  String error;

  Response({
    this.status,
    this.statusText,
    this.httpVersion,
    this.headers,
    this.cookies,
    this.content,
    this.redirectUrl,
    this.headersSize,
    this.bodySize,
    this.transferSize,
    this.error,
  });

  factory Response.fromJson(Map<String, dynamic> json) => new Response(
        status: json["status"] == null ? null : json["status"],
        statusText: json["statusText"] == null ? null : statusTextValues.map[json["statusText"]],
        httpVersion:
            json["httpVersion"] == null ? null : httpVersionValues.map[json["httpVersion"]],
        headers: json["headers"] == null
            ? null
            : new List<Header>.from(json["headers"].map((x) => Header.fromJson(x))),
        cookies:
            json["cookies"] == null ? null : new List<dynamic>.from(json["cookies"].map((x) => x)),
        content: json["content"] == null ? null : Content.fromJson(json["content"]),
        redirectUrl: json["redirectURL"] == null ? null : json["redirectURL"],
        headersSize: json["headersSize"] == null ? null : json["headersSize"],
        bodySize: json["bodySize"] == null ? null : json["bodySize"],
        transferSize: json["_transferSize"] == null ? null : json["_transferSize"],
        error: json["_error"] == null ? null : json["_error"],
      );
}

class Content {
  int size;
  String mimeType;
  int compression;
  String text;
  String encoding;

  Content({
    this.size,
    this.mimeType,
    this.compression,
    this.text,
    this.encoding,
  });

  factory Content.fromJson(Map<String, dynamic> json) => new Content(
        size: json["size"] == null ? null : json["size"],
        mimeType: json["mimeType"] == null ? null : json["mimeType"],
        compression: json["compression"] == null ? null : json["compression"],
        text: json["text"] == null ? null : json["text"],
        encoding: json["encoding"] == null ? null : json["encoding"],
      );
}

enum StatusText { OK, EMPTY }

final statusTextValues = new EnumValues({"": StatusText.EMPTY, "OK": StatusText.OK});

enum ServerIpAddress { THE_20725446118, THE_17221714202, EMPTY }

final serverIpAddressValues = new EnumValues({
  "": ServerIpAddress.EMPTY,
  "172.217.14.202": ServerIpAddress.THE_17221714202,
  "207.254.46.118": ServerIpAddress.THE_20725446118
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}