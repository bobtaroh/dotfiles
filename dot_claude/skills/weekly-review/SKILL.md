---
name: weekly-review
description: 直近1週間のDB_TILエントリを一覧表示して振り返り、gitにもバックアップする。例: /weekly-review
---

Fetch and review TIL entries from the past 7 days in Notion DB_TIL, then save a backup markdown file to the til git repository.

## Steps

1. Calculate the date 7 days ago from today and the ISO week number (YYYY-WXX)
2. Search Notion DB_TIL for entries within that date range:
   - DB URL: https://www.notion.so/2f4f90d3502180a98492deb166a7b351
3. Display entries in chronological order:
   - Date / Name / Tags / Summary
4. Add a brief overall comment: which topics appeared most, any patterns noticed
5. Save a backup markdown file to the til repository:
   - Repo: `~/Documents/src/github.com/bobtaroh/til`
   - Path: `weekly/YYYY-WXX.md`
   - File content:
     ```
     ---
     period: YYYY-WXX
     entries: <number of entries>
     tags: [all tags that appeared this week]
     ---

     # 週次振り返り: YYYY-WXX

     ## エントリ一覧
     （日付 / タイトル / タグ / サマリーの一覧）

     ## まとめ
     （今週のコメント）
     ```
   - Run: `cd ~/Documents/src/github.com/bobtaroh/til && git add weekly/YYYY-WXX.md && git commit -m "weekly: YYYY-WXX" && git push`
6. Show the git commit result

## Notes

- If no entries found for the period, note that and skip the git step
- All output to the user and all content written to markdown files must be in Japanese
