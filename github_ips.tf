variable "url" {
  default = "https://api.github.com/meta"
}

data "external" "github_ips" {
  program = ["sh", "${path.module}/github_ips.sh"]

  query = {
    url = "${var.url}"
  }
}

locals {
  hooks    = "${split(",", data.external.github_ips.result.hooks)}"
  web      = "${split(",", data.external.github_ips.result.web)}"
  api      = "${split(",", data.external.github_ips.result.api)}"
  git      = "${split(",", data.external.github_ips.result.git)}"
  pages    = "${split(",", data.external.github_ips.result.pages)}"
  importer = "${split(",", data.external.github_ips.result.importer)}"
}

output "hooks" {
  value = "${local.hooks}"
}

output "web" {
  value = "${local.web}"
}

output "api" {
  value = "${local.api}"
}

output "git" {
  value = "${local.git}"
}

output "pages" {
  value = "${local.pages}"
}

output "importer" {
  value = "${local.importer}"
}
