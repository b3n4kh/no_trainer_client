# no trainer client image

## Build

```bash
podman build -t ghcr.io/b3n4kh/no_trainer_client .
```


## Run

```bash
podman run -d --name=no_train_client -e CUSTOM_USER=user -e PASSWORD=password -p 3000:3000 --shm-size="1gb" ghcr.io/b3n4kh/no_trainer_client
```

## Nmap-Training

Das Image enthält die Teilnehmerunterlagen, vollständige NSE-Vorlage,
Argumentdateien und Hilfsscripts aus dem aktuellen Nmap-Training unter
[`etc/nmap-training/`](etc/nmap-training/README.md). Sie sind im Container unter
`/opt/nmap-training/` erreichbar; Bind-Mounts aus dem Präsentationsrepository
sind nicht mehr erforderlich. DNS-/Capture-Werkzeuge sowie die optionalen
SMB-/PostgreSQL-Clients werden beim Image-Build installiert.

Beim Start werden fehlende Arbeitskopien für den Desktop-Benutzer in
`~/nmap-training-results/` und `~/http-shop-policy.nse` angelegt. Neustarts und
`setup-training.sh` überschreiben keine vorhandenen Teilnehmerdateien.
Vor einer Neuerstellung des Containers die Ergebnisse weiterhin sichern.

`SCAN_NETWORK` (Standard `172.28.50.0/24`) und ein optionales `SCAN_INTERFACE`
konfigurieren das Übungsnetz. Ohne Interface-Vorgabe wird die direkte Netzroute
verwendet. Neue Desktop-Terminals und SSH-Shells exportieren auch `LAB_IF`,
`LAB_NET`, `LAB_DNS` und `LAB_DOMAIN`. Bei angeschlossenem Übungsnetz setzt der
Start die konkreten mDNS-/SSDP-Routen; dafür `NET_ADMIN` erlauben, für Raw Scans
auch `NET_RAW`. Außerhalb des Labs werden ohne passende Route keine Routen gesetzt.

Die Referenzdateien wurden aus `../presentations/nmap-training/scripts/` und
`../presentations/nmap-training/static/` übernommen. Bei Kursänderungen die
betroffenen Kopien hier aktualisieren und das Image neu bauen. Das gebaute Image
muss vor dem volume-freien Classroom-Start auf dem Trainingshost verfügbar sein.

```bash
python3 tests/check_training.py
```
