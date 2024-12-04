// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class UserProgress {
//   final int level;
//   final int experience;
//   final List<String> achievements;
//   final int dailyStreak;
//   final Map<String, bool> dailyChallenges;

//   UserProgress({
//     this.level = 1,
//     this.experience = 0,
//     this.achievements = const [],
//     this.dailyStreak = 0,
//     this.dailyChallenges = const {},
//   });

//   UserProgress copyWith({
//     int? level,
//     int? experience,
//     List<String>? achievements,
//     int? dailyStreak,
//     Map<String, bool>? dailyChallenges,
//   }) {
//     return UserProgress(
//       level: level ?? this.level,
//       experience: experience ?? this.experience,
//       achievements: achievements ?? this.achievements,
//       dailyStreak: dailyStreak ?? this.dailyStreak,
//       dailyChallenges: dailyChallenges ?? this.dailyChallenges,
//     );
//   }
// }

// class GamificationNotifier extends StateNotifier<UserProgress> {
//   final SharedPreferences prefs;
  
//   GamificationNotifier(this.prefs) : super(UserProgress()) {
//     _loadProgress();
//   }

//   void _loadProgress() {
//     state = UserProgress(
//       level: prefs.getInt('level') ?? 1,
//       experience: prefs.getInt('experience') ?? 0,
//       achievements: prefs.getStringList('achievements') ?? [],
//       dailyStreak: prefs.getInt('dailyStreak') ?? 0,
//       dailyChallenges: Map<String, bool>.from(
//         prefs.getString('dailyChallenges') != null
//             ? Map<String, bool>.from(
//                 prefs.getString('dailyChallenges') as Map<String, bool>)
//             : {},
//       ),
//     );
//   }

//   Future<void> addExperience(int amount) async {
//     int newExperience = state.experience + amount;
//     int newLevel = state.level;
    
//     // Level up if experience threshold is reached
//     while (newExperience >= _experienceForNextLevel(newLevel)) {
//       newExperience -= _experienceForNextLevel(newLevel);
//       newLevel++;
//     }

//     state = state.copyWith(
//       experience: newExperience,
//       level: newLevel,
//     );

//     await _saveProgress();
//   }

//   int _experienceForNextLevel(int currentLevel) {
//     return 100 * currentLevel; // Simple linear progression
//   }

//   Future<void> unlockAchievement(String achievement) async {
//     if (!state.achievements.contains(achievement)) {
//       final newAchievements = [...state.achievements, achievement];
//       state = state.copyWith(achievements: newAchievements);
//       await _saveProgress();
//     }
//   }

//   Future<void> completeDailyChallenge(String challenge) async {
//     final newChallenges = Map<String, bool>.from(state.dailyChallenges);
//     newChallenges[challenge] = true;
//     state = state.copyWith(dailyChallenges: newChallenges);
//     await _saveProgress();
//   }

//   Future<void> _saveProgress() async {
//     await prefs.setInt('level', state.level);
//     await prefs.setInt('experience', state.experience);
//     await prefs.setStringList('achievements', state.achievements);
//     await prefs.setInt('dailyStreak', state.dailyStreak);
//     await prefs.setString('dailyChallenges', state.dailyChallenges.toString());
//   }
// }

// final gamificationProvider =
//     StateNotifierProvider<GamificationNotifier, UserProgress>((ref) {
//   throw UnimplementedError();
// });
