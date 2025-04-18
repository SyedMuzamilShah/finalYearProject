// Assuming OverViewData is defined

// class OverViewNotifier extends StateNotifier<AsyncValue<OverViewData>> {
//   final Ref ref;

//   OverViewNotifier(this.ref) : super(const AsyncValue.loading()) {
//     fetchOverViewData();
//   }

//   Future<void> fetchOverViewData() async {
//     try {
//       final organizations = await ref.read(organizationProvider.future);

//       // ... fetch analytics data if needed

//       state = AsyncValue.data(OverViewData(
//         organizations: organizations ?? [],
//         // ... analytics data
//       ));
//     } catch (e, stackTrace) {
//       state = AsyncValue.error(e, stackTrace);
//     }
//   }

//   // Add methods to update the OverView data (e.g., refresh, update analytics)
//   Future<void> refreshOrganizations() async {
//     //ref.invalidate(organizationProvider);
//     //fetchOverViewData(); // or update only organization part.
//     try {
//       final organizations = await ref.read(organizationProvider.future);
//       state = state
//           .whenData((value) => value.copyWith(organizations: organizations));
//     } catch (e, stackTrace) {
//       state = AsyncValue.error(e, stackTrace);
//     }
//   }
//   //add copyWith method to OverViewData
// }

// class OverViewData {
//   final List<OrganizationEntities> organizations;
//   // ... other data

//   OverViewData({required this.organizations});

//   OverViewData copyWith(
//       {List<OrganizationEntities>? organizations, UserEntities? user}) {
//     return OverViewData(
//         organizations: organizations ?? this.organizations,);
//   }
// }

// final overviewProvider =
//     StateNotifierProvider<OverViewNotifier, AsyncValue<OverViewData>>((ref) {
//   return OverViewNotifier(ref);
// });
// final overviewProvider = FutureProvider((ref){
//   return ref.read(organizationProvider.future);
// });