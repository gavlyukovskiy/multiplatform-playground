FROM oraclelinux:9 AS rootfs-builder

ARG TARGETPLATFORM
ARG TARGETARCH
ARG ROOTFS_DIR="/tmp/rootfs"

RUN echo "${TARGETPLATFORM}, ${TARGETARCH}"

RUN mkdir -p ${ROOTFS_DIR}/ \
    && dnf repolist \
    && dnf --releasever=9 --installroot=${ROOTFS_DIR} install curl glibc-langpack-en sed shadow-utils tar unzip util-linux dnf

FROM scratch

COPY --from=rootfs-builder /tmp/rootfs/ /

ENV TZ="Europe/Amsterdam"

CMD ["/bin/bash"]
