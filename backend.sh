#!/bin/bash

cat > backend.tf <<EOF
terraform {
backend "gcs" {
  }
}
EOF
