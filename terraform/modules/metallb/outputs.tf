output "metallb_chart_status" {
  value = helm_release.metallb.status
}
