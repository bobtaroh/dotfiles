---
name: monthly-review
description: 直近1ヶ月のDB_TILエントリを一覧表示して振り返り、gitにもバックアップする。例: /monthly-review
---

Fetch and review TIL entries from the past 30 days in Notion DB_TIL, then save a backup markdown file to the til git repository.

## Steps

1. Calculate the date 30 days ago from today and the year-month (YYYY-MM)
2. Search Notion DB_TIL for entries within that date range:
   - DB URL: https://www.notion.so/2f4f90d3502180a98492deb166a7b351
3. Display entries grouped by Tags, then chronologically within each group:
   - Tag / Date / Name / Summary
4. Add an overall comment: growth areas, recurring themes, topics to revisit
5. Save a backup markdown file to the til repository:
   - Repo: `~/Documents/src/github.com/bobtaroh/til`
   - Path: `monthly/YYYY-MM.md`
   - File content:
     ```
     ---
     period: YYYY-MM
     entries: <number of entries>
     tags: [all tags that appeared this month]
     ---

     # 月次振り返り: YYYY-MM

     ## タグ別エントリ
     （タグでグループ化した一覧）

     ## まとめ
     （今月のコメント・成長エリア・継続テーマなど）
     ```
   - Run: `cd ~/Documents/src/github.com/bobtaroh/til && git add monthly/YYYY-MM.md && git commit -m "monthly: YYYY-MM" && git push`
6. Show the git commit result

## Notes

- If no entries found for the period, note that and skip the git step
- All output to the user and all content written to markdown files must be in Japanese
