# Usage examples
Build the image first:
`$ docker build -t docker_isg:latest .`

Example on how to run the image:
```
$ docker run -it \
    --env ICONIK_URL="https://app.iconik.io/" \
    --env AUTH_TOKEN="my_auth_token" \
    --env APP_ID="my_app_id" \
    --env STORAGE_ID="my_storage_id" \
    -v /mnt/my_nas:/mnt/mynas \
    -v /home/my_user/isg_local_data:/var/cantemo/iconik_storage_gateway/data \
    docker_isg:latest
```

you could also use external `config.ini` instead:
```
docker run -it \
    -v /mnt/my_nas:/mnt/mynas \
    -v /home/my_user/isg_local_data:/var/cantemo/iconik_storage_gateway/data \
    -v /home/my_user/isg_custom_config:/my_isg_config \
    docker_isg:latest iconik_storage_gateway --config=/my_isg_config/config.ini
```

`/home/my_user/isg_local_data` - custom preferred location on host
for the ISG local database. It is important to mount it as an external
volume in order to make local database persistent.
