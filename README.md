# Scripts Stack (Docker Swarm)

This repository is a lightweight reference layer for a Docker Swarm service running behind Traefik.

### It is a copy from real scripts files (this needs to be automated).

---

## ⚠️ Important

This repository does NOT contain real data.

It links to:

- `/swarm/config/scripts/listFiles.conf`
- `/swarm/data/scripts`

This means:
- It only works on systems where `/swarm` exists
- It is NOT portable without those paths

---

## Structure

- `config/listFiles.conf` -> linked from `/swarm/config/scripts/listFiles.conf`

- `data/scripts/` -> linked from `/swarm/data/scripts`

- `docker-stack.yml`

---

## Deploy

```bash
docker stack deploy -c docker-stack.yml scripts

