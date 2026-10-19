# CircuitLab Arabic — GitHub upload package

هذه الحزمة تُنشئ وتنشر موقع **CircuitLab Arabic** تلقائياً على GitHub Pages.

## الرفع

1. فك ضغط الملف.
2. افتح مستودع `QEC-Team/circuitlab-arabic` في GitHub، ثم اختر **Add file → Upload files**.
3. ارفع **محتويات** المجلد المستخرج كما هي (بما فيها المجلد المخفي `.github`).
4. اختر **Commit changes** إلى فرع `main`.

بعدها سيتولى GitHub Actions بناء المحاكي وترجمة واجهته ونشره. افتح تبويب **Actions** وانتظر اكتمال `Deploy CircuitLab Arabic to GitHub Pages`.

الرابط المتوقع بعد النشر:
`https://qec-team.github.io/circuitlab-arabic/`

## المحتوى

- واجهة عربية متجاوبة للجوال والآيباد والكمبيوتر.
- 464 مدخلاً عربياً لواجهة CircuitJS1.
- كل أمثلة الدوائر تُجلب تلقائياً أثناء البناء وتُنشر محلياً داخل الموقع.
- اختبارات تلقائية قبل النشر.

## الرخصة

المحاكي CircuitJS1 مرخّص تحت GPLv2؛ راجع `LICENSE` و`UPSTREAM_README.md`.
