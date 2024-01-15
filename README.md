# Hiveon ASIC hub

> https://hiveon.com/knowledge-base/ASIC-Hub/getting_started/installation-linux/

## Docker hub

```
https://hub.docker.com/r/soudasuwa/hiveon-asic-hub
```

## Quick start

```
docker run -p 8800:8800 --env FARM_HASH=PLACE_YOUR_FARM_HASH_HERE_40_CHARS --rm soudasuwa/hiveon-asic-hub
```

## Modifications

`install.sh`
 - Removed uninstall
 - Removed service
 - Fully non-interactive
 - Simplified structure

## Application
### Ports

Application runs on `8800` over http

### Environment

Set `FARM_HASH` to auto register  
> https://hiveon.com/knowledge-base/ASIC-Hub/getting_started/first-setup/

### Persistance

Mount `/var/lib/asic-hub/data.db` file

## Deployment

### Build

```
docker build --pull --rm -f "Dockerfile" -t hiveon-asic-hub:latest "."
```

### Test

```
docker run -p 8800:8800 --env FARM_HASH=PLACE_YOUR_FARM_HASH_HERE_40_CHARS --rm hiveon-asic-hub
```

### Tag

```
docker tag hiveon-asic-hub soudasuwa/hiveon-asic-hub
```

### Push to Docker hub

```
docker push soudasuwa/hiveon-asic-hub
```
