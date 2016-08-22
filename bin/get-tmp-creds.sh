#!/usr/bin/env bash

role_session_name="$(whoami)"
duration_seconds=3600 # 900-3600
assume_role_arn="arn:aws:iam::${1}:role/${2}"

account_id="$(aws ec2 describe-security-groups \
  | jq -r '.SecurityGroups[0].OwnerId')"

result="$(aws sts assume-role \
  --role-arn $assume_role_arn \
  --role-session-name $role_session_name \
  --duration-seconds $duration_seconds)"
access_key_id="$(echo $result \
  | jq -r '.Credentials.AccessKeyId')"
secret_access_key="$(echo $result \
  | jq -r '.Credentials.SecretAccessKey')"
session_token="$(echo $result \
  | jq -r '.Credentials.SessionToken')"

cat <<EOT
export AWS_ACCESS_KEY_ID="$access_key_id"
export AWS_SECRET_ACCESS_KEY="$secret_access_key"
export AWS_SESSION_TOKEN="$session_token"
EOT
