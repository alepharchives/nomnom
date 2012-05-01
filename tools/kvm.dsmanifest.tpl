{
  "name": "NAME",
  "version": "VERSION",
  "type": "zvol",
  "cpu_type": "host",
  "description": "DESCRIPTION",
  "created_at": "DATE",
  "updated_at": "2011-11-19T00:04:52.389Z",
  "os": "linux",
  "image_size": "VOL_SIZE",
  "files": [
    {
      "path": "NAME-VERSION.zvol.gz",
      "sha1": "SHA",
      "size": SIZE,
      "url": "SERVER/datasets/UUID/NAME-VERSION.zvol.gz"
    }
  ],
  "requirements": {
    "networks": [
      {
        "name": "net0",
        "description": "public"
      }
    ],
    "ssh_key": true
  },
  "disk_driver": "virtio",
  "nic_driver": "virtio",
  "uuid": "UUID",
  "creator_uuid": "CREATOR_UUID",
  "creator_name": "CREATOR_NAME",
  "platform_type": "smartos",
  "cloud_name": "CLOUD_NAME",
  "urn": "CLOUD_NAME:CREATOR_NAME:NAME:VERSION",
  "vendor_uuid": "VENDOR_UUID",
  "published_at": "2011-11-19T00:04:52.389Z",
  "_url": "SERVER/datasets"
}
