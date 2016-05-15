#!/usr/bin/env bash
DEFAULT="satoshipay-nano"
PROFILE=${AWS_PROFILE:-$DEFAULT}
BUCKET="docs.satoshipay.io"
REGION="eu-central-1"
aws s3 cp index.html s3://$BUCKET/ --region $REGION
aws s3 sync build s3://$BUCKET/api/ --region $REGION
