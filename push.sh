#!/bin/bash

if [ "${COMMIT_LOOPS}" = "None" ]; then
    git push -u origin $TARGET_BRANCH
else
    for i in $COMMIT_LOOPS
    do
        git push -u origin HEAD~${i}:refs/heads/${TARGET_BRANCH}
    done
fi
