# Dorothy
Dorothy (named after the protagonist of the Oz novels) is a Docker image for running the OPI (Oz Programming Interface) out-of-the-box.

# Setup
When building for architectures other than the default (`x64`), please set the `ARCH` environment variable to suit your machine's architecture, else the software may not work as intended.
```
git clone https://github.com/richarah/dorothy.git
cd dorothy
docker build . -t dorothy
```

# Running Dorothy
Once the Docker build finishes, Dorothy may be run with the following command. The `-it` flag is necessary to interact with the OPI:
```
docker run -it dorothy
```
