running
```bash
docker run --rm -i quay.io/coreos/butane:latest < file.yml > file.json
docker run --rm -i -v "${PWD}":/pwd --workdir /pwd quay.io/coreos/butane:latest -d /pwd < file.yml > file.ign
```

