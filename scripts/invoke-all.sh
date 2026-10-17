#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"

bash "$DIR/handle-logos.sh"
bash "$DIR/handle-preview.sh"
bash "$DIR/handle-readme.sh"