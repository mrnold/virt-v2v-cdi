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

# Get Linux packages of qemu guest agent
COPY grab_qemu_ga.sh /usr/bin/grab_qemu_ga.sh
RUN chmod +x /usr/bin/grab_qemu_ga.sh && \
    /usr/bin/grab_qemu_ga.sh && \
    rm -fv /usr/bin/grab_qemu_ga.sh

ENV LIBGUESTFS_BACKEND=direct

# Add entrypoint and set exec bit
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

USER ${USER_UID}
