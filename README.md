# GoLang Challenge - Full Cycle 2.0

## Challenge statement

```
Esse desafio é muito empolgante principalmente se você nunca trabalhou com a linguagem Go!
Você terá que publicar uma imagem no docker hub. Quando executarmos:

`docker run <seu-user>/codeeducation`

Temos que ter o seguinte resultado: Code.education Rocks!

* A imagem de nosso projeto Go precisa ter menos de 2MB =)
```

## Steps

- First of all, let's setup a debug docker container to develop using GoLang without having to install in in our host environment
  - `docker run --rm -it -v $(pwd)/src/:/go/src/app/ golang:1.17`
    - We're creating our container with `--rm` to remove it after our usage (because it's only a debug)
    - The `-it` is required because we're going to interact with out container
    - We create a volume (`-v`) to map our source files to inside the container
      - The `/go/src/app/` path can be found in GoLang docs and on its page on Docker Hub
  - Now, inside of our Go container, we run:
    - `cd /go/src/app/`: Let's go to our Workdir
    - `go mod init example/hello`: Let's start our Go project (got this from Go docs)
  - Now, we go back to our text editor and we create a file named `hello.go` inside of our `./src/` directory (that is mapped to inside of the container).
    - You can find the `hello.go` script in this repository, in the `/src` folder
  - With our `hello.go` file created, we run `go run .` (inside of our repository, where Go exists) to execute our code inside of the container!
  - Voilá! Everything's working as expected!
- The next step is to create an image
  - We wrote all steps above in one Dockerfile, built it and ran
  - It works as expected, but our image is too big
- Let's decrease our image's size (those tips were found using the internet - what a great technology!!)
  - First of all, let's start using the Alpine version of the Go image
  - Also, let's compile our Go software (so we don't need Go to execute it anymore)
  - After that, let's apply the multistage building concept to get rid of our Go environment (since we don't need Go compiler anymore)
  - Finally, we are going to use the `scratch` Docker image cause it's very small
    - We needed to add a few more steps to deal with the `scratch` image, because we needed to provide the user and group able to execute our compiled Go software
- Build it again, run, check if everything's working as expected and, if so, push our image to Docker Hub. Congrats!
  - You can find the Dockerfile in our repository's root
