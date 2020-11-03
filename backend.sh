#!/bin/sh

cat > backend.tf <<EOF
terraform {
backend "gcs" {
  }
}
EOF
