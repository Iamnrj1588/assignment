#!/bin/bash

ZAP_REPORT="zap-output/zap_report.html"
CONFLUENCE_PAGE_ID="6324484"
CONFLUENCE_URL="https://aspireq-cloudkitchen.atlassian.net/wiki/rest/api/content"
EMAIL="niraj.d@aspireq.in"
TOKEN="your_api_token_here"  # 🔐 Replace this with your actual Confluence/Jira token

if [ ! -f "$ZAP_REPORT" ]; then
  echo "❌ ZAP report not found at $ZAP_REPORT"
  exit 1
fi

echo "📤 Uploading ZAP report to Confluence..."
curl -u "$EMAIL:$TOKEN" \
  -X POST \
  -H 'Content-Type: multipart/form-data' \
  -F "file=@${ZAP_REPORT}" \
  "${CONFLUENCE_URL}/${CONFLUENCE_PAGE_ID}/child/attachment"

