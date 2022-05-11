#!/bin/bash

# PostBuffer
git config --global http.postBuffer 524288000	

# Create the Target Repo
GIT_USER="$(git config --get user.name)"
GIT_ORG="$(echo $TARGET | cut -d / -f4)"
repo="$(echo $TARGET | cut -d / -f5 | sed 's/.git//g')"

echo "Creating the Repository..."
sleep 1
if [[ "${GIT_ORG}" == "${GIT_USER}" ]]; then
	curl -s -X POST -H "Authorization: token ${TOKEN}" -d '{"name": "'"${repo}"'"}' "https://api.github.com/user/repos" >/dev/null 2>&1
else
	curl -s -X POST -H "Authorization: token ${TOKEN}" -d '{ "name": "'"${repo}"'"}' "https://api.github.com/orgs/${GIT_ORG}/repos" >/dev/null 2>&1
fi

# Commit Loops
if [[ "${COMMIT_LOOPS}" != "None" && ! -z "$COMMIT_LOOPS" ]]; then
echo "Commit Loops Found"
sleep 1
echo
for i in $COMMIT_LOOPS
	do
		git push -u origin HEAD~${i}:refs/heads/${TARGET_BRANCH}
	done
fi

# Final Push
echo "Pushing the Repo..."
sleep 1
printf "Repo: %s\nBranch: %s\n\n" $TARGET $TARGET_BRANCH
git push -u origin $TARGET_BRANCH
