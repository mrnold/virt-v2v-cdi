FROM centos:8

RUN mkdir /disks && \
    yum -y update && \
    rm -rf /var/cache/yum && \
    yum install -y \
        qemu-img \
        qemu-kvm \
        virt-v2v \
        virtio-win && \
    yum clean all

# Get Linux Qemu Guest Agent and Windows VirtIO drivers
COPY bin/grab_qemu_ga /tmp/grab_qemu_ga
RUN /tmp/grab_qemu_ga && \
    rm -fv /tmp/grab_qemu_ga

ENV LIBGUESTFS_BACKEND=direct

COPY bin/entrypoint /usr/bin/entrypoint

ENTRYPOINT ["/usr/bin/entrypoint"]
