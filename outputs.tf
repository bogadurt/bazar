output "bazar_url" {
  value = azurerm_linux_web_app.webApp.default_hostname
}

output "bazar_ips" {
  value = azurerm_linux_web_app.webApp.outbound_ip_addresses
}