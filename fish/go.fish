# Check if the directory exists, if not, create it
set -x GOPATH $MY_CODE/go

if not test -d $GOPATH
    mkdir -p $GOPATH
    echo "Created directory: $GOPATH"
end

set -x PATH $MY_CODE/go/bin $PATH
set -x GOPRIVATE gitlab.unanet.io
