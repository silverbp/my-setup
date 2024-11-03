# Check if the directory exists, if not, create it
set -x GOPATH $MYCODE/go

if not test -d $GOPATH
    mkdir -p $GOPATH
    echo "Created directory: $GOPATH"
end

set -x PATH $MYCODE/go/bin $PATH
set -x GOPRIVATE gitlab.unanet.io
