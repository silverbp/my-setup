alias delete-local-branches 'git branch | grep -v "*" | xargs git branch -d'
alias my-issues 'jira sprint list --current -a$(jira me)'
alias current-issue 'jira issue list --jql "assignee = currentUser() AND sprint in openSprints() AND status = \"In Progress\"" --columns "key,summary" --plain --no-headers --paginate 0:1'

printf "function gi\n\tcurl -sL https://www.toptal.com/developers/gitignore/api/\$argv\nend\n" > \
~/.config/fish/functions/gi.fish

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
