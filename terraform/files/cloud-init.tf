data "local_file" "ssh_public_key" {
  filename = "../id_rsa.pub"
}

resource "proxmox_virtual_environment_file" "cloud_init_config" {
  for_each = toset(var.pm_cluster_nodes)

  content_type = "snippets"
  datastore_id = "local"
  node_name    = each.value

  source_raw {
    data = <<-EOF
    #cloud-config
    timezone: America/Toronto
    users:
      - name: lab
        groups:
          - sudo
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /usr/bin/fish
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools fish
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config
        - systemctl restart sshd.service
        - echo "done" > /tmp/cloud-config.done
    power_state:
        delay: now
        mode: reboot
        message: Rebooting after cloud-init completion
        condition: true
    EOF

    file_name = "cloud-config.yaml"
  }
}
