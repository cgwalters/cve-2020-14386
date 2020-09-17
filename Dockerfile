# Yeah there are smaller containers but eh, I know this one
# and am not a fan of pulling gcc from Docker Hub.
FROM registry.svc.ci.openshift.org/coreos/cosa-buildroot as builder
WORKDIR /srv
COPY cve-cap-net-raw.c .
RUN gcc -Wall -o cve-cap-net-raw cve-cap-net-raw.c
FROM registry.fedoraproject.org/fedora:32
COPY --from=builder /srv/cve-cap-net-raw /usr/bin/cve-2020-14386
COPY wrapper.sh /usr/bin/cve-2020-14386-wrap
RUN setcap cap_net_raw+ep /usr/bin/cve-2020-14386
ENTRYPOINT ["/usr/bin/cve-2020-14386-wrap"]
