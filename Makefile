.PHONY: install
go-install:
	GO111MODULE=off go get github.com/oxequa/realize
	go install golang.org/x/tools/gopls@v0.6.6
