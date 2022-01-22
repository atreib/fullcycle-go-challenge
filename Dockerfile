FROM golang:alpine as builder

# Our final docker image is the "scratch"
# So, we need to pass to it our user and group
#  to run our compiled Go software
ENV USER=appuser
ENV UID=10001 
RUN adduser \    
    --disabled-password \    
    --gecos "" \    
    --home "/nonexistent" \    
    --shell "/sbin/nologin" \    
    --no-create-home \    
    --uid "${UID}" \    
    "${USER}"

# Set a workdir
WORKDIR /go/src/app
# Copy our source file
COPY /src/ .
# Init our Go project
RUN go mod init example/hello
# Compile our Go software
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s"

FROM scratch

# Copy our user from the initial docker image
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

# Copy our compiled Go software
COPY --from=builder /go/src/app/hello .

# Set our copied user in our final image
USER appuser:appuser

# Run our compiled Go software
ENTRYPOINT ["./hello"]