FROM golang

RUN pwd && ls -alh
RUN mkdir -p /go/src/go_test
WORKDIR /go/src/go_test
COPY . .
RUN go env -w GOPROXY="https://goproxy.cn,direct" && \
    go mod init go_test && \
    go mod tidy
RUN go build -o go_test
ENTRYPOINT ./test