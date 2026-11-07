import 'package:flutter/material.dart';
import '../../../core/models/troubleshoot_model.dart';
import '../../../core/theme/theme.dart';
import '../../navigation/widgets/nutrient_calculator_dialog.dart';

/// Interactive visual decision tree / flowchart screen for plant diagnosis.
/// Guides users through visual symptom inspection steps to determine root causes
/// and actionable remedies.
class VisualTroubleshooterScreen extends StatefulWidget {
  const VisualTroubleshooterScreen({
    super.key,
    required this.category,
  });

  final SymptomCategory category;

  @override
  State<VisualTroubleshooterScreen> createState() =>
      _VisualTroubleshooterScreenState();
}

class _VisualTroubleshooterScreenState
    extends State<VisualTroubleshooterScreen> {
  late String _currentQuestionId;
  DiagnosisResult? _finalResult;
  final List<String> _historyQuestionIds = [];

  @override
  void initState() {
    super.initState();
    _currentQuestionId = widget.category.initialQuestionId;
  }

  void _onSelectOption(TroubleshootOption option) {
    if (option.result != null) {
      setState(() {
        _finalResult = option.result;
      });
    } else if (option.nextQuestionId != null) {
      setState(() {
        _historyQuestionIds.add(_currentQuestionId);
        _currentQuestionId = option.nextQuestionId!;
      });
    }
  }

  void _onBackStep() {
    if (_finalResult != null) {
      setState(() {
        _finalResult = null;
      });
    } else if (_historyQuestionIds.isNotEmpty) {
      setState(() {
        _currentQuestionId = _historyQuestionIds.removeLast();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final muted = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;
    final cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final borderColor =
        isDark ? AppColors.borderDark : AppColors.borderLight;

    final currentQuestion =
        SampleTroubleshootData.questions[_currentQuestionId];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: _onBackStep,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: _finalResult != null
            ? _buildDiagnosisResult(context, _finalResult!, isDark, fg, muted, cardBg, borderColor)
            : currentQuestion != null
                ? _buildQuestionStep(context, currentQuestion, isDark, fg, muted, cardBg, borderColor)
                : const Center(child: Text('Data pertanyaan tidak ditemukan.')),
      ),
    );
  }

  Widget _buildQuestionStep(
    BuildContext context,
    TroubleshootQuestion question,
    bool isDark,
    Color fg,
    Color muted,
    Color cardBg,
    Color borderColor,
  ) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      physics: const BouncingScrollPhysics(),
      children: [
        // Flowchart progress step tag
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.account_tree_rounded, size: 14, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    'Pohon Keputusan (Langkah ${_historyQuestionIds.length + 1})',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Question Title
        Text(
          question.question,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: fg,
            letterSpacing: -0.4,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 8),

        // Visual Guidance Box
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.visibility_outlined, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question.guidance,
                  style: TextStyle(fontSize: 12.5, color: muted, height: 1.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        Text(
          'Pilih Kondisi yang Paling Mendekati:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: fg,
          ),
        ),
        const SizedBox(height: 12),

        // Options List
        ...question.options.map((option) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => _onSelectOption(option),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option.label,
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: fg,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            option.description,
                            style: TextStyle(fontSize: 12, color: muted, height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDiagnosisResult(
    BuildContext context,
    DiagnosisResult result,
    bool isDark,
    Color fg,
    Color muted,
    Color cardBg,
    Color borderColor,
  ) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      physics: const BouncingScrollPhysics(),
      children: [
        // Severity Tag
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Color(result.severity.colorValue).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.report_problem_rounded,
                    size: 14,
                    color: Color(result.severity.colorValue),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Tingkat Bahaya: ${result.severity.label}',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Color(result.severity.colorValue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Diagnosis Title
        Text(
          result.title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: fg,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          result.subtitle,
          style: TextStyle(fontSize: 13, color: muted, height: 1.4),
        ),
        const SizedBox(height: 20),

        // Root Cause Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.search_rounded, size: 18, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'Akar Masalah (Penyebab Utama)',
                    style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                result.cause,
                style: TextStyle(fontSize: 13, color: fg, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Actionable Solutions Box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.medical_services_outlined, size: 18, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'Langkah Penanganan Cepat',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...result.solutions.map((sol) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('✓ ', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                      Expanded(
                        child: Text(
                          sol,
                          style: TextStyle(fontSize: 12.5, color: fg, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Prevention Tip
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.shield_outlined, size: 18, color: Color(0xFF38BDF8)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pencegahan ke Depan:',
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      result.prevention,
                      style: TextStyle(fontSize: 12, color: muted, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Optional Shortcut to Nutrient Calculator
        if (result.isNutrientRelated) ...[
          ElevatedButton.icon(
            onPressed: () => NutrientCalculatorDialog.show(context),
            icon: const Icon(Icons.science_outlined),
            label: const Text('Buka Kalkulator Dosis Nutrisi AB Mix'),
          ),
          const SizedBox(height: 10),
        ],

        OutlinedButton.icon(
          onPressed: () {
            setState(() {
              _finalResult = null;
              _historyQuestionIds.clear();
              _currentQuestionId = widget.category.initialQuestionId;
            });
          },
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Diagnosa Ulang / Periksa Gejala Lain'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
