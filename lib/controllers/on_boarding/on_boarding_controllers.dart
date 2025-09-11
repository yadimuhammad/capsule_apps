import '../../base/base_controllers.dart';
import '../../models/on_boarding/question_models.dart';
import '../../pages/components_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingControllers extends BaseControllers {
  final RxInt currentPage = 0.obs;
  final RxInt maxPage = 6.obs;

  @override
  final RxBool isLoading = false.obs;
  final RxList<QuestionModels> questions = <QuestionModels>[].obs;
  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    _initializeQuestions();
  }

  void _initializeQuestions() {
    questions.value = [
      QuestionModels(
        id: "1",
        title: "What's your main goal with this app?",
        options: [
          "🎯 Increase productivity",
          "💡 Learn new skills",
          "🤝 Connect with others",
          "📈 Track progress",
        ],
      ),
      QuestionModels(
        id: "2",
        title: "How often do you plan to use this app?",
        options: ["📱 Daily", "📅 Weekly", "📆 Monthly", "🔄 Occasionally"],
      ),
      QuestionModels(
        id: "3",
        title: "What's your experience level?",
        options: [
          "🌱 Beginner",
          "📚 Intermediate",
          "🏆 Advanced",
          "👨‍🏫 Expert",
        ],
      ),
    ];
  }

  void nextPage() {
    if (currentPage.value < maxPage.value) {
      pageController.animateToPage(
        currentPage.value + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.animateToPage(
        currentPage.value - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage.value--;
    }
  }

  void selectAnswer(String questionId, String answer) {
    final questionIndex = questions.indexWhere((q) => q.id == questionId);
    if (questionIndex != -1) {
      questions[questionIndex] = questions[questionIndex].copyWith(
        selectedAnswer: answer,
      );
      questions.refresh();
    }
  }

  bool canProceed() {
    if (currentPage.value == (maxPage.value - 1)) {
      // Questionnaire page
      final currentQuestionIndex = getCurrentQuestionIndex();
      if (currentQuestionIndex < questions.length) {
        return questions[currentQuestionIndex].selectedAnswer != null;
      }
    }
    return true;
  }

  int getCurrentQuestionIndex() {
    // Assuming questionnaire starts at page 3 and each question is on separate page
    return currentPage.value - 3;
  }

  double getProgress() {
    if (currentPage.value < 3) return 0.0;
    final questionIndex = getCurrentQuestionIndex();
    return (questionIndex + 1) / questions.length;
  }

  Future<void> completeOnboarding() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_completed', true);

      // Save answers
      for (var question in questions) {
        if (question.selectedAnswer != null) {
          await prefs.setString(
            'answer_${question.id}',
            question.selectedAnswer!,
          );
        }
      }

      Get.offAll(() => ComponentsPage());
    } catch (e) {
      Get.snackbar('Error', 'Failed to complete onboarding');
    } finally {
      isLoading.value = false;
    }
  }

  void skipOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    Get.offAllNamed('/home');
  }
}
