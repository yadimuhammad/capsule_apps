import '../../controllers/on_boarding/on_boarding_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingControllers controller = Get.put(OnboardingControllers());

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (page) => controller.currentPage.value = page,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildWelcomeScreen(context),
          _buildIntroSlide1(context),
          _buildIntroSlide2(context),
          _buildQuestionnaireScreen(context),
          _buildQuestionnaireScreen(context),
          _buildQuestionnaireScreen(context),
          _buildCompletionScreen(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryFixedDim,
            Theme.of(context).colorScheme.primary,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.rocket_launch,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Discover amazing features and customize your experience with our app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: controller.nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroSlide1(context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFff9a56), Color(0xFFffad56)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.track_changes,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Set Your Goals',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2c3e50),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Personalize your experience and achieve what matters most to you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7f8c8d),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  Widget _buildIntroSlide2(context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFa8edea), Color(0xFFfed6e3)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Smart Features',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2c3e50),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Enjoy intelligent recommendations tailored just for you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7f8c8d),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  Widget _buildQuestionnaireScreen(context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final questionIndex = controller.getCurrentQuestionIndex();
          if (questionIndex >= controller.questions.length) {
            return const Center(child: Text('All questions completed'));
          }

          final question = controller.questions[questionIndex];

          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress bar
                LinearProgressIndicator(
                  value: controller.getProgress(),
                  backgroundColor: const Color(0xFFe9ecef),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Question ${questionIndex + 1} of ${controller.questions.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6c757d),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  question.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2c3e50),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      final option = question.options[index];
                      final isSelected = question.selectedAnswer == option;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () =>
                              controller.selectAnswer(question.id, option),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer
                                  : const Color(0xFFf8f9fa),
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : const Color(0xFFe9ecef),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF2c3e50),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  Widget _buildCompletionScreen(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            Theme.of(context).colorScheme.primaryFixedDim,
            Theme.of(context).colorScheme.primary,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.celebration,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'All Set!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your personalized experience is ready. Let\'s start your journey!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 50),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.completeOnboarding,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Start Using App',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar(context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            TextButton(
              onPressed: controller.currentPage.value > 0
                  ? controller.previousPage
                  : null,
              child: Text(
                'Back',
                style: TextStyle(
                  color: controller.currentPage.value > 0
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Page indicators
            if (controller.currentPage.value > 0 &&
                controller.currentPage.value < controller.maxPage.value)
              SmoothPageIndicator(
                controller: controller.pageController,
                count: controller.maxPage.value,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotColor: Colors.grey,
                ),
              ),

            // Next/Skip button
            ElevatedButton(
              onPressed:
                  controller.currentPage.value == controller.maxPage.value
                  ? null
                  : controller.canProceed()
                  ? controller.nextPage
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                controller.currentPage.value < (controller.maxPage.value - 1)
                    ? 'Next'
                    : 'Continue',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
