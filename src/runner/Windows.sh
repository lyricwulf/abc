#!/bin/bash
echo "Installing Windows dependencies:"
echo "  $ABC_DEPS"
# Choco version syntax is libxyz --version 1.2.3
# NOTE: CHOCO WITH VERSIONS, EACH PACKAGE MUST BE INSTALLED ONE AT A TIME
for ABC_DEP in $ABC_DEPS
do
choco install -y ${ABC_DEP//@/ --version }
done