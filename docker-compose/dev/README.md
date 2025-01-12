# Development overlay

For use developing Khulnasoft's docker-compose deployment only.
For deployments, refer to the official [Khulnasoft with Docker Compose](https://docs.khulnasoft.com/admin/install/docker-compose) documentation.

This folder includes a helper script, [run.sh](./run.sh), that will run the `docker-compose` command (with any provided arguments) while automatically specifying the appropriate set of overlays.

Example usage:

```sh
./run.sh up -d 
```

The above will deploy Khulnasoft on [http://localhost:8080](http://localhost:8080) with the indicated overlays.

```sh
./run.sh down
```

The above will tear down the local Khulnasoft instance that was set up using the previous command.
