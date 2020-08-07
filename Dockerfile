FROM fedora:32

RUN mkdir /disks && \
    (cd /etc/yum.repos.d/ && \ 
	mkdir keep && mv fedora.repo fedora-updates.repo keep && \
	rm *.repo && mv keep/fedora.repo keep/fedora-updates.repo . && rmdir keep && \
        curl -LO https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo) && \
    dnf -y update && \
    dnf -y install \
        qemu-kvm \
        virt-v2v \
	virtio-win

ENV LIBGUESTFS_BACKEND=direct

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
