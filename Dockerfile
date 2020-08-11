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

ENV LIBGUESTFS_BACKEND=direct

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
