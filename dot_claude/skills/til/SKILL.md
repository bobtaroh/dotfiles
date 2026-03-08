---
name: til
description: セッションで学んだ知識を抽出してNotionのDB_TILに保存する。例: /til
---

Review this session's conversation and extract knowledge the user learned (things they didn't know before or looked up). Save it to Notion DB_TIL.

## Extraction Rules

- Focus on the knowledge itself, not session steps or work logs
- Each distinct piece of knowledge = one entry
- If multiple learnings exist, propose them as separate entries and let the user choose

## Steps

1. Review the conversation and identify what was learned
2. Propose the following to the user for confirmation:
   - **Name**: Title (use `$ARGUMENTS` if provided)
   - **Tags**: Choose from existing tags: `git` `zsh` `macos` `python` `javascript` `typescript` `docker` `claude-code` `terminal` `security` `notion` `chezmoi` — propose new tags if none fit
   - **Summary**: 2-3 line key points
   - **Body**: Detailed explanation, code examples, etc.
3. After user confirms, create a page in Notion DB_TIL:
   - DB URL: https://www.notion.so/2f4f90d3502180a98492deb166a7b351
   - Name, Date (today), Tags, Source: `claude-code`, Summary, page body
4. Show the created Notion page URL

## Notes

- If no clear learning is found, ask the user: "What would you like to save?"
- Prefer existing tags; propose new ones only when necessary
- If multiple entries, list all proposals and let the user select or trim
- All output to the user and all content written to Notion (Name, Summary, Body) must be in Japanese
