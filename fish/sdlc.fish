alias delete-local-branches 'git branch | grep -v "*" | xargs git branch -d'
alias my-issues 'jira sprint list --current -a$(jira me)'
alias current-issue 'jira issue list --jql "assignee = currentUser() AND sprint in openSprints() AND status = \"In Progress\"" --columns "key,summary" --plain --no-headers --paginate 0:1'

set -x GITLAB_API_URL https://gitlab.unanet.io/api/v4

function sdlc-create-feature-branch
    set -l issue (current-issue)
    set -l key (string match -r '^[^\t]+' -- $issue)
    set -l summary (string replace -r $key "" -- $issue | string trim)
    set -l branch "feat/$key"
    git checkout -b $branch
    git config branch.$branch.description "$summary"
end

function sdlc-git-branches
  set current (git rev-parse --abbrev-ref HEAD)
  set branches (git for-each-ref --format='%(refname)' refs/heads/ | sed 's|refs/heads/||')
  for branch in $branches
    set desc (git config branch.$branch.description)
    if test $branch = $current
      set branch "* \033[0;32m$branch\033[0m"
    else
      set branch "  $branch"
    end
    echo -e "$branch \033[0;36m$desc\033[0m"
  end
end

function sdlc-gitlab-project-id
    # Get the remote URL for the origin
    set -l remote_url (git config --get remote.origin.url)

    # Extract the namespace and project path from the URL
    set -l namespace_project (echo $remote_url | sed -E 's|^.*[:/](.+/[^.]+)(\.git)?$|\1|')
    # Query GitLab API to get the project ID
    set -l project_id (curl -s --header "PRIVATE-TOKEN: $GITLAB_ACCESS_TOKEN" \
        "$GITLAB_API_URL/projects/$(string replace '/' '%2F' $namespace_project)" \
        | jq '.id')

    echo $project_id
end

function sdlc-gitlab-draft-mr
    # Define your GitLab settings
    set -f GITLAB_PROJECT_ID (sdlc-gitlab-project-id)
    set -f BRANCH_NAME (git rev-parse --abbrev-ref HEAD)
    set -f DEFAULT_BRANCH (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    set -f BRANCH_DESCRIPTION (git config branch.$BRANCH_NAME.description)

    git push --set-upstream origin $BRANCH_NAME

    set -f BRANCH_NAME_PARTS (string split '/' $BRANCH_NAME)
    set -f JIRA_TICKET_ID $BRANCH_NAME_PARTS[2]

    if test -n "$argv[1]"
        set -f MR_TITLE "$argv[1]"
    else
        set -f MR_TITLE "$JIRA_TICKET_ID - $BRANCH_DESCRIPTION"
    end

    if test -n "$argv[2]"
        set -f DESTINATION_BRANCH "$argv[2]"
    else
        set -f DESTINATION_BRANCH "$DEFAULT_BRANCH"
    end
    # Format the title to indicate it's a draft
    set -f DRAFT_MR_TITLE "Draft: $MR_TITLE"

    # Use curl to create the MR via GitLab API
    curl -s --request POST "$GITLAB_API_URL/projects/$GITLAB_PROJECT_ID/merge_requests" \
        --header "PRIVATE-TOKEN: $GITLAB_ACCESS_TOKEN" \
        --data-urlencode "source_branch=$BRANCH_NAME" \
        --data-urlencode "target_branch=$DESTINATION_BRANCH" \
        --data-urlencode "title=$DRAFT_MR_TITLE" \
        --data "description="(printf '%b' "/assign me\n/assign_reviewer @devops") \
        --data-urlencode "remove_source_branch=true" \
        --data-urlencode "allow_collaboration=true"
end


