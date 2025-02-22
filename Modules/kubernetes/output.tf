output "cluster_ips" {
  description = "The Ips of the Kubernetes Clusters"
  value       = { for k, v in googoogle_container_cluster.primary : k => v.endpoint }
}
