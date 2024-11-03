alias kube-cleanup-pods 'kubectl get po --all-namespaces --field-selector "status.phase!=Running" -o json | kubectl delete -f -'
alias kube-diag 'kubectl run tmp-shell-centzi --rm -i --tty --image nicolaka/netshoot -- /bin/bash'
alias kube-win-cmd 'kubectl run win-tmp-shell --rm -i --tty --image mcr.microsoft.com/windows/servercore:1809 --overrides='"'"'{"apiVersion":"v1","spec":{"imagePullSecrets":[{"name":"docker-cfg"}],"nodeSelector":{"kubernetes.io/arch":"amd64","kubernetes.io/os":"windows"},"tolerations":[{"effect":"NoSchedule","key":"os","operator":"Equal","value":"windows"}]}}'"'"' -- powershell.exe'
alias kube-psql 'kubectl run tmp-psql-centzi --rm -i --tty --image governmentpaas/psql'

set -x KUBECONFIG $HOME/.kube/config:$HOME/perfectserve/docs/kube/config
