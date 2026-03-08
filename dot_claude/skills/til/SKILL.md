---
name: til
description: セッションで学んだ知識を抽出してNotionのDB_TILに保存し、gitリポジトリにもpushする。例: /til
---

Review this session's conversation and extract knowledge the user learned (things they didn't know before or looked up). Save it to Notion DB_TIL and push a markdown file to the til git repository.

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
4. Save a markdown file to the til repository:
   - Repo: `~/Documents/src/github.com/bobtaroh/til`
   - Filename: `YYYY-MM-DD-<slug>.md` (slug = lowercase title with spaces replaced by hyphens, in English)
   - File content:
     ```
     ---
     date: YYYY-MM-DD
     tags: [tag1, tag2]
     notion: <created Notion page URL>
     ---

     # タイトル

     ## 概要
     （Summary の内容）

     ## 詳細
     （Body の内容）
     ```
   - Run: `cd ~/Documents/src/github.com/bobtaroh/til && git add <file> && git commit -m "til: <slug>" && git push`
5. Show the created Notion page URL and the git commit result

## Notes

- If no clear learning is found, ask the user: "What would you like to save?"
- Prefer existing tags; propose new ones only when necessary
- If multiple entries, list all proposals and let the user select or trim
- All output to the user and all content written to Notion and markdown files must be in Japanese
