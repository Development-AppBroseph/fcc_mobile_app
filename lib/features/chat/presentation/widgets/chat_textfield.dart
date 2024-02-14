// import 'package:fcc_app_front/export.dart';

// class ChatTextfield extends StatefulWidget {
//   const ChatTextfield({
//     super.key,
//   });

//   @override
//   State<ChatTextfield> createState() => _ChatTextfieldState();
// }

// class _ChatTextfieldState extends State<ChatTextfield> {
//   final TextEditingController controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: 5,
//         left: 10,
//         right: 10,
//         bottom: 30,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           OnTapScaleAndFade(
//             onTap: () async {
//               final String? path = await pickImage();
//               if (path != null && context.mounted) {
//                 context.read<ChatCubit>().uploadImage(path);
//               }
//             },
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.grey[300],
//               ),
//               // child: Center
//                 child: Image.asset(
//                   'assets/settings/paper-clip.png',
//                   width: 20,
//                   height: 20,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             child: TextField(
//               controller: controller,
//               textInputAction: TextInputAction.send,
//               decoration: InputDecoration(
//                 constraints: const BoxConstraints(
//                   maxHeight: 40,
//                   minHeight: 40,
//                 ),
//                 hintText: 'Сообщение',
//                 hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
//                 filled: true,
//                 fillColor: Colors.grey[300],
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(100),
//                   borderSide: BorderSide.none,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(100),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           OnTapScaleAndFade(
//             onTap: () async {
//               await context.read<ChatCubit>().addMessage(
//                     controller.text,
//                   );
//               controller.clear();
//             },
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: textColor,
//               ),
//               child: Center(
//                 child: Image.asset(
//                   'assets/settings/send.png',
//                   width: 20,
//                   height: 20,
//                   color: primaryColorLight,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
