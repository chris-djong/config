# Create pre-commit hook in HOOK_PATH
read -e -p "Please provide a repo: " GIT_FOLDER
read -e -p "Please provide the frontend folder (frontend): " FRONTEND_DIR
read -e -p "Please provide the backend folder (backend): " BACKEND_DIR
FRONTEND_DIR=${FRONTEND_DIR:-frontend}
BACKEND_DIR=${BACKEND_DIR:-frontend}

# Check if the folder exists
if [ ! -d "$GIT_FOLDER/.git" ]; then
  echo "❌ '$GIT_FOLDER' is not a valid git repository."
  echo "~ is not working. Please use an absolute path /home/chris/"
  exit 1
fi

HOOK_FILE="$GIT_FOLDER/.git/hooks/pre-commit"

echo "Installing precommit hook in $HOOK_FILE"
cat >"$HOOK_FILE" <<EOF
#! /usr/bin/env bash
# Get the list of changed files in the commit
EXIT_STATUS=0

# We need to check whether the files exists
CHANGED_FILES=()
for file in \$(git diff --cached --name-only); do
  [ -f "\$file" ] && CHANGED_FILES+=("\$file")
done

##########################################################################
#                                NOCOMMIT                                #
##########################################################################

mapfile -t NO_COMMITS < <(grep -l NOCOMMIT "\${CHANGED_FILES[@]}" | xargs -r realpath)
if [[ \${#NO_COMMITS[@]} -gt 0 ]]; then
  echo "The following files contain NOCOMMITS"
  echo " - \${NO_COMMITS[@]}"
  EXIT_STATUS=1
fi

##########################################################################
#                                BIG FILE                                #
##########################################################################

mapfile -t LARGE_FILES < <(find . -type f -size +50M -print0 | xargs -0 -r realpath)
if [[ \${#LARGE_FILES[@]} -gt 0 ]]; then
  echo "The following files are larger than 50Mb"
  echo " - \${LARGE_FILES[@]}"
  EXIT_STATUS=1
fi


##########################################################################
#                             PYTHON CHECKS                              #
##########################################################################

mapfile -t PYTHON_FILES < <(printf "%s\n" "\${CHANGED_FILES[@]}" | grep -E "\.py$" | sed 's|^$BACKEND_DIR/||')
if [ \${#PYTHON_FILES[@]} -gt 0 ]; then
  cd $BACKEND_DIR
  basedpyright "\${PYTHON_FILES[@]}" || EXIT_STATUS=1
  ruff check "\${PYTHON_FILES[@]}" || EXIT_STATUS=1
  ruff format --check "\${PYTHON_FILES[@]}" || EXIT_STATUS=1
  cd ..
fi

##########################################################################
#                           JS/TS/HTML CHECKS                            #
##########################################################################

mapfile -t JS_HTML_FILES < <(printf "%s\n" "\${CHANGED_FILES[@]}" | grep -E "\.(js|ts|html)$" | sed 's|^$FRONTEND_DIR/||')
if [ \${#JS_HTML_FILES[@]} -gt 0 ]; then
  cd $FRONTEND_DIR 
  eslint "\${JS_HTML_FILES[@]}" || EXIT_STATUS=1
  prettier --check "\${JS_HTML_FILES[@]}" || EXIT_STATUS=1
  cd ..
fi

##########################################################################
#                               SQL CHECKS                               #
##########################################################################

mapfile -t SQL_FILES < <(printf "%s\n" "\${CHANGED_FILES[@]}" | grep -E "\.sql$")
if [ \${#SQL_FILES[@]} -gt 0 ]; then
  sqlfluff lint "\${SQL_FILES[@]}" || EXIT_STATUS=1
fi

##########################################################################
#                              SHELL CHECKS                              #
##########################################################################

mapfile -t SHELL_FILES < <(printf "%s\n" "\${SHELL_FILES[@]}" | grep -E "\.(sh|zsh|bash)$")
if [ \${#SHELL_FILES[@]} -gt 0 ]; then
  shellcheck "\${SHELL_FILES[@]}" || EXIT_STATUS=1
  shfmt -d "\${SHELL_FILES[@]}" || EXIT_STATUS=1
fi

if [ \$EXIT_STATUS -ne 0 ]; then
  echo "❌ Pre-commit checks failed!"
  echo ""
  exit 1
fi
echo "✅ All pre-commit checks passed!"
echo ""
exit 0
EOF

chmod +x "$HOOK_FILE"
echo "✅ Pre-commit hook installed successfully!"
