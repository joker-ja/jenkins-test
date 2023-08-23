FROM golang
RUN go mod init go_test \
    go mod tidy \
    go build -o go_test