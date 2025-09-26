# Gemini Search Command

Use this command when the issue requires additional web context that is not
already covered by the repository documentation. Always review the results and
summarise key findings inside the issue comment or pull request thread.

```
/claude suggest
  tool: gemini-search
  prompt: |
    Summarise the latest information about <topic>. Focus on details relevant to
    LaTeX tooling and AI-driven coding workflows. Return bullet points with
    citations.
```

Tips:
- Confirm whether relevant information already exists in `ai-driven-coding.md`.
- Prefer vendor documentation and official announcements over blogs.
- Store any follow-up notes in `plan/` or `results/` if they are long-lived.
