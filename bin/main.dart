import 'dart:io';
import 'har.dart';

void main(List<String> args) async {
  if (args.length != 1) {
    print('usage: har_codegen <har-file>');
    exit(-1);
  }

  var filename = args[0];
  var harJson = await File(filename).readAsString();
  var har = harFromJson(harJson);

  // for (var entry in har.log.entries) {
  //   print('${entry.request.method}: ${entry.request.url}');
  // }

  var entry = har.log.entries[0];
  var code = codegen(entry);

  print("import 'package:http/http.dart' as http;");
  print('');
  print(code);
}

String codegen(Entry entry) {
  var code = "";
  var req = entry.request;
  var methodName =
      '${Uri.parse(req.url).pathSegments.last.replaceAll('.', '_')}_${req.method.toString().split('.').last}';

  switch (req.method) {
    case Method.POST:
      if (req.postData.params.length == 0) {
        code += "Future<String> $methodName() async {\n";
        code += "  var res = await http.post('${req.url}');\n";
        code += "  return res.body;\n";
        code += "}\n";
      } else {
        code += "Future<String> $methodName({\n";
        for (var kv in req.postData.params) {
          if (int.tryParse(kv.value) != null) {
            code += "  int ${kv.name} = ${kv.value},\n";
          } else {
            code += "  String ${kv.name} = '${urlDecode(kv.value)}',\n";
          }
        }
        code += "}) async {\n";
        code += "  var formdata = Map<String, dynamic>();\n";
        for (var kv in req.postData.params) {
          if (int.tryParse(kv.value) != null) {
            code += "  if (${kv.name} != null) formdata['${kv.name}'] = ${kv.name}.toString();\n";
          } else {
            code += "  if (${kv.name} != null) formdata['${kv.name}'] = ${kv.name};\n";
          }
        }
        code += "  var res = await http.post('${req.url}', body: formdata);\n";
        code += "  return res.body;\n";
        code += "}\n";
      }
      break;

    default:
      throw Exception('unknown method ${req.method}');
  }

  return code;
}

String urlDecode(String value) {
  var url = Uri.parse('http://foo.com/?v=$value');
  return url.queryParameters['v'];
}
