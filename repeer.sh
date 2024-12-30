ceph_cluster_ns=rook-ceph
for pgid in $(kubectl -n "${ceph_cluster_ns}" exec -it deploy/rook-ceph-tools \
              -- ceph pg dump_stuck undersized -f json | sed 's/}ok/}/' | \
              jq -r '.stuck_pg_stats[] | .pgid')
do
    kubectl -n "${ceph_cluster_ns}" exec -it deploy/rook-ceph-tools -- ceph pg repeer "${pgid}"
done
