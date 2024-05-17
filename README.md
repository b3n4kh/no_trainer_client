# no trainer client image

## Build

```bash
podman build -t ghcr.io/b3n4kh/no_trainer_client .
```


## Run

```bash
podman run -d --name=no_train_client -e CUSTOM_USER=user -e PASSWORD=password -p 3000:3000 --shm-size="1gb" ghcr.io/b3n4kh/no_trainer_client
```

