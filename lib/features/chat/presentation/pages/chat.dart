import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/chat/data/models/api_message.dart';
import 'package:file_picker/file_picker.dart' as picker;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IOWebSocketChannel _channel;

  List<types.Message> _messages = <types.Message>[];

  final types.User _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  final types.User _admin = const types.User(
    firstName: 'Администратор',
    id: 'admin',
  );

  @override
  void initState() {
    super.initState();
    final int? userId = getClientId();
    _channel = IOWebSocketChannel.connect(
      Uri.parse(socketUrl + userId.toString()),
      headers: <String, String>{
        'Authorization': 'Bearer ${getToken()}',
        'Origin': baseUrl,
      },
    );

    _channel.stream.listen((dynamic event) {
      MessageModel parsed = MessageModel.fromJson(jsonDecode(event));
      print(parsed.message.message);

      ValueNotifier<bool> isAdmin =
          ValueNotifier<bool>(parsed.message.clientSend);

      if (!isAdmin.value) {
        NotificationApi.pushLocaleNotification(
            'ФКК', parsed.message.message ?? 'ФКК');
      }
      log(parsed.toJson().toString());

      if (parsed.message.file.toString().contains('image_picker')) {
        _addMessage(
          types.ImageMessage(
            author: isAdmin.value ? _user : _admin,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: const Uuid().v4(),
            name: parsed.message.file.toString().split('/').last,
            size: 28,
            uri: baseUrl + parsed.message.file,
          ),
        );
        return;
      }

      if (parsed.message.type == 'file' &&
          !parsed.message.file.toString().contains('image_picker')) {
        _addMessage(
          types.FileMessage(
            author: isAdmin.value ? _user : _admin,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: const Uuid().v4(),
            mimeType: '',
            name: parsed.message.file.toString().split('/').last,
            size: 28,
            uri: baseUrl + parsed.message.file,
          ),
        );
        return;
      } else {
        final types.Message message = types.TextMessage(
          author: isAdmin.value ? _user : _admin,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: parsed.message.message ?? '',
        );
        _addMessage(message);
      }
    });

    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  context.pop();
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Фото'),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Файл'),
                ),
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Назад'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final picker.FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final Uint8List s =
          File(result.files.single.path ?? '').readAsBytesSync();

      final Uri a = Uri.dataFromBytes(s,
          mimeType: lookupMimeType(result.files.single.path!) ?? '');

      log(a.toString());
      types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );
      _channel.sink.add(
        jsonEncode(
          <String, Object>{
            'file': a.toString(),
            'format': result.files.single.name.split('.').last,
            'filename': result.files.single.name.split('.').first
          },
        ),
      );
    }
  }

  void _handleImageSelection() async {
    final XFile? result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
      maxHeight: 600,
      maxWidth: 900,
    );
    File(result!.path).readAsBytesSync();

    final Uint8List bytes = await result.readAsBytes();

    final Uri a =
        Uri.dataFromBytes(bytes, mimeType: lookupMimeType(result.path) ?? '');
    log('Here is from Uri${a.toString()}');

    _channel.sink.add(jsonEncode(<String, Object>{
      'file': a.toString(),
      'format': result.name.split('.').last,
      'filename': result.name.split('.').first
    }));
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      String localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final int index = _messages
              .indexWhere((types.Message element) => element.id == message.id);
          final types.Message updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final http.Client client = http.Client();
          final http.Response request =
              await client.get(Uri.parse(message.uri));
          final Uint8List bytes = request.bodyBytes;
          final String documentsDir =
              (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final File file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final int index = _messages
              .indexWhere((types.Message element) => element.id == message.id);
          final types.Message updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handleSendPressed(types.PartialText message) {
    _channel.sink.add(jsonEncode(<String, Object>{
      'message': message.text,
    }));
  }

  void _loadMessages() async {
    final Response response = await BaseHttpClient.getBody(
      'chat/support/messages/${getClientId()}/',
    );
    final List<ApiMessage> messages = (json.decode(utf8.decode(
      response.bodyBytes,
    )) as List<dynamic>)
        .map((dynamic e) {
      return ApiMessage.fromJson(e);
    }).toList();

    setState(() {});
    _messages = messages
        .map(
          (ApiMessage message) {
            if (message.type == 'text') {
              return types.TextMessage(
                author: message.clientSend == true ? _user : _admin,
                createdAt: int.tryParse(message.created_date ?? ''),
                id: message.id.toString(),
                text: message.message ?? '',
              );
            }

            if (message.file != null &&
                    message.file.toString().contains('.pdf') ||
                message.file.toString().contains('.docx') ||
                message.file.toString().contains('.doc') ||
                message.file.toString().contains('.xlsx') ||
                message.file.toString().contains('.pptx') ||
                message.file.toString().contains('.ppt') ||
                message.file.toString().contains('.txt')) {
              return types.FileMessage(
                size: 28,
                name: message.file?.split('/').last ?? '',
                uri: message.file ?? '',
                createdAt: int.tryParse(message.created_date ?? ''),
                id: message.id.toString(),
                author: message.clientSend == true ? _user : _admin,
              );
            }
            if (message.file != null &&
                    message.file.toString().contains('.png') ||
                message.file.toString().contains('.jpg') ||
                message.file.toString().contains('.jpeg') ||
                message.file.toString().contains('.gif')) {}
            return types.ImageMessage(
              author: message.clientSend == true ? _user : _admin,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              id: const Uuid().v4(),
              name: message.file?.split('/').last ?? '',
              size: 28,
              uri: message.file ?? '',
            );
          },
        )
        .toList()
        .reversed
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Chat(
          l10n: const ChatL10nRu(),
          avatarBuilder: (types.User author) {
            return UserAvatar(
              author: author,
              bubbleRtlAlignment: BubbleRtlAlignment.right,
            );
          },
          messages: _messages,
          audioMessageBuilder: (types.AudioMessage p0, {int? messageWidth}) {
            return Image.asset(Assets.microphone.path);
          },
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
          theme: DefaultChatTheme(
              secondaryColor: const Color(0xFFF0F1F3),
              userAvatarImageBackgroundColor: Colors.black38,
              primaryColor: const Color(0xFF438BFA),
              attachmentButtonIcon: SvgPicture.asset(Assets.file.path),
              inputBorderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              inputTextColor: Colors.black,
              sendingIcon: SvgPicture.asset(Assets.person.path),
              inputBackgroundColor: const Color(0xffE5E5E5),
              messageInsetsVertical: 8,
              inputContainerDecoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              inputPadding: const EdgeInsets.symmetric()),
        ),
      ),
      appBar: appBar(context),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

PreferredSize appBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          offset: const Offset(0, 1.0),
          blurRadius: 6.0,
        )
      ]),
      child: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.chevron_left,
              ),
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  Assets.avatars.appIcon.path,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Поддержка',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    'Мы всегда на связи',
                    style: Theme.of(context).textTheme.labelSmall?.apply(
                          color: Colors.black38,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
