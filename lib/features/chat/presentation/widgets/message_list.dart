// import 'package:fcc_app_front/export.dart';

// class MessageList extends StatelessWidget {
//   const MessageList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: BlocBuilder<ChatCubit, List<MessageModel>>(
//         builder: (BuildContext context, List<MessageModel> state) {
//           return Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 15.w,
//             ),
//             child: state.isEmpty
//                 ? Center(
//                     child: Text(
//                       'Cообщений пока не было',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                             color: Theme.of(context).primaryColorDark,
//                             fontWeight: FontWeight.w400,
//                           ),
//                     ),
//                   )
//                 : ListView.separated(
//                     reverse: true,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ChatMessageContainer(
//                         message: state[index],
//                         isFirstOfDay: index == state.length - 1 ||
//                             index < state.length - 1 &&
//                                 checkFirstMessage(
//                                   state[index],
//                                   state[index + 1],
//                                 ),
//                       );
//                     },
//                     separatorBuilder: (BuildContext context, int index) {
//                       return sized20;
//                     },
//                     itemCount: state.length,
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }
