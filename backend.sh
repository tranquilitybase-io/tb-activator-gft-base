#!/bin/bash

cat > backend.tf <<EOF
terraform {
backend "gcs" {
credentials = "/opt/app/data/service-account.json"
  }
}
EOF
