#!/bin/bash

# PostBuffer
git config --global http.postBuffer 524288000	

# Commit Loops
if [[ "${COMMIT_LOOPS}" != "None" && ! -z "$COMMIT_LOOPS" ]]; then
    for i in $COMMIT_LOOPS
    do
        git push -u origin HEAD~${i}:refs/heads/${TARGET_BRANCH}
    done
fi

# Final Push
git push -u origin $TARGET_BRANCH
