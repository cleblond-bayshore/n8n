# n8n - Custom Image

Dockerfile which allows to package up the local n8n code into
a docker image.

## Usage

Execute the following in the n8n root folder:

```bash
docker build -t n8n-custom -f docker/images/n8n-custom/Dockerfile .
```

To build Image to support other architectures execute the following in the n8n root folder:

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t n8n-custom -f docker/images/n8n-custom/Dockerfile .
```
