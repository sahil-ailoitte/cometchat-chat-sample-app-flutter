import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

///[CallLogsBuilderProtocol] is an interface that defines the structure for fetching the callLogs.
///It provides a generic [requestBuilder] property and methods [getRequest] and [getSearchRequest] that needs to be overridden.
abstract class CallLogsBuilderProtocol
    extends BuilderProtocol<CallLogRequestBuilder, CallLogRequest> {
  const CallLogsBuilderProtocol(CallLogRequestBuilder _builder)
      : super(_builder);
}

///[UICallLogsBuilder] is the default [CallLogsBuilderProtocol] used when a custom builder protocol is not passed

class UICallLogsBuilder extends CallLogsBuilderProtocol {
  const UICallLogsBuilder(CallLogRequestBuilder _builder) : super(_builder);

  @override
  CallLogRequest getRequest() {
    return requestBuilder.build();
  }

  @override
  CallLogRequest getSearchRequest(String val) {
    // requestBuilder.searchKeyword = val;
    return requestBuilder.build();
  }
}
