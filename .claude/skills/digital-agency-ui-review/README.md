# digital-agency-ui-review

デジタル庁のデザインシステム、ユーザビリティ、ウェブサイト、ウェブコンテンツ、ウェブアクセシビリティ、ダッシュボードデザイン関連資料をもとに、行政・公共系Web/UIをレビュー・設計・改善するためのClaude Code Skillです。

## インストール

個人用Skillとして使う場合:

```bash
mkdir -p ~/.claude/skills
unzip digital-agency-ui-review-skill.zip -d ~/.claude/skills/
```

プロジェクトだけで使う場合:

```bash
mkdir -p .claude/skills
unzip digital-agency-ui-review-skill.zip -d .claude/skills/
```

## 使い方

Claude Codeで次のように呼び出します。

```text
/digital-agency-ui-review この申請フォームをレビューして
```

または、通常の会話で「デジタル庁デザインシステムに沿ってUIレビューして」などと依頼すると、自動的に呼び出される想定です。

## 含まれるファイル

```text
digital-agency-ui-review/
├── SKILL.md
├── README.md
├── references/
│   ├── source-map.md
│   └── review-checklist.md
├── templates/
│   ├── ui-review-report.md
│   ├── dashboard-review-report.md
│   └── implementation-brief.md
└── examples/
    └── form-review-example.md
```

## 注意

このSkillは実務レビューを支援するためのものです。正式なアクセシビリティ適合試験、法的確認、調達上の最終判断を代替するものではありません。最新性が必要な場合は、デジタル庁の公式ページを確認してください。
