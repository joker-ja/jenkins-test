FROM golang
RUN go mod init go_test
RUN go mod tidy
RUN go build -o go_test