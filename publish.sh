#!/usr/bin/env bash
DEFAULT="satoshipay-nano"
PROFILE=${AWS_PROFILE:-$DEFAULT}
BUCKET="docs.satoshipay.io"
REGION="eu-central-1"
aws s3 cp index.html s3://$BUCKET/ --region $REGION
aws s3 sync build s3://$BUCKET/api/ --region $REGION

# Notify on Slack
# see https://satoshipay.slack.com/services/B064KC1HR

NOTIFICATION="payload={\"channel\": \"#deployment\", \"username\": \"SatoshiPay API\", \"text\": \"New version has been published to *$BUCKET*. <$CIRCLE_REPOSITORY_URL/commits/$CIRCLE_TAG|CHANGELOG>\", \"icon_url\": \"https://avatars0.githubusercontent.com/u/1231870?v=4&s=400\"}"
WEBHOOK_URL="https://hooks.slack.com/services/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"

curl -X POST --data-urlencode "$NOTIFICATION" "$WEBHOOK_URL"
