#!/usr/bin/env bash
DEFAULT="satoshipay-nano"
PROFILE=${AWS_PROFILE:-$DEFAULT}
BUCKET="docs.satoshipay.io"
REGION="eu-central-1"
aws s3 sync build s3://$BUCKET/api/ --region $REGION
aws s3 sync index.html s3://$BUCKET/ --region $REGION
